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

input[name="writer"]{
	background: #f1f3f5; margin: 12px
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

.util-btn:first-child {
	border: solid 1px #767676;
	color: #767676;
}

</style>
</head>
<body>
	<main>
		<%@include file="/WEB-INF/include/pdsMenus.jsp" %>
		<form action="/Pds/Update" method="POST" enctype="multipart/form-data">
			<ul id="table">
				<li>
					<input type="text" name="title" value="${vo.title}" placeholder="제목">
					<input type="hidden" name="idx" value="${map.idx}">
					<input type="hidden" name="nowpage" value="${map.nowpage}">
				</li>
				<li>
					<input type="text" name="writer" value="${vo.writer}" readonly="readonly">
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
					<textarea name="content" placeholder="내용">${vo.content}</textarea>
				</li>
				<li>
				   <p>파일</p>
				   <c:forEach var="file" items="${fileList }">
					   <div class="text-start">
					   		<a class="a-delete" href="/deleteFile?file_num=${file.file_num}" data-id="${file.file_num}">❌</a>
								<a href="/Pds/filedownload/${file.file_num}">
									${file.filename}
								</a>
					   </div>				   
				   </c:forEach>
				</li>
				 <li class="file-li">
				  <input type="button" id="btnAddFile" value="파일추가(최대100MB)"/>
				  <input type="file" name="upfile" class="upfile" multiple="multiple">				 
				 </li> 
				<li class="util">
						<input type="button"
						value="목록" id="goList" class="util-btn">
						<input type="submit" value="글저장"
						name="submit_btn" class="util-btn"> 
				</li>
			</ul>
		</form>
	</main>
	<script type="text/javascript">
	const $goBtn = document.querySelector("#goList");
	$goBtn.addEventListener("click",function(){
		location.href='/Pds/List?menu_id=${map.menu_id}'
	})
		const $menus = document.querySelectorAll("#menu li");
			

		$menus[0].classList.add("menu-active");
		
		$("#btnAddFile").click(()=>{
			$(".file-li").append($(".upfile").eq(0).clone())
		})
		
		
		$(".a-delete").click(function(e){
			e.preventDefault();
			$(this).parent(".text-start").hide();
			deleteAjax(e.target.dataset.id)
		})
		
		
		const deleteAjax = (fileNum) => {
			$.ajax({
				url : "/deleteFile",
				data : {"file_num" : fileNum}
			})
			.done(function(res){
				alert("Ajax가 성공했습니다.")
			})
			.fail(function(err){
				alert("Ajax가 실패했습니다.")
			})
		}

		
	</script>
</body>
</html>