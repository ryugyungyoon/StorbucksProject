<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginPage</title>
<link rel="stylesheet" href="css/storebucks.css"/>
<link rel='stylesheet' href='css/Allshare.css'/>
  <!-- 네이버로그인 -->
  <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
  <!-- 카카오 로그인 -->
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="js/Allshare.js"></script>
<script>
	$(function() {
		//로그인 엔터키 
		$('#sbId, #sbPw').on('keypress', function(e){
	         if(e.keyCode == '13'){
	            var id = $('#sbId').val();
	            var pw = $('#sbPw').val();
	            if(pw!='' && id!=''){
	               $('#sbloginBtn').click();
	            }else if(id==''){alert(" 아이디를 입력하세요");}
	            else {alert("비밀번호를 입력하세요");}
	         }
	      });
		//로그인확인
		$("#sbloginBtn").click(function() {
			var id = $("#sbId").val();
			var pw = $("#sbPw").val();
			$.ajax({
				type:"get",
				url: "LoginServlet",
				data: {"id" : id, "pw" : pw},
				datatype: "json",
				success: function(data) {
					if(data.login_check=="1"){
						alert("로그인성공");
						location.href="MainpageServlet";
					}else{
						alert("로그인실패");
					}
				},											
				error: function(request, status, error) { alert(status); alert(error);}
			});
		});
		
		
		
		
	});
</script>
<script>
		//카카오 로그인
        // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('cd2734ca3e71c9a8e5cbea5207699469');
        
        function kakaoLogin(){
        	window.Kakao.Auth.login({
        		scope:'profile_nickname,account_email',
        		success: function(authObj) {
        		      Kakao.API.request({
        		        url: '/v2/user/me',
        		        success: function(res) {
        		          alert(JSON.stringify(res));
        		          console.log(res);
        		          var name = res.kakao_account.profile.nickname;
        		          var email = res.kakao_account.email;
        		          alert(name);
        		          alert(email);
        		          
        		          var token = "";
        		          location.href = "Controller?command=naver_login&name="+name+"&email="+email+"&token="+token;
        		        }
       				});
       			 }
        })
       };
     </script>
</head>
<body>
<%@ include file="Header.jsp" %>

	<div class="login_content">
		<img class="logo_img" src="Images/Main_titlePic/storbucks2.png">
		<div>
			<div class="login_sec">
				<div class="login_id">
					<input class='sbuck_txt'type="text" id="sbId" maxlength="50" placeholder="아이디">
				</div>
				<div class="login_pw">
					<input class='sbuck_txt' type="password" id="sbPw" placeholder="비밀번호">
				</div>
				
				<div>
					<button class="login_btn_orange" id="sbloginBtn">로그인</button>
				</div>
				
				<div style='margin-top: 10px; text-align: center;'>
				<!-- ----------------------------   -->	
					 <!-- 네이버아이디 로그인 버튼 노출 영역 -->
  					<div id="naver_id_login"></div>
					<script type="text/javascript">
					  	var naver_id_login = new naver_id_login("Z7wDl5B7t3bCy6tp_Rjh", "http://localhost:9060/StorbucksProject/Naver_ThrowsToMainPage.jsp");
					  	var state = naver_id_login.getUniqState();
					  	naver_id_login.setButton("white", 3,40);
					  	naver_id_login.setDomain("http://localhost:9060/StorbucksProject/Loginpage.jsp");
					  	naver_id_login.setState(state);
					  	naver_id_login.setPopup();
					  	naver_id_login.init_naver_id_login();
				  	</script>
					<!-- 카카오 아이디 로그인 버튼 노출 영역 -->				
				<a href='javascript:kakaoLogin();'><img src='Images/Allshare/kakao_login.png'/></a>
				
				
				
				</div>	
			</div>
		</div>	
	</div>
	
<%@ include file='footer.jsp'%>	
</body>
</html>