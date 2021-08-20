<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="js/Allshare.js"></script>
<script>
$(function(){
	//메인헤더 - 마이페이지 장바구니
	$(".gotoMypageWishList").click(function(){
		var login_id = '<%=session.getAttribute("login_id")%>';
		
		if(login_id!='null'){
			alert("아직 안만들엇음");
		}else{
			alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
			location.href="Loginpage.jsp";
		}
	});
	//메인헤더 - 마이페이지 구매내역
	$(".gotoMypageOrderList").click(function(){
		var login_id = '<%=session.getAttribute("login_id")%>';
		
		if(login_id!='null'){
			location.href="Controller?command=mypageOrderList";
		}else{
			alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
			location.href="Loginpage.jsp";
		}
	});
	//메인헤더 - 마이페이지 으로
	$(".gotoMypageMain").click(function(){
		var login_id = '<%=session.getAttribute("login_id")%>';
		
		if(login_id!='null'){
			location.href="Controller?command=mypageMain";
		}else{
			alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
			location.href="Loginpage.jsp";
		}
	});	
	//메인헤더 - 검색창
   $('.mainSearch').on('keypress', function(e){
      if(e.keyCode == '13'){
            $('.searchPage').click();
      }
   });
});
</script>
</head>
<body>
	<div>
		<div class="logo_section">
			<div class="util_menu">
			<%
				
				String id = (String)(session.getAttribute("login_id"));
				if(id==null){
			%>
				<a href='Loginpage.jsp' class='loginPage'>로그인</a> 
				<a href='RegisterPage.jsp' class='registerPage'>회원가입 </a>
			<%		
				}else{
			%>
				<span><%=id%>님 환영합니다</span>
				<button class='btn_logout'>로그아웃</button>
			<%
				}
			%>
				
			</div>
			<div style='height: 106px;'>
				<div class="logo">
					<img class="logo_img" src="Images/Main_titlePic/storbucks2.png"/>
				</div>
				<div class="searching_box">
					<input type="text" class='mainSearch'>
					<img class='searchPage' src="Images/Main_titlePic/돋보기.png">
				</div>
				<div class ="div_image">
				
					<img class='gotoMypageWishList' src="Images/Allshare/장바구니.png"/>
					<img class='gotoMypageOrderList' src="Images/Allshare/리뷰.png"/>
					<img class='gotoMypageMain' src="Images/Allshare/mypage.png"/>
				
				</div>
			</div>
		</div>
		
		<div class="mainTitle">
			<div id="main_menu">
				<a href='Controller?command=productcategory&categoryNumber=1' class="main_menu2">베이커리</a>
				<a href='Controller?command=productcategory&categoryNumber=2' class="main_menu2">커피</a>
				<a href='Controller?command=productcategory&categoryNumber=3' class="main_menu2">디저트</a>
				<a href='Controller?command=productcategory&categoryNumber=4' class="main_menu2">음료</a>
				<a href='Controller?command=productcategory&categoryNumber=5' class="main_menu2">텀블러</a>
				<a href='Controller?command=productcategory&categoryNumber=6' class="main_menu2">머그컵</a>
			</div>
		</div>
	</div>
</body>
</html>