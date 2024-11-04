<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" type="image/png" href="/img/favicon.png" />
<link rel="stylesheet" href="/css/common.css" />
<style>
main {
	width: 80%;
	margin: auto;
	color : #333
}

main table {
	width: 100%
}

tr:first-child {
	background: #333;
	color: white;
	font-weight: bold;
	
	& td:not(:last-child) {
	border-right: 1px solid white
 }
}

tr:nth-child(2) td{
	text-align: right;
}


/* SCSS(SASS 문법의 일종) 문법에 적용 */



td {
	padding: 10px;
	text-align: center;
}
</style>
</head>
<body>
	<main>
		<h2>유저 목록</h2>
		<table>
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>이메일</td>
				<td>포인트</td>
				<td>가입일</td>
				<td>삭제</td>
				<td>수정</td>
			</tr>
			<tr>
				<td colspan="7">[<a href="/Users/WriteForm">사용자 등록</a>]
				</td>
			</tr>
			<c:forEach var="user" items="${userList}">
				<tr>
					<td>${user.userid}</td>
					<td>${user.username}</td>
					<td>${user.email}</td>
					<td>${user.upoint}</td>
					<td>${user.regdate }</td>
					<td><a href="/Users/Delete?userid=${user.userid}">삭제</a></td>
					<td><a href="/Users/UpdateForm?userid=${user.userid}">수정</a></td>
				</tr>
			</c:forEach>
		</table>
	</main>

</body>
</html>








