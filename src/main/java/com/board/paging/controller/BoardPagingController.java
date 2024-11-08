package com.board.paging.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.board.board.vo.BoardVo;
import com.board.menus.mapper.MenuMapper;
import com.board.menus.vo.MenuVo;
import com.board.paging.mapper.BoardPagingMapper;
import com.board.paging.vo.Pagination;
import com.board.paging.vo.PagingResponse;
import com.board.paging.vo.SearchVo;

@Controller
@RequestMapping("/BoardPaging")
public class BoardPagingController {
	
	@Autowired
	private  MenuMapper         menuMapper;
	
	@Autowired
	private  BoardPagingMapper  boardPagingMapper;
	
	// /BoardPaging/List?nowpage=1&menu_id=MENU01
	@RequestMapping("/List")
	public   ModelAndView   list(int nowpage, BoardVo  boardVo) {
		// 메뉴 목록
		List<MenuVo>  menuList =  menuMapper.getMenuList();
		// 게시물 목록 조회 (페이징해서)
		//   해당하는 자료수가 1 보다 작으면
		//   응답 데이터에 비어있는 리스트와 null 을 담아 리턴 
		// count : boardVo 안의 menu_id 에 해당하는 총자료수
		
		String 	menu_id 	= boardVo.getMenu_id();
		int  count  = boardPagingMapper.count(boardVo);
		if(menu_id.equals("all")) {
			count  = boardPagingMapper.countAll(boardVo);
		}
		
		
	    PagingResponse<BoardVo> response = null;
	    if( count < 1 ) { // 현재 조회한 자료가 없다면
	    	response = new PagingResponse<>(
	    		Collections.emptyList(), null);
	    }
	    
	    // 페이징을 위한 초기 설정
	    SearchVo searchVo = new SearchVo();
	    searchVo.setPage(nowpage);      // 현재 페이지 정보
	    searchVo.setRecordSize(10);     // 페이지당 10개
	    searchVo.setPageSize(10);       // paging.jsp에 출력할 페이지번호수
	    
	    // Pagination 설정
	    
	    Pagination pagination = new Pagination(count, searchVo);
	    searchVo.setPagination(pagination);
	    
	    String 	title		= boardVo.getTitle();
	    String 	content		= boardVo.getContent();
	    String 	writer		= boardVo.getWriter();
	    int 	offset		= searchVo.getOffset();
	    int		recordSize	= searchVo.getRecordSize();
	    

    	List<BoardVo> list = boardPagingMapper.getBoardPagingList(
    			menu_id,title, content, writer,offset,recordSize);
	    
	    
	    if(menu_id.equals("all")) {
	    	 list = boardPagingMapper.getAllBoardPagingList(
	 	    		title, content, writer,offset,recordSize);
	    }
	    
	    	
	    response = new PagingResponse<>(list, pagination);
	    System.out.println(pagination);
	    
				
		ModelAndView  mv  =  new  ModelAndView();
		mv.addObject("response",response);
		mv.addObject("menu_id",menu_id);
		mv.addObject("nowpage",nowpage);		
		mv.addObject("searchVo",searchVo);		
		mv.addObject("menuList",menuList);
		mv.setViewName("boardPaging/list");
		return        mv;
	}
	
	// 게시글 조회 - 조회수 증가
	//BoardPaging/Content?idx=935&menu_id=all&nowpage=94
	@RequestMapping("/Content")
	public ModelAndView content(int nowpage, BoardVo boardVo) {
		
		// 메뉴 목록 조회
		List<MenuVo> menuList = menuMapper.getMenuList();
		
		// 조회수 증가
		boardPagingMapper.incHit(boardVo);
		
		BoardVo vo = boardPagingMapper.getBoard(boardVo);
		String content = vo.getContent().replace("\n", "<br>");
		vo.setContent(content);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("boardPaging/content");
		mv.addObject("menuList",menuList);
		mv.addObject("nowpage",nowpage);
		mv.addObject("vo",vo);
		return mv;
	}
	
	@RequestMapping("/WriteForm")
	public ModelAndView writeForm() {
		List<MenuVo> menuList = menuMapper.getMenuList();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("boardPaging/writeForm");
		mv.addObject("menuList",menuList);
		return mv;
	}
	
	@RequestMapping("/Write")
	public ModelAndView write(BoardVo boardVo) {
		boardPagingMapper.insertBoard(boardVo);
		
		String menu_id = boardVo.getMenu_id();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/BoardPaging/List?menu_id="+ menu_id +"&nowpage=1");
		return mv;
	}
	
	@RequestMapping("/Delete")
	public ModelAndView delete(BoardVo vo) {
		boardPagingMapper.deleteBoard(vo);
		
		String menu_id = vo.getMenu_id();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/BoardPaging/List?menu_id="+ menu_id +"&nowpage=1");
		return mv;
	}
	
	@RequestMapping("/UpdateForm")
	public ModelAndView updateForm(BoardVo boardVo, int nowpage) {
		List<MenuVo> menuList = menuMapper.getMenuList();
		BoardVo vo = boardPagingMapper.getBoard(boardVo);
		String menu_id = boardVo.getMenu_id();
		
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("vo",vo);
		mv.addObject("menu_id",menu_id);
		mv.addObject("menuList",menuList);
		mv.addObject("nowpage",nowpage);
		mv.setViewName("boardPaging/updateForm");
		return mv;
		
	}
	@RequestMapping("/Update")
	public ModelAndView update(BoardVo boardVo, int nowpage) {
		boardPagingMapper.updateBoard(boardVo);
		String menu_id = boardVo.getMenu_id();
		
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/BoardPaging/List?menu_id=" + menu_id + "&nowpage=" + nowpage);
		return mv;
		
	}
}







