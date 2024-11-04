<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

#menu a{
		display : block;
		width: 100%;
		padding : 12px;
	}
	
table, tr, td{
	border: none;
	background: #fff;
	height: 100%
}

table {
	width: 100%;
}

.menu-active a{
			background : #333;
			color : white;
}

input,select,textarea{
	border:none
}

input[name="title"]{
	width: 100%;
	font-size: 32px;
	font-weight: bold;
	
}

textarea{
	width: 100%;
	height: 40vh
}

input[type="text"], select, textarea{
	padding : 12px;
	resize: none;
	border-radius: 8px;
}

select{
	border : solid 1px #ddd
}

.util{
	text-align: center;
	border-top : solid 4px #eee;
}

.util-btn{
	padding : 12px 24px;
	background: none;
	border: solid 1px #333;
	border-radius: 8px;
	margin: 24px 4px;
	cursor: pointer;
}

.util-btn:last-child {
	border: solid 1px #767676;
	color: #767676;
}

</style>
</head>
<body>
	<main>
		<%@include file="/WEB-INF/include/pagingMenus.jsp" %>
		<form action="/BoardPaging/Write" method="GET">
			<ul id="table">
				<li>
					<input type="text" name="title" placeholder="제목">
				</li>
				<li>
					<input type="text" name="writer" placeholder="작성자" value="${login.username}" readonly="readonly">
					<select name="menu_id">
						<c:forEach var="menu" items="${menuList}">
							<c:choose>
								<c:when test="${vo.menu_id eq menu.menu_id }">
									<option selected="selected" value="${menu.menu_id}">${menu.menu_name}</option>
								</c:when>								
								<c:otherwise>
									<option value="${menu.menu_id}">${menu.menu_name}</option>	
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</li>
				<li>
					<textarea name="content" placeholder="내용"></textarea>
				</li>
				<li class="util">
						<input type="submit" value="등록"
						name="submit_btn" class="util-btn"> <input type="button"
						value="목록" id="goList" class="util-btn">
				</li>
			</ul>
		</form>
	</main>
	<script type="text/javascript">
	const $goBtn = document.querySelector("#goList");
	$goBtn.addEventListener("click",function(){
		location.href='/Board/List?menu_id=all'
	})

		
			const $menus = document.querySelectorAll("#menu li");
			$menus[0].classList.add("menu-active");

	</script>
</body>
</html>