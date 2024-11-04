<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<main>
		<form action="/Users/Login" method="POST">
			  <input type="hidden" name="uri" value="${uri}">
			  <input type="hidden" name="menu_id" value="MENU01">
			  <input type="hidden" name="nowpage" value="1">
				<h2>로그인</h2>
				<table>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="userid" value="aaa"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type="password" name="passwd" value="aaa"></td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="로그인"></input></td>
					</tr>
				</table>
		</form>
	</main>
</body>
</html>