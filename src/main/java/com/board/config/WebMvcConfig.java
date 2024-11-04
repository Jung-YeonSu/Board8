package com.board.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.board.intercepter.AuthInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	@Autowired
	private AuthInterceptor authinterceptor;

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// authInterceptor 를 동작시킬때 모든 페이지(/**)를 대상으로 한다
		// http://localhost:9090 밑의 모든 파일
		// 제외 "/css/**", "/js/**", "/img/**" 경로는 interceptor의 대상아님
		// .addPathPatterns("/Board/**")
		// http://localhost:9090/Board 밑의 모든 파일
		

		registry.addInterceptor(authinterceptor)
			  //.addPathPatterns("/**")
				.addPathPatterns("/Board/**","/BoardPaging/**")
				.excludePathPatterns("/css/**","/js/**","/img/**");
		
		
		WebMvcConfigurer.super.addInterceptors(registry);
	}
}