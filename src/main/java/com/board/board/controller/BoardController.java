package com.board.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.board.board.mapper.BoardMapper;
import com.board.board.vo.BoardVo;
import com.board.menus.mapper.MenuMapper;
import com.board.menus.vo.MenuVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/Board")
public class BoardController {
	
	@Autowired
	private MenuMapper menuMapper;
	
	@Autowired
	private BoardMapper boardMapper;
	
	// Board/List
	@RequestMapping("/List")
	public ModelAndView list(MenuVo menuVo) {
		log.info("-----------------");
		String 		 menu_id   = menuVo.getMenu_id();
			List<MenuVo> menuList = menuMapper.getMenuList();
			ModelAndView mv = new ModelAndView();		
			mv.setViewName("board/list");
			mv.addObject("menuList", menuList);
			mv.addObject("menu_id", menu_id);
			mv.addObject("menuVo", menuVo);
		if(menu_id.equals("all")) {
			List<BoardVo> boardList = boardMapper.getBoardListAll();
			mv.addObject("boardList", boardList);
			mv.addObject("menu_name", "전체");
			return 		 mv;
		}else {
			MenuVo 		 mVo = menuMapper.getMenu(menuVo);
			String 		 menu_name = mVo.getMenu_name();
			mv.addObject("menu_name", menu_name);
			List<BoardVo> boardList = boardMapper.getBoardList(menu_id);
			mv.addObject("boardList", boardList);
			return 		 mv;
		}
	}
	
	@RequestMapping("/WriteForm")
	public ModelAndView writeForm() {
		// option태그 forEach를 위한 menuList[]
		List<MenuVo> menuList = menuMapper.getMenuList();

		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/writeForm");
		mv.addObject("menuList", menuList);
		return mv;
	}
	
	@RequestMapping("/Write")
	public ModelAndView write(BoardVo boardVo) {
		// 글쓰기
		boardMapper.insertBoard(boardVo);
		
		// 목록조회
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/Board/List?menu_id=all");
		return mv;
	}
	
	@RequestMapping("/Delete")
	public ModelAndView delete(BoardVo boardVo) {
		// SQL - DELETE
		boardMapper.deleteBoard(boardVo);		

		// 목록조회
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/Board/List?menu_id=all");
		return mv;
	}
	
	@RequestMapping("/UpdateForm")
	public ModelAndView updateForm(BoardVo boardVo) {
		// option태그 forEach를 위한 menuList[]
		List<MenuVo> menuList = menuMapper.getMenuList();
		
		// 입력값 불러오기 위한 SQL SELECT
		BoardVo vo = boardMapper.getBoard(boardVo);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/updateForm");
		mv.addObject("menuList",menuList);
		mv.addObject("vo", vo);
		return mv;
	}
	
	@RequestMapping("/Update")
	public ModelAndView update(BoardVo boardVo) {
		// SQL-UPDATE
		boardMapper.updateBoard(boardVo);
		
		// 목록조회
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/Board/List?menu_id=all");
		return mv;
	}
	
	@RequestMapping("/Content")
	public ModelAndView content(BoardVo boardVo) {
		List<MenuVo> menuList = menuMapper.getMenuList();
		boardMapper.updateHit(boardVo);
		BoardVo vo = boardMapper.getBoard(boardVo);
		// 조회한 글의 content 부분의 '\n' -> '<br>'
		// 출려하는 곳이 태그라 '\n'은 공백으로 처리해서 <br>로 줄바꿈 처리 해야됨.
		String content = vo.getContent().replace("\n", "<br>");
		vo.setContent(content);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/content");
		mv.addObject("menuList",menuList);
		mv.addObject("vo",vo);
		return mv;
	}
	
}
