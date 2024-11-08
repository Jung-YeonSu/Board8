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

#table{
	width : 100%;
	border : none;
	
	& tr{
		border-bottom : solid 1px #ccc;
	};
	
	
	& td{
		padding : 16px 0 ;
		text-align: center;
		border : none;
	};
	
	& tr:first-child {
		border-top : solid 1px #333;
		border-bottom : solid 1px #767676;
		font-weight: bold;}
		
	& tr:nth-child(2) td {text-align: center;}	
	}
	#paging table {
	position: absolute;
	bottom : 160px;
	left : 50%;
	width : 60%;
	transform: translateX(-50%);
	border: none;
	& tr, td {
	border: none
	};
	& td{
		padding : 8px;
		text-align: center
	}
	
	& td:first-child a, td:last-child a{
		width : 60px;
	}
	
	& a{
		margin : 0 5px}
	
}

.searchForm{
	margin: 60px auto;
	text-align: center
}
	
</style>
</head>
<body>
	<main>
		<%@include file="/WEB-INF/include/pdsMenus.jsp" %>
	
		<h2>${menu_name} 게시물 목록 ${sessionScope.login.userid ? sessionScope.login.userid : ""}</h2>
		<table id="table">
			<colgroup>
				<col width="12.5%">
				<col width="32.5%">
				<col width="12.5%">
				<col width="17.5%">
				<col width="12.5%">
				<col width="12.5%">
			</colgroup>
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>파일수</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
			<tr>
			<td colspan="5"></td>
				<td>[<a href="/Pds/WriteForm?menu_id=${menu_id == null? 'all' : menu_id}&nowpage=${map.nowpage}">새 글 추가</a>]
				</td>
			</tr>
			<c:forEach var="pds" items="${response.list}">
				<tr>
					<td>${pds.idx}</td>
					<td style="text-align: left; padding-left:12px">
						<a href="/Pds/View?idx=${pds.idx}&menu_id=${map.menu_id}&nowpage=${map.nowpage}">${pds.title}</a>
					</td>
					<td>${pds.writer}</td>
					<td>${pds.filesCount}</td>
					<td>${pds.regdate}</td>
					<td>${pds.hit}</td>
				</tr>
			</c:forEach>
		</table>
		<%@include file="/WEB-INF/include/pdsPaging.jsp" %>
		<div class="searchForm">
			<form action="/Pds/List" method="GET">
				<input type="hidden" name="menu_id" value="${map.menu_id}"/>
				<input type="hidden" name="nowpage" value="${map.nowpage}"/>
				<select name="search">
					<option value="title">제목</option>
					<option value="writer">작성자</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="searchtext"/>
				<input type="submit" value="검색"/>
			</form>		
		</div>
		
	</main>
<script>
	const url = "${map.menu_id}"
	const $menus = document.querySelectorAll("#menu li");
	
	if(url === "all"){
		$menus[0].classList.add("menu-active");
	}else{
		const index = parseInt(url.slice(-2))
		$menus[index].classList.add("menu-active");
	}
</script>
</body>
</html>








