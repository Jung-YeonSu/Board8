<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" type="image/png" href="/img/favicon.png" />
<link rel="stylesheet"  href="/css/common.css" />
<style>
	main{position: relative;}

   span{
   	position: absolute;
   	top: 0;
   	right: 0
   }
</style>
</head>
<body>
  <main>
	<h2>Home입니다</h2>
	<div><a href="/Menus/WriteForm">새 메뉴 추가</a></div>
	<div><a href="/Menus/WriteForm2">새 메뉴 추가2</a></div>
	<div><a href="/Menus/List">메뉴 목록</a></div>	
	<div>&nbsp;</div>	
	<div><a href="/Users/List">사용자 목록</a></div>	
	<div><a href="/Users/WriteForm">사용자 추가</a></div>
	<div>&nbsp;</div>	
	<div><a href="/Board/List?menu_id=all">게시물 목록</a></div>	
	<div><a href="/Board/WriteForm?menu_id=MENU01">게시물 추가</a></div>	
	<div>&nbsp;</div>	
	<div><a href="/BoardPaging/List?nowpage=1&menu_id=MENU01">게시물 목록(페이징)</a></div>	
	<div><a href="/BoardPaging/WriteForm?nowpage=1&menu_id=MENU01">게시물 추가(페이징)</a></div>	
	<div>&nbsp;</div>	
	<div><a href="/Pds/List?nowpage=1&menu_id=MENU01">자료실 목록</a></div>
	<div><a href="/Pds/WriteForm?nowpage=1&menu_id=MENU01">자료실 등록</a></div>
	<span>
		${sessionScope.login.username != null ? sessionScope.login.username : "<a href='/Users/LoginForm'>로그인</a>"}
		${sessionScope.login.username != null ? "<a href='/Users/Logout'>로그아웃</a>" : ""}
	</span>
  </main>	
</body>
</html>






