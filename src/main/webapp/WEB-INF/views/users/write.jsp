<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/css/common.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
main {
	max-width: 1200px;
	margin: auto
}

h2, table {
	width: 100%
}

tbody td {
	height: 50px
}

table td:first-child:not([colspan]) {
	background: #333;
	color: white;
	padding: 10px;
	border-bottom: solid 1px #fff
}

tr:nth-child(5) td:first-of-type {
	border: none
}

table tr:last-of-type {
	text-align: center
}

input[type="text"], input[type="number"], input[type="password"] {
	width: 100%;
	padding: 10px;
	border: none
}

td[colspan] {
	padding: 10px
}

span {
	font-size: 12px
}

#id {
	position: relative;
	display: flex;
	&
	input
	{
	width
	:
	50%
}

}
#dupText {
	position: absolute;
	left: 8px;
	bottom: 4px;
}

.red {
	color: red;
	padding: 4px
}

.green {
	color: green;
	padding: 4px
}

.util-btn {
	padding: 8px;
	font-size: 12px;
}
</style>
</head>
<body>
	<main>
		<h2>사용자 등록</h2>
		<form action="/Users/Write" method="POST">
			<table>
				<tr>
					<td><span class="red">*</span>아이디</td>
					<td id="id"><input type="text" name="userid"> <span
						id="dupText"></span>
						<button type="button" id="dupCheck" class="util-btn">중복확인</button>
						<button type="button" id="dupCheck2" class="util-btn">중복확인(새창)</button>
					</td>
				</tr>
				<tr>
					<td><span class="red">*</span>비밀번호</td>
					<td><input type="password" name="passwd"></td>
				</tr>
				<tr>
					<td><span class="red">*</span>비밀번호 확인</td>
					<td><input type="password" name="passwd2"></td>
				</tr>
				<tr>
					<td><span class="red">*</span>이름</td>
					<td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="email"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="회원가입"
						name="submit_btn" class="util-btn"> <input type="button"
						value="목록" id="goList" class="util-btn"></td>
				</tr>
			</table>
		</form>
	</main>
	<script>
		const $goBtn = document.querySelector("#goList");
		$goBtn.addEventListener("click",function(){
			location.href="/Users/List"
		})
	
		const $form 			= document.querySelector("form");
		const $userid 		= document.querySelector("input[name='userid']");
		const $passwd 		= document.querySelector("input[name='passwd']");
		const $passwd2 		= document.querySelector("input[name='passwd2']");
		const $username 	= document.querySelector("input[name='username']");
		const $addBtn 		= document.querySelector("input[name='submit_btn']");
		const $idDupBtn 	= document.querySelector("#dupCheck");
		const $idDupBtn2 	= document.querySelector("#dupCheck2");

		let idDup = false;
		
		$idDupBtn.addEventListener("click", function(){
			idDup = true;
		});
		
			// 중복확인(새창) 버튼이 클릭되면
			$idDupBtn2.onclick = function(){
				if($userid.value !== ""){		
					// 새 창을 연다
					let html 			= "/Users/DupCheck?userid="+ $userid.value; // 새 창에 보여줄 html 파일/ JSP
					let name 			= "dupCheck";
					let features 	= "height = 300, width = 500, left = 800, top= 300";
					window.open(html, name, features);
					idDup = true;
			}else{alert("아이디를 입력 후 중복확인해주세요.")}
		}
		
		
		$form.onsubmit = function(){
			if($userid.value.trim() == ''){
				alert("아이디를 입력하세요")
				$userid.focus();
				return false;
			} else if($passwd.value.trim() == ''){
				alert("비밀번호를 입력하세요")
				$passwd.focus();
				return false;
			} else if($passwd2.value.trim() == ''){
				alert("비밀번호 확인을 입력하세요")
				$passwd2.focus();
				return false;
			} else if($passwd.value !== $passwd2.value ){
				alert("비밀번호가 일치하지 않습니다.")
				$passwd.focus();
				return false;
			} else if($username.value.trim().length < 2){
				alert("이름은 2자 이상 입력하세요")
				$username.focus();
				return false;
			} else if(!idDup){
				alert("아이디는 중복확인을 해야합니다.")
				return false;
			}
		}
	</script>
	<script>
			$("#dupCheck").on("click",function(){
				// ajax는 페이지를 변경하지 않고 서버에서 조회한 결과를 돌려받는다.
				// ajax : XHR, $.ajax(), fetch(), axios()
				if($("input[name='userid']").val() !== ""){
					$.ajax({
						url  : "/Users/IdDupCheck",
						data : {userid : $("[name='userid']").val()} 
					})
					.done((data)=>{
						let html = "";
						if(data == ""){
							html += "사용가능한 아이디입니다."
							$("#dupText").html(html).css({color : "green"});
							
						}else{
							html += "중복된 아이디입니다."
								$("#dupText").text(html).css({color : "red"});
						}
					})
					.fail(err=>console.log(err))
					
				}
			})
	</script>
</body>
</html>