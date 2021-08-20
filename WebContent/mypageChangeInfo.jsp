<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = 'java.sql.*' %>
<%@ page import = 'com.admin.www.*' %>
<%@ page import = 'MypageMemberInfoVO.*' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href=" css/myPageStyleTag.css">
<link rel="stylesheet" href="css/Allshare.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="js/Allshare.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script> //다음 api
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
	.user_addr_con_p4{
	    margin: 8px 0px;
	    font-size: 17px;
	    color: gray;
	}
	#sample6_address, #sample6_detailAddress{
	    width: 269px;
    	height: 35px;
	}
	#sample6_postcode{
		height: 33px;
	    width: 100px;
	}
	.separate{height:20px;}
</style>
</head>
<body>
<%@ include file="Header.jsp" %>

	<div class="myPageMain">
	
<%@ include file='mypageMain1.jsp'%>	
<%@ include file='mypageMain2.jsp'%>	
	
		<div class="myPageMain3">
		
		
		<form action="Controller" method="get">
         <input type="hidden" name="command" value="mypageChangeInfoPass"/>
         <div class="myPageMain3firstLine">
            <h1>회원정보 변경</h1>
         </div>
         <div class="myPageMain3secondLine">
            <div class="changeMemberMainText">
               <h2>필수정보 입력</h2>
               <p><b>* </b>표시는 필수입력 항목이오니 반드시 입력해 주세요.</p>
            </div>
            
            <% 
               MemberInfoVO vo = (MemberInfoVO)request.getAttribute("member_infovo");
            %>
            
            <div class="lineUnity">
               <span class="lineUnityText">회원아이디</span>
               <div class="insert"><%=vo.getId() %></div>   
            </div>
            <div class="lineUnity">
               <span class="lineUnityText">이름</span>
               <div class="insert"><%=vo.getName() %></div>   
            </div>
            <div class="lineUnity">
               <span class="lineUnityText">자택주소</span>
              	 <div class="line_p4">
					<div class="addr_p4">
						<div>
							<input type="text" id="sample6_postcode" placeholder="우편번호" required/>
							<button type="button" class="con2_p4" onclick='findAddress()' style="width:100px; height:38px;">우편번호 찾기</button>
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
            </div>      
            <div class="lineUnity">
               <span class="lineUnityText">휴대폰 번호</span>
               <div class="insert">
                  <select name="phoneselect" style="width:65px; height:30px;" >
                     <option>010</option>
                     <option>011</option>
                     <option>016</option>
                     <option>017</option>
                     <option>018</option>
                     <option>019</option>
                  </select>
                  - <input type="text" name="phone" id="sample6_phone" style="width: 97px; height: 25px;" required/>
               </div>   
            </div>
            <div class="lineUnity">
               <span class="lineUnityText">이메일주소</span>
               <div class="insert"><input type="text" name="email" id="sample6_email" style="width:245px; height:25px;" required/></div>   
            </div>
   			<div class='separate'></div>
			<div class="clickButton">
					<input type='submit' value='변경하기' class='change_btn'/>
			</div>
         </div>
      </form>
			<!--  form태그 안에서 button태그는 기본적으로 submit버튼으로서의 기능을 해요. 그러기 싫으면 type="button"을 추가. -->
		</div>
	</div>
<%@ include file='footer.jsp'%>
</body>
</html>