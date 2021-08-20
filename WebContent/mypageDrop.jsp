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
	$(function(){
		$(".clickButton").click(function(){
			if($("#cb_drop").is(":checked")){
				location.href="Controller?command=mypageDrop";
			}
			else alert("체크박스를 체크해주세요!")
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
				<h1>회원탈퇴</h1>
			</div>
			<h2>탈퇴 유의사항</h2>
			
			<div class="notice">
				<h3>회원 재가입 제한</h3>
				<ul>
					<li>회원탈퇴후 재가입 시 신규회원으로 가입되며, 탈퇴 전의 회원정보,주문정보,마일리지 쿠폰은 복원되지 않습니다.</li>
					<li>사이트 정책에 따라 최대 30일동안 재가입이 불가합니다.</li>
				</ul>
			</div>
			<div class="dropMember1"></div>
			<div class="notice">
				<h3>개인정보 파기</h3>
				<ul>
					<li>개인정보는 회원 재가입 유예기간 경과 후 즉시 파기됩니다.</li>
					<li>단 전자상거래법, 통신비보호법 등 관련 법령의 규정에 의하여 아래의 개인정보가 일정기간 보관됩니다.</li>
				</ul>
			</div>
			<div class="dropMember2"></div>
			
			<div class="dropMemberCheck">
				<input id="cb_drop" type="checkbox"/><span> 회원탈퇴 유의사항을 모두 확인하였으며, SSAC 회원탈퇴에 동의합니다.</span>
			</div>
			<div class="clickButton"><button class="change_btn">확인</button></div>
		</div>
	</div>
<%@ include file='footer.jsp'%>
</body>
</html>