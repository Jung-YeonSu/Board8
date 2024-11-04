<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	.red { color : red}
	.green{color : green}

</style>
</head>
<body>
	<main>
		<form action="" method="get">
			<h2>[ID 중복 확인]</h2>
			<input type="Text" name="userid" value="${param.userid}">
			<input type="submit" value="검색">
		</form>		
		<div style="height: 20px"></div>
		<c:choose>
			<c:when test="${userVo eq null}">
				<p class="green">
					${param.userid}는 사용가능한 아이디입니다.
					<input type="button" value="ID 사용하기" id="close-btn">
				</p>					
			</c:when>
			<c:otherwise>
				<p class="red">
					${param.userid}는 중복된 아이디입니다.
				</p>
			</c:otherwise>
		</c:choose>
	</main>	
	<script>
		const $closeBtn = document.querySelector("#close-btn");
		
		$closeBtn.onclick = function(){
			// 넘겨줄 창의 userid에 조회된 결과를 보낸다.
			// 넘겨줄 창(내 창을 open한 window) : window.opener -> mf
			// 내창 : window                                    -> cf
			const $mfUserid = window.opener.document.querySelector("[name='userid']");
			const $cfUserid = document.querySelector("[name='userid']");
			$mfUserid.value = $cfUserid.value;
			window.close();
		}
	</script>
</body>
</html>