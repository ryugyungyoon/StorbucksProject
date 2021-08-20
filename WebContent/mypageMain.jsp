<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = 'com.admin.www.*' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 메인</title>
<link rel="stylesheet" type="text/css" href="css/myPageStyleTag.css">
<link rel="stylesheet" href="css/Allshare.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="js/Allshare.js"></script>
</head>
<body>
		
<%@ include file="Header.jsp" %>
		
	<div class="myPageMain">
	
<%@ include file='mypageMain1.jsp'%>

		<div class="secondLine">
			<div class="thirdLine25-1">
				<div class="clickable">쿠폰</div>
				<div class="clicktext1">${couponAmount}</div>
			</div>
			<div class="thirdLine25">
				<div class="clickable">좋아요</div>
				<div class="clicktext2">${likedAmount}건</div>
			</div>
			<div class="thirdLine25">
				<div class="clickable">리뷰관리</div>
				<div class="clicktext2">${reviewAmount}건</div>
			</div>
			<div class="thirdLine25">
				<div class="clickable">구매내역</div>
				<div class="clicktext2">${orderListAmount}건</div>
			</div>
		</div>
		
	</div>
<%@ include file='footer.jsp'%>
</body>
</html>