<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css"/>
<style>
	table{width : 100%};
	tbody td{height: 50px}

table td:first-child:not([colspan]){background: #333; color:white; padding: 10px;border-bottom : solid 1px #fff}
table tr:nth-of-type(3) td:first-child{border : none}
table tr:last-of-type{text-align: center}

	input[type="text"],input[type="number"]{width:100%; padding : 10px}
	
	td[colspan]{padding : 10px}

</style>
</head>
<body>
	<main>
		<h2>메뉴 수정</h2>
		<form action="/Menus/Update" method="GET">
			<table>
				<tr>
					<td>메뉴 아이디</td>
					<td><input type="text" name="menu_id" value="${menu.menu_id}" readonly="readonly"></td>
				</tr>
				<tr>
					<td>메뉴 이름</td>
					<td><input type="text" name="menu_name" value="${menu.menu_name}"></td>
				</tr>
				<tr>
					<td>메뉴 순서</td>
					<td><input type="number" name="menu_seq" value="${menu.menu_seq}"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="수정" name="submit_btn">
						<input type="button" value="목록" id="goList">					
					</td>
				</tr>
			</table>
		</form>
	</main>
		<script>
		$goBtn = document.querySelector("#goList");
		$goBtn.addEventListener("click",function(){
			location.href="/Menus/List"
		})
	
	</script>
</body>
</html>