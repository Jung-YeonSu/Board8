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

h2, table {
	width: 100%;
}

h2{
	font-size: 32px;
	padding-bottom : 12px;
	position : relative;
	
	& a{
		font-size : 12px;
		position: absolute;
		color : #888;
	}
}


input[type="text"], textarea{
	width: 100%;
	padding: 10px;
	height : 100%;
	border: solid 1px #767676;
	resize: none;
	border-radius: 8px
}



#table td{
	padding: 12px
}

span {
	font-size: 12px
}

.util-btn {
	padding: 8px 14px;
	font-size: 12px;
	background: none;
	border: solid 1px #767676;
	border-radius: 8px;
	cursor: pointer;
	margin: 0px 8px
}

select{
	padding : 8px;
	border-radius:  8px
}


#content-info{
 border-bottom: solid 6px #f9f9f9;
 color : #555;
 & span{
 
  display : inline-block;
 	width : 30px;
 	height: 30px;
 	border-radius : 30px;
 	background: #eee;
 	margin-bottom : 12px;
 };
 
 
 & i{
 	font-size:12px;
 	color : #767676;
 	font-style: normal;
 };
 
 & div:first-child{display: flex; gap : 12px;}
}


.menu-active a{
			background : #333;
			color : white;
}

#content-info td{
	display: flex;
	justify-content: space-between;
	align-items: center;
}

#content-info a{
	border: solid 1px #767676;
	padding : 4px 8px;
	border-radius: 12px;
	margin-left: 6px;
	text-decoration: none;
	font-size : 12px
}

.td-content{
	white-space: pre-wrap;
}

</style>
</head>
<body>
	<main>
		<%@include file="/WEB-INF/include/pagingMenus.jsp" %>
			<table id="table">
				<tr>
					<td>
						<h2>${vo.title}</h2>
					</td>
				</tr>
				<tr id="content-info">
					<td>
						<div>
							<span></span><p>${vo.writer}<br><i>${vo.regdate} 조회 ${vo.hit}</i></p>
						</div>
						<c:if test="${login.userid == vo.writer }">
							<div class="btn">
								<a href="/Pds/UpdateForm?idx=${map.idx}&nowpage=${map.nowpage}">글수정</a>
								<a href="/Pds/Delete?idx=${map.idx}&menu_id=${map.menu_id}&nowpage=${map.nowpage}">삭제</a>
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="td-content">${vo.content}</td>
				</tr>
				<tr>
					<td>
						<p>파일</p>
						<c:forEach var="file" items="${fileList }">
						<div>
							<a href="/Pds/filedownload/${file.file_num}">
								${file.filename}
							</a>
						</div>						
						</c:forEach>
					</td>
				</tr>
			</table>
	</main>
	<script type="text/javascript">
	const url = "${vo.menu_id}"
	const $menus = document.querySelectorAll("#menu li");
		console.log(url)
		
		if(url === "all"){
			$menus[0].classList.add("menu-active");
		}else{
			const index = parseInt(url.slice(-2))
			$menus[index].classList.add("menu-active");
		}
	</script>
</body>
</html>