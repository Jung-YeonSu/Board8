package com.board.menus.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.board.menus.mapper.MenuMapper;
import com.board.menus.vo.MenuVo;


@Controller
@RequestMapping("/Menus")
public class MenuController {
	
	@Autowired
	private  MenuMapper  menuMapper;
	
	// 메뉴 목록 조회  /Menus/List
	@RequestMapping("/List")   
	public   String   list( Model model ) {
		// 조회한결과를 ArrayList 로 돌려준디
		List<MenuVo> menuList = menuMapper.getMenuList();
		// 조회 결과를 넘겨준다 ( Model )
		// 뷰에서 사용할 key와 value를 설정
		model.addAttribute("msg","10.01~10.02");
		model.addAttribute("menuList",menuList);
		//System.out.println( "MenuController list() menuList:" + menuList );
		//뷰를 찾기 위해 사용할 경로
		return "menus/list";
	}
	
	// /Menus/WriteForm
	// 새 메뉴 추가기능
	@RequestMapping("/WriteForm")
	public String writeform() {
		return "menus/write";
	}
	
	// /Menus/Write
	@RequestMapping("Write")
	public String write(
			MenuVo menuVo, Model model
			) {
		// 넘어오는 값을 받아서 db에 저장하고
		menuMapper.insertMenu(menuVo);
		
		return "redirect:/Menus/List";
		/*
		// list.jsp 에 출력할 data를 조회하고 model에 담는다
		List<MenuVo> menuList = menuMapper.getMenuList();
		
		model.addAttribute("menuList", menuList);
		
		// 목록보기 페이지로 이동
		return "menus/list";
		*/
	}
	
	// /Menus/WriteForm
	// 새 메뉴 추가기능
	@RequestMapping("/WriteForm2")
	public String writeform2() {
		return "menus/write2";
	}
	@RequestMapping("/Write2")
	public String write2(MenuVo menuvo, Model model) {
		// 메뉴 추가
		menuMapper.insertMenu2(menuvo);
		
		
		// 목록조회로 감
		return "redirect:/Menus/List";
	}

	@RequestMapping("/Delete")
	public String delete(MenuVo menuVo) {
		// 메뉴 삭제
		menuMapper.deleteMenu(menuVo);
		// 목록조회로 감
		return "redirect:/Menus/List";
	}
	
	@RequestMapping("/UpdateForm")
	public String updateFrom(MenuVo menuVo, Model model) {
		// 수정할 자료를 조회 (?menu_id=####)
		MenuVo menu = menuMapper.getMenu(menuVo);
		// 수정할 화면으로 이동
		model.addAttribute("menu",menu);
		
		
		return "menus/update";
	}
	
	@RequestMapping("/Update")
	public String update(MenuVo menuVo) {
		// 수정할 자료를 조회 (?menu_id=####)
		System.out.println(menuVo);
		menuMapper.updateMenu(menuVo);
		
		return "redirect:/Menus/List";
	}
	
}



