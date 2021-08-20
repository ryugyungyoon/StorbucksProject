<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	var naver_id_login = new naver_id_login("Z7wDl5B7t3bCy6tp_Rjh", "http://localhost:9060/StorbucksProject/Naver_ThrowsToMainPage.jsp");
	// 접근 토큰 값 출력
	alert(naver_id_login.oauthParams.access_token);
	// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
	  alert(naver_id_login.getProfileData('email'));
	  alert(naver_id_login.getProfileData('name'));
	
	
	var token = naver_id_login.oauthParams.access_token;
	var name = naver_id_login.getProfileData('name');
	var email = naver_id_login.getProfileData('email');
	
	
	var str = "";
	str = "https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id=Z7wDl5B7t3bCy6tp_Rjh&client_secret=mSgd5vW1f6&access_token="
	+ token
	+ "&service_provider=NAVER";
	
	opener.document.location.href = "Controller?command=naver_login&name="+name+"&email="+email+"&token="+token;
	self.close();
 }
</script>
</body>
</html>