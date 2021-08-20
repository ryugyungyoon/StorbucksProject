<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<div class="myPageMain2">
			<ul class="myPageMain2Text">
				<li class="openandclose">
					<span class="myPageMain2MenuPic2">쇼핑통장관리</span>
					<ul class="myPageMainDetail">
						<li><a href='mypageCoupon.jsp'>쿠폰</a></li>
					</ul>
				</li>			
				<li class="openandclose">
					<span class="myPageMain2MenuPic3">상품관리</span>
					<ul class="myPageMainDetail">
						<li><a href='Controller?command=mypageOrderList'>구매내역</a></li>
					</ul>
				</li>			
				<li class="openandclose">
					<span class="myPageMain2MenuPic4">활동관리</span>
					<ul class="myPageMainDetail">
						<li><a href='Controller?command=mypageLike'>좋아요</a></li>
					</ul>
				</li>			
				<li class="openandclose">
					<span class="myPageMain2MenuPic5">정보관리</span>
					<ul class="myPageMainDetail">
						<li><a href='Controller?command=mypageChangeInfo'>회원정보 변경</a></li>
						<li><a href='mypageChangePW.jsp'>비밀번호변경</a></li>
						<li><a href='mypageDrop.jsp'>회원탈퇴</a></li>
					</ul>
				</li>			
			</ul>
		</div>
</body>
</html>