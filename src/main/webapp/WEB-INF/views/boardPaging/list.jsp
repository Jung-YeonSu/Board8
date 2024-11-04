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
#table {
	width: 100%;
	border: none;
	&
	tr
	{
	border-bottom
	:
	solid
	1px
	#ccc;
}

;
&
td {
	padding: 16px 0;
	text-align: center;
	border: none;
}

;
&
tr:first-child {
	border-top: solid 1px #333;
	border-bottom: solid 1px #767676;
	font-weight: bold;
}

&
tr:nth-child(2) td {
	text-align: center;
}

}
ul {
	margin-top: 24px;
	display: flex;
	justify-content: center;
	gap: 8px; &
	li: last-child{ 
			color: #777
}


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


</style>
</head>
<body>
	<main>
		<%@include file="/WEB-INF/include/pagingMenus.jsp"%>
		<h2>${menu_name}게시물 목록 [${sessionScope.login.userid}]</h2>
		<table id="table">
			<colgroup>
				<col width="12.5%">
				<col width="45%">
				<col width="12.5%">
				<col width="17.5%">
				<col width="12.5%">
			</colgroup>
			<tr>
				<td>번호</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
			</tr>
			<tr>
				<td colspan="4"></td>
				<td>[<a
					href="/BoardPaging/WriteForm?menu_id=${menu_id == null? 'all' : menu_id}&nowpage=${nowpage}">새
						글 추가</a>]
				</td>
			</tr>
			<c:forEach var="board" items="${response.list}">
				<tr>
					<td>${board.idx}</td>
					<td style="text-align: left; padding-left: 12px"><a
						href="/BoardPaging/Content?idx=${board.idx}&menu_id=${menu_id}&nowpage=${nowpage}">${board.title}</a>
					</td>
					<td>${board.writer}</td>
					<td>${board.regdate}</td>
					<td>${board.hit}</td>
				</tr>
			</c:forEach>
		</table>
		<%@include file="/WEB-INF/include/paging.jsp"%>
	</main>
	<script>
		const url = "${menu_id}"
		const $menus = document.querySelectorAll("#menu li");

		if (url === "all") {
			$menus[0].classList.add("menu-active");
		} else {
			const index = parseInt(url.slice(-2))
			$menus[index].classList.add("menu-active");
		}
		
		const nowpage = ${nowpage}
		
		const tds = document.querySelectorAll("#paging td")
		if(nowpage < 11){
			tds[nowpage-1].style.color = "skyblue"
			tds[nowpage-1].style.fontWeight = "bold"			
		}else{
			let tdIndex = nowpage.toString().slice(1);
			if(tdIndex.includes("0")){
			tdIndex = 10;				
			}
			console.log(tdIndex)
			tds[tdIndex].style.color = "skyblue"
			tds[tdIndex].style.fontWeight = "bold"
		}
		
		console.log(nowpage.toString().slice(1))
	</script>
</body>
</html>








