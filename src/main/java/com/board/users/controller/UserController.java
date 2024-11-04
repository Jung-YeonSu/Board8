package com.board.users.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.board.users.mapper.UserMapper;
import com.board.users.vo.UserVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Users")
public class UserController {
	@Autowired
	private UserMapper userMapper;
	
	@RequestMapping("/WriteForm")
	public ModelAndView writeForm(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("users/write");
		return mv;
	}
	
	@RequestMapping("/Write")
	public ModelAndView write(UserVo vo) {
		// write.jsp가 넘겨준 데이터를 저장 
		userMapper.insertUser(vo);
		
		// list.jsp로 이동
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/Users/List");
		return mv;
	}
	
	@RequestMapping("/List")
	public ModelAndView list() {
		List<UserVo> userList = userMapper.getUserList();
		System.out.println();
		// list.jsp로 이동
		ModelAndView mv = new ModelAndView();
		mv.setViewName("users/list");
		mv.addObject("userList",userList);
		return mv;
	}
	
	@RequestMapping("/Delete")
	public ModelAndView delete(UserVo vo) {
		// 삭제
		userMapper.deleteUser(vo);
		
		// list.jsp로 이동
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/Users/List");
		return mv;
	}
	
	@RequestMapping("/UpdateForm")
	public ModelAndView updataForm(UserVo vo) {
		UserVo user = userMapper.getInfo(vo);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("users/update");
		mv.addObject("user",user);
		return mv;
	}
	
	@RequestMapping("/Update")
	public ModelAndView update(UserVo vo) {
		userMapper.updateUser(vo);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/Users/List");
		return mv;
	}
	
	//-----------------------------------------
	// 새창방식
	@RequestMapping("/DupCheck")
	public ModelAndView DupCheck(UserVo vo) {
		// 중복확인을 위한 조회
		UserVo userVo = userMapper.getInfo(vo);
		
		
		// 결과를 새창에 출력할 jsp를 리턴
		ModelAndView mv = new ModelAndView();
		mv.setViewName("users/dupCheck");              // 새창에 보여줄 jsp
		mv.addObject("userVo",userVo);   // jsp로 넘길 데이터
		return mv;
	}
	
	
	// ajax 방식 호출
	// 아이디 중복확인 - 페이지를 변경하지 않고 data 조회
	// 비동기 호출로 구현 AJAX
	// /Users/IdDupCheck?userid=aaa
	@RequestMapping(
			value   = "/IdDupCheck",
			method  = RequestMethod.GET,
			headers = "Accept=application/json")  // 결과를 json으로 처리
	@ResponseBody                                 // 리턴값으로 json을 받겠다
	 public UserVo idDupCheck(String userid) {
		UserVo userVo = userMapper.idDupCheck(userid);
		return userVo;
	}
	
	@GetMapping("/LoginForm")
	public String LoginForm(String uri,String menu_id, int nowpage, Model model) {
		model.addAttribute("uri",uri);
		model.addAttribute("menu_id",menu_id);
		model.addAttribute("nowpage",nowpage);
		return "users/login";
	}	
	
	@PostMapping("/Login")
	public String Login(HttpServletRequest requset,
					    HttpServletRequest response ) {

		String 		 userid = requset.getParameter("userid");
		String 		 passwd = requset.getParameter("passwd");
		String 		 uri = requset.getParameter("uri");
		String 		 menu_id = requset.getParameter("menu_id");
		String 		 nowpage = requset.getParameter("nowpage");
		System.out.println(menu_id);
		// db 조회
		UserVo 		 vo     = userMapper.login(userid,passwd);
		//System.out.println(vo);
		
		HttpSession session = requset.getSession();
		session.setAttribute("login", vo);
		return "redirect:/" + uri + "/List?menu_id=" +menu_id+ "&nowpage=" + nowpage;
	}	
	
	// /Users/Logout
	@RequestMapping(
		value =	"/Logout",
		method = RequestMethod.GET)
	public String Logout(
			HttpServletRequest requset,
			HttpServletRequest response,
			HttpSession        session) {
		//Object url = session.getAttribute("URL");
		session.invalidate();
		//return "redirect:" + (String)url;
		return "redirect:/" ;
	}
	
	
}
