package com.board.intercepter;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class AuthInterceptor implements HandlerInterceptor {@Override
	
	// 전처리(로그인)
	public boolean preHandle(HttpServletRequest 	request, 
							 HttpServletResponse 	response, 
							 Object 				handler)
			throws Exception {
	

		String requestURI	= request.getRequestURI();
		String uri = requestURI.split("/")[1];
		
		// /Users/LoginForm, // /Users/Login 를 제외
		if(requestURI.contains("/Users/Login") || 
		   requestURI.contains("/Users/LoginForm")
		   ) {
			return true;
		}
		HttpSession session = request.getSession();
		// 사용자의 로그인 정보를 세션 메모리에 user 저장
		Object login = session.getAttribute("login");;
		if(login == null) {
			// 로그인이 안 돼있다 -> 로그인 페이지
			String menu_id = "MENU01";
			int nowpage = 1;
			String fmt = "/Users/LoginForm?uri=%s&menu_id=%s&nowpage=%d";
			System.out.println(fmt);
			String loc = String.format(fmt, uri, menu_id, nowpage);
			response.sendRedirect(loc);
			return false;
		}
		
		// preHandle 의 return문의 의미는 
		// 컨트롤러 요청 url로 가도 되나 안 되나를 결정
		// return : 컨트롤러 url로 가게 된다.
		
		/*
		String mid = (String) session.getAttribute("ID");
		System.out.println(mid);
		 */
		/*
		System.out.println("========== preHandle ==========");
		System.out.println("요청 주소 : " + request.getRequestURI() );
		*/
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}

/* 잘 안 씀
	// 후처리
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("========= postHandle =========");
		System.out.println("=============================" );
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
*/	
}
