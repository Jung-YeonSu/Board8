<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h2>메뉴 등록</h2>
		<form action="/Menus/Write" method="POST">
			<table>
				<tr>
					<td>메뉴 아이디</td>
					<td><input type="text" name="menu_id"></td>
				</tr>
				<tr>
					<td>메뉴 이름</td>
					<td><input type="text" name="menu_name"></td>
				</tr>
				<tr>
					<td>메뉴 순서</td>
					<td><input type="number" name="menu_seq"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="추가" name="submit_btn">
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