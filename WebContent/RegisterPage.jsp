<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="css/ssag.css">
<link rel="stylesheet" href="css/Allshare.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="js/Allshare.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
//ajax 아이디 중복 체크 function
function checkingID(id,checkMulti){
	checkMulti[1] = 0;
	$.ajax({
		type:"get",
		url:"RegisterIdcheck",
		data:{"id":id},
		datatype:"json",
		async:false,
		success:function(data){
			if(data.login_check=="1"){
				checkMulti[0] = false;
			}else{
				checkMulti[0] = true;
			}
		},
		error:function(request,status,error){alert(status);alert(error);}
	});
	return checkMulti;
}
$(function(){
	var checkMulti = new Array();
	//아이디 중복검사확인
	$(".con_p4").click(function(){
		var id = $("#id").val();
		if(id!=""){
		 	if(checkingID(id,checkMulti)[0]){
				alert("아이디 사용가능");
				alert(checkMulti[1]);
			}else{
				alert("해당 아이디는 중복입니다");
				$("#id").val(null);
				$("#id_checkText").html(null);
			} 
		}else{
			alert("아이디를 입력하세요");
		}
	});
	//가입하기
	$(".join_p4").click(function(){
		var id = $("#id").val();
		if(check()){
			if(checkMulti[1]==0){
				//submit;
				alert("서브밋하면됌");
			}else{
				alert("아이디 중복확인을 체크해주세요!");
			}
		}
	});
	//아이디 유효성 체크
	$("#id").change(function(){
		var id = register.id.value;
		checkMulti[1] = -1;
		alert(checkMulti[1]);
		
		
		var id2 =/^[a-zA-Z]+[a-zA-Z0-9]{3,11}$/g;
		if(!(id2.test(id))){
			$(this).parent().parent().siblings(".changealbeText").html("<div>아이디를 다시 입력해주세요</div>");
		} else{
			$(this).parent().parent().siblings(".changealbeText").html("<span>사용가능한 아이디입니다</span>");
		}
	});
	//비번 유효성 체크
	$("#pw").change(function(){
		var pw = register.pw.value;
		
		var pw3= /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/g;
		if(!(pw3.test(pw))){
			$(this).parent().parent().siblings(".changealbeText").html("<div>비밀번호를 다시 입력해주세요</div>");
		}else{
			$(this).parent().parent().siblings(".changealbeText").html("<span>사용가능한 비밀번호입니다</span>");
		}
		
	});
	//비번2 유효성 체크
	$("#pwcheck").change(function(){
		var pw = register.pw.value;
		var pw_check = register.pw_check.value;
		if(pw==pw_check){	
			$(this).parent().parent().siblings(".changealbeText").html("<span>비밀번호 일치</span>");
		}
		else{
			$(this).parent().parent().siblings(".changealbeText").html("<div>비밀번호를 다시 확인해주세요</div>");	
		}
	});
	//이름 유효성 체크
	$("#name").change(function(){
		var name = register.name.value;
		var name2 =/^[가-힣]{2,4}$/g;
		
		if(!(name2.test(name))){
			$(this).parent().parent().siblings(".changealbeText").html("<div>이름을 다시 입력해주세요</div>");
		} else {
			$(this).parent().parent().siblings(".changealbeText").html("");
		}
	});
	//폰 유효성 체크
	$("#phone").change(function(){
		var phone = register.phone.value;
		
		var phone2 = /01[016789][0-9]{3,4}[0-9]{3,4}/;
		if(!(phone2.test(phone))){
			$(this).parent().parent().siblings(".changealbeText").html("<div>번호를 다시 입력해주세요</div>");
		} else {
			$(this).parent().parent().siblings(".changealbeText").html("");
		}
	});
	//이메일 유효성 체크
	$("#email").change(function(){
		var email = register.email.value;
		
		var email2 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if(!(email2.test(email))){
			$(this).parent().parent().siblings(".changealbeText").html("<div>이메일을 다시 입력해주세요</div>");
		} else {
			$(this).parent().parent().siblings(".changealbeText").html("");
		}
	});
	
});
//유효성 검사
function check(){
	var id = register.id.value;
	var pw = register.pw.value;
	var pw_check = register.pw_check.value;
	var name = register.name.value;
	var address = register.address.value;
	var addressDetail = register.addressDetail.value;
	var phone = register.phone.value;
	var email = register.email.value;
	//아이디의  조건 : 영문자로 시작 숫자사용가능 4~12자 사용.
	var id2 =/^[a-zA-Z]+[a-zA-Z0-9]{3,11}$/g;
	if(!(id2.test(id))){
		alert("id를 다시 확인해주세요.");
		return false;
	}
	//비밀번호 조건 : 영문자랑 숫자 특수문자 한개이상 사용 9자리이상자 사용.
	var pw3= /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/g;
	if(!(pw3.test(pw))){
		alert("비밀번호를 다시 확인해주세요.");
		return false;
	}
	//비밀번호 확인 : pw!=pw_check 같지않으면 다시 입력
	if(pw==pw_check){	
	}
	else{
		alert("비밀번호를 다시 확인해주세요.");
		return false;			
	}
	//이름 2자이상 5자이하 한글만사용.
	var name2 =/^[가-힣]{2,4}$/g;
	if(!(name2.test(name))){
		alert("이름을 다시 확인해주세요.");
		return false;
	}
	//핸드폰 조건 : 숫자만 사용 11자사용 .
	var phone2 = /01[016789][0-9]{3,4}[0-9]{3,4}/;
	if(!(phone2.test(phone))){
		alert("핸드폰 번호를 다시 확인해주세요.");
		return false;
	}
	//주소
	if(address==null || addressDetail==null){
		alert("주소를 다시 확인해주세요.");
		return false;
	}
	//이메일 조건 : 영문자로 시작ㄱ 숫자사용 가능 4~12자 사용.
	var email2 = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	if(!(email2.test(email))){
		alert("이메일을 다시 확인해주세요.");
		return false;
	}
	return true;
} 
//다음 우편API
function findAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }


            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
</script>
<style>
	.addr_p4{
	   display:inline-block;
	}
	.user_addr_con_p4{
	    margin: 8px 0px;
	    font-size: 17px;
	    color: gray;
	}
	.user_addr_con_p4 input{
		border: 1px solid #e0e0e0;
		width: 211px;
    	height: 29px;
	}
	#sample6_postcode{
		border: 1px solid #e0e0e0;
		height: 33px;
	    width: 100px;
	}
	.registerText{
		display:inline-block;	
		width:142px;
		height: 70px;
		vertical-align: top;
	}
	.registerArea{
		display:inline-block;
		height: 70px;
	}
	.line_p4{
	width: 1020px;
    min-height: 71px;
    border-bottom: 1px solid #eee;
    margin: 18px 0px;
	}
	.changealbeText span{
		color: blue;
	    font-size: 13px;
	    font-family: auto;
	}
	.changealbeText div{
		color: red;
	    font-size: 13px;
	    font-family: auto;
	}
</style>
</head>
<body>
<%@ include file="Header.jsp" %>
	
		<div class="main_content2_p4">
			<div class="info_p4">
				<h1>회원가입</h1>
			</div>
				
			<form action="Controller" name='register'>
			<input type="hidden" name="command" value="register"/>
				<div>
					<div class="line_p4">
						<div class="registerText">
							<span class="star_p4">*</span><span>아이디</span>
						</div>
						<div class='registerArea'>
							<div>
								<div class="info_div2_p4">
									<input type="text" name="id" placeholder="영문으로 시작하고 영문,숫자 조합 4~12자리로 입력해주세요." class='textsize' id='id' />
								</div>
								<button type="button" class="con_p4"><span>중복확인</span></button> 
							</div>
							<div class='changealbeText' id='id_checkText'></div>
						</div>
					</div>
					
				 	<div class="line_p4">
				 		<div class="registerText">
							<span class="star_p4">*</span><span>비밀번호</span>
						</div>
						<div class='registerArea'>
							<div>
								<div class="info_div2_p4">
									<input type="password" name="pw" placeholder="영문,숫자, 특수문자 조합 9자리 이상 입력해주세요." class='textsize' id="pw"/>
								</div>
							</div>
							<div class='changealbeText'></div>
						</div>
				 	</div>
				 	<div class="line_p4">
				 		<div class="registerText">
							<span class="star_p4">*</span><span>비밀번호 확인</span>
						</div>
						<div class='registerArea'>
							<div>
								<div class="info_div2_p4">
									<input type="password" name="pw_check" placeholder="입력하신 비밀번호를 한 번 더 입력해주세요." class='textsize' id="pwcheck"/>
								</div>
							</div>
							<div class='changealbeText'></div>
						</div>
				 	</div>
				 	<div class="line_p4">
				 		<div class="registerText">
							<span class="star_p4">*</span><span>이름</span>
						</div>
						<div class='registerArea'>
							<div>
								<div class="info_div2_p4">
									<input type="text" name="name" placeholder="이름을 입력해주세요." id="name" style="width:100%; height:40px; border:1px solid #e0e0e0;">
								</div>
							</div>
							<div class='changealbeText'></div>
						</div>
				 	</div>
				 	<div class="line_p4">
				 		<div class="registerText">
							<span class="star_p4">*</span><span>주소</span>
						</div>
						<div class='addr_p4'>
							<div>
								<input type="text" id="sample6_postcode" placeholder="우편번호" required/>
								<button type="button" class="con2_p4" onclick='findAddress()'> <!-- style="width:100px; height:38px;"-->우편번호 찾기</button>
							</div>
							<div>
								<div class='user_addr_con_p4'>
									<input type="text" name='address' id="sample6_address" placeholder="주소" required/><br>
								</div>
								<div class='user_addr_con_p4'>
									<input type="text" name='addressDetail' id="sample6_detailAddress" placeholder="상세주소" required/>
								</div>
							</div>
						</div>
				 	</div>
				 	<div class="line_p4">
				 		<div class="registerText">
							<span class="star_p4">*</span><span>휴대폰번호</span>
						</div>
						<div class='registerArea'>
							<div>
								<div class="info_div2_p4">
									<input type="tel" name="phone" id="phone" placeholder="핸드폰 번호를 입력해주세요." style="width:100%; height:40px; border:1px solid #e0e0e0;">
								</div>
							</div>
							<div class='changealbeText'></div>
						</div>
				 	</div>
				<div class="line_p4">
			 		<div class="registerText">
						<span class="star_p4">*</span><span>이메일주소</span>
					</div>
					<div class='registerArea'>
						<div>
							<div class="info_div2_p4">
								<input type="email" name="email"  id="email" placeholder="자주 사용하시는 이메일 주소를 입력해주세요." style="width:100%; height:40px; border:1px solid #e0e0e0;">
							</div>   	     
						</div>
						<div class='changealbeText'></div>
					</div>
			 	</div>
			</div>
			<div class="last_bottom_p4">
				<input type="submit" class="join_p4" value="가입하기"/>
			</div>
		</form>
			

		</div>
<%@ include file='footer.jsp'%>			
</body>
</html>