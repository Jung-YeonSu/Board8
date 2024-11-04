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
table tr:nth-of-type(5) td:first-child{border : none}
table tr:last-of-type{text-align: center}

	
	input[type="text"],input[type="email"],input[type="password"]{width:100%; padding : 10px; border:none}
	td[colspan]{padding : 10px}

</style>
</head>
<body>
	<main>
		<h2>사용자 수정</h2>
		<form action="/Users/Update" method="POST">
			<table>
				<tr>
					<td>사용자 이름</td>
					<td><input type="text" name="username" value="${user.username}" readonly="readonly"></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="userid" value="${user.userid}" readonly="readonly"></td>
				</tr>
				<tr>
					<td>새 비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td>새 비밀번호 확인</td>
					<td><input type="password" name="passwd2"></td>
				</tr>
				<tr>
					<td>새 이메일</td>
					<td><input type="email" name="email" ></td>
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
		const $goBtn = document.querySelector("#goList");
		$goBtn.addEventListener("click",function(){
			location.href="/Users/List"
		})
	
		const $passwd = document.querySelector("input[name='passwd']");
		const $passwd2 = document.querySelector("input[name='passwd2']");
		const $email = document.querySelector("input[name='email']");
		
		const $form = document.querySelector("form");

		console.log($passwd.value === "")
		
		$form.onsubmit = function(){
			if($passwd.value.trim() === ""){
				alert("변경할 비밀번호를 입력해야합니다.")
				$passwd.focus();
				return false;
			} else if($passwd2.value.trim() === ""){
				alert("비밀번호 확인이 입력되지 않았습니다..")
				$passwd.focus();
				return false;
			} else if($passwd.value.trim() !== $passwd2.value.trim()){
				alert("비밀번호가 일치하지 않습니다.")
				$passwd.focus();
				return false;
			}
				return true;
		}
		
	</script>
</body>
</html>