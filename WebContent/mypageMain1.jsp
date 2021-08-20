<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="myPageMain1">
			<div class="head3">
				<div class="menu"></div>
			</div>
			<div class="mypageArea">
				<ul>
					<li class="mypage2">
						<span class="mypageHead1">
							<em><img src="Images/mypageAreaPic/쇼핑통장관리.png"/></em>
						</span>
						<ul class="mypagedate1">
							<li class="menutext"><a href='mypageCoupon.jsp'>쿠폰</a></li>
						</ul>	
					</li>
					<li class="mypage2">
						<span class="mypageHead1">
							<em><img src="Images/mypageAreaPic/상품관리.png"/></em>
						</span>
						<ul class="mypagedate1">
							<li class="menutext"><a href='Controller?command=mypageOrderList'>구매내역</a></li>
						</ul>				
					</li>
					<li class="mypage2">
						<span class="mypageHead1">
							<em><img src="Images/mypageAreaPic/활동관리.png"/></em>
						</span>
						<ul class="mypagedate1">
							<li class="red , menutext"><a href='Controller?command=mypageLike'>좋아요</a></li>
						</ul>
					</li>
					<li class="mypage3">
						<span class="mypageHead1">
							<em><img src="Images/mypageAreaPic/정보관리.png"/></em>
							</span>
						<ul class="mypagedate1">
							<li class="menutext"><a href='Controller?command=mypageChangeInfo'>회원정보변경</a></li>
                     		<li class="menutext"><a href='mypageChangePW.jsp'>비밀번호변경</a></li>
							<li class="menutext"><a href='mypageDrop.jsp'>회원탈퇴</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
</body>
</html>