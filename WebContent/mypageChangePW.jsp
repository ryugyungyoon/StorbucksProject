<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = 'java.sql.*' %>
<%@ page import = 'com.admin.www.*' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/myPageStyleTag.css">
<link rel="stylesheet" href="css/Allshare.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="js/Allshare.js"></script>
<script>
function checkpw(){
	var pw = "";
	pw = mypageChangePW.pw.value;
	var repw = "";
	repw = mypageChangePW.repw.value;
	 
	if(pw == "" || repw == ""){
		alert("공백문자는 입력하실 수 없습니다.");
		return false;
	}
 
	if(pw == repw){
		alert("비밀번호 일치!")
		return true;
	}
	 else{
		alert("비밀번호를 다시 확인해주세요."); 
		return false;
	} 
}

$(function() {
   $(".change_btn").click(function(){
      if(checkpw()){
         alert("비밀번호가 변경되었습니다.");
         $("#form3").submit();
      }else{}
   });
});
</script>
</head>
<body>
<%@ include file="Header.jsp" %>
	
	<div class="myPageMain">
		
<%@ include file='mypageMain1.jsp'%>
<%@ include file='mypageMain2.jsp'%>
		
		<div class="myPageMain3">
			<div class="myPageMain3firstLine">
				<h1>비밀번호 변경</h1>
			</div>
			
			<form id="form3" action="Controller" name='mypageChangePW' method='get'>
	      		<input type="hidden" name="command" value="mypageChangePW"/>
				<div class="myPageMain3secondLine" style="background-color:#e6e6e8;">
				   <div class="passwordCheck">
				      <span class="passwordText"><label for="pw" >비밀번호</label></span>
				      <div class="passwordDoubleCheck"><input class='password' type="password" id="pw" name="pw"/></div>
				      <span class="passwordText"><label for="repw">비밀번호 재확인</label></span>
				      <div class="passwordDoubleCheck"><input class='password' type="password" id="repw" name="repw"/></div>
				   </div>
				</div>
	        </form>
	       	<div class="clickButton">
	       		<button class='change_btn'>확인</button>
	       	</div>
			
			<div class="notice">
				<h3>주의하세요</h3>
				<ul>
					<li>비밀번호는 <b style="color:red">영문과 숫자를 조합하여 8~20자리로 입력\</b>해 주세요.</li>
					<li>아이디와 같은 비밀번호나 주민등록번호, 생일, 학번, 전화번호 등 개인정보와 관련된 숫자, 연속된 숫자, 동일 반복된 숫자 등 다른 사람이 쉽게 알아낼 수 있는 비밀번호는 사용하지 않도록 주의하여 주시기 바랍니다.</li>
				</ul>
			</div>
		</div>
	</div>
<%@ include file='footer.jsp'%>
</body>
</html>