<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = 'java.sql.*' %>
<%@ page import = 'com.admin.www.*' %>
<%@ page import = 'MypageOrderListVO.*' %>
<%@ page import = 'java.util.*' %>
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
	$(".goMainPage").click(function(){
		location.href="MainpageServlet";	
	});
});

//리뷰작성
$(document).on('click','.draftReview',function(){
	var product_number = $(this).parent().attr("product_number");
	var order_number = $(this).parent().attr("order_number");
		
	$.ajax({
		type:"get",
		url: "checkReview",
		data: {"product_number" : product_number, "order_number": order_number},
		datatype: "json",
		success: function(data) {
			if(data.retNumber=="0"){
				var str = "";
				str = "<div><h1 style='margin:20px 0 32px 10px;'>리뷰 작성페이지</h1></div>"
					+ "<div>"
					+ 		"<form id='form1' action = 'Controller'>"
					+		"<input type='hidden' name='command' value='writeReview'/>"
					+		"<input type='hidden' name='product_number' value='"+product_number+"'/>"
					+		"<input type='hidden' name='order_number' value='"+order_number+"'/>"
					+		"<div>제목<input type='text' name='title' class='title' placeholder='제목을 입력해주세요'/></div>"
					+		"<div>내용<textarea class='reviewContent' name='content' placeholder='상품에 대한 리뷰를 작성해주세요.'></textarea></div>"			
					+		"별점<select id='name' class = 'mypageReviewRating' name='rating'>"
					+			"<option value='1'>1</option>"
					+			"<option value='2'>2</option>"
					+			"<option value='3'>3</option>"
					+			"<option value='4'>4</option>"
					+			"<option value='5'>5</option>"
					+		"</select>"
					+ 		"</form>"
					+ 		"<button id='click_submit'>작성완료</button>"
					+ 		"<button id='btn_close'>닫기</button>"
					+ "</div>";
				
				$(".reviewWrite_body").html(str);

				$("body").css("overflow","hidden");
				$(".reviewWrite_body").css("display","block");
				$(".reviewshow_body").css("display","none");
				
				$(".modal").css("display","block");
			}else{
				alert("이미 리뷰를 작성하였습니다");
			}
		},											
		error: function(request, status, error) { alert(status); alert(error);}
	});
});
//리뷰보기
$(document).on('click','.showReview',function(){
	var product_number = $(this).parent().attr("product_number");
	var order_number = $(this).parent().attr("order_number");
	var rating;
	$.ajax({
		type:"get",
		url: "showReview",
		data: {"product_number" : product_number, "order_number": order_number},
		datatype: "json",
		success: function(data) {
			if(data.retNumber=="1"){
				rating = data.rating;
				var str = "";
				str =  "<div><h1 style='margin:20px 0 32px 10px;'>내가 쓴 리뷰</h1></div>"
					+	"<div>"
					+		"<form id='form2' name='modifyReview' action = 'Controller'>"
					+			"<input type='hidden' name='command' value='modifyReview'/>"
					+			"<input type='hidden' name='product_number' value='"+product_number+"'/>"
					+			"<input type='hidden' name='order_number' value='"+order_number+"'/>"
					+			"<div>제목<input type='text' name = 'title' value='"+data.title+"' class='title'/></div>"
					+			"<div>내용<textarea class='reviewContent' name='content'>"+data.content+"</textarea></div>"			
					+			"별점<select class = 'mypageReviewRating' name='rating'>"
					+				"<option value='1'>1</option>"
					+				"<option value='2'>2</option>"
					+				"<option value='3'>3</option>"
					+				"<option value='4'>4</option>"
					+				"<option value='5'>5</option>"
					+			"</select>"
					+		"</form>"
					+		"<button id='click_modify'>수정</button>"
					+		"<button id='click_delete'>삭제</button>"
					+		"<button id='btn_close'>닫기</button>"
					+	"</div>";
				
				$(".reviewshow_body").html(str);
				putRating(rating);
				$("body").css("overflow","hidden");
				$(".reviewshow_body").css("display","block");
				$(".reviewWrite_body").css("display","none");
				$(".modal").css("display","block");
			}else{
				alert("리뷰를 먼저 작성해주세요");
			}
		},											
		error: function(request, status, error) { alert(status); alert(error);}
	});
});

//리뷰 보기 별점 넣기
function putRating(rating){
	$(".mypageReviewRating").val(rating).prop("selected", true);
}

$(document).ajaxSuccess(function(){
	//리뷰 보기 끄기버튼
	$("#btn_close").click(function(){
		$(".modal").css("display","none");
		$("body").css("overflow","auto");
	});
	//리뷰보기 작성하기 버튼
	$("#click_submit").click(function(){
		alert("작성되었습니다.");
		$("#form1").submit();
	});
	//리뷰보기 수정버튼
	$("#click_modify").click(function(){
		if(confirm("수정하시겠습니까?")){
			alert("수정되었습니다!");
			$("#form2").submit();
		}
	});
	//리뷰보기 삭제버튼
	$("#click_delete").click(function(){
		var product_number = $(this).siblings().find("input[name=product_number]").val();
		var order_number = $(this).siblings().find("input[name=order_number]").val();
		if(confirm("정말 삭제하시겠습니까?")){
			$.ajax({
				type:"get",
				url: "DeleteReview",
				data: {"product_number" : product_number, "order_number" : order_number},
				datatype: "json",
				success: function(data) {
					if(data.retNumber=="1"){
						alert("리뷰가 삭제되었습니다!");
						location.href='MainpageServlet';
					}else{
						alert("삭제실패!");
					}
				},											
				error: function(request, status, error) { alert(status); alert(error);}
			}); 
		}
	});
});
</script>
</head>
<body>
<div class='modal'>
	<div class='modal_content'>
		<div class='reviewWrite_body'><!-- 여기에 리뷰 쓰기ajax 들어감 --></div>
		<div class="reviewshow_body"><!-- 여기에 리뷰 보기ajax 들어감 --></div>
	</div>
</div>
<%@ include file="Header.jsp" %>

	<div class="myPageMain">
	
<%@ include file='mypageMain1.jsp'%>
<%@ include file='mypageMain2.jsp'%>		
		
		<div class="myPageMain3">
			<div class="myPageMain3firstLine">
				<h1>구매내역</h1>
			</div>
			
			
			
			<div class="myPageMain3secondLine">
					<%
					ArrayList<OrderListVO> listOrderListVO = null;
					listOrderListVO = (ArrayList<OrderListVO>)request.getAttribute("listOrderListVO");
					
					
					if(listOrderListVO==null){
					%>
						<div class="checkOrderThirdLineImage"></div>
						<p class="noOrderList">구매내역이 없습니다</p>
						<div style='text-align: center; margin-top: 23px;'><button class="goMainPage">쇼핑시작하기</button></div>
					<%
					}else{
						for(OrderListVO vo : listOrderListVO) {
					%>
			
			
			
				
				<div class="orderListDetail">
					<div class='orderListDetailFirst'>
						<div class='orderListDatailOrderNumber'>주문번호 <%=vo.getOrder_number()%></div>
						<div class='orderListDetailOrderDate'><%=vo.getOrder_date()%></div>
					</div> 	
					
					<div class='orderListDetailSecond'>
						<div style='float:left; vertical-align: top;'><img style='width: 115px;height: 115px;border-radius: 18px;border: 6px solid #eba0adc2;'src='Images/<%=vo.getCategory_name_eng()%>/<%=vo.getProduct_name_eng()%>/1.png'></div>
						<div style='float: left;margin-left: 20px;'>
							<img class="sb_mini_image" src="Images/Allshare/TitlePink.png"><br/>
							<div class="subtext"><%=vo.getProduct_name()%></div>	
							<div class="price"><strong><%=vo.getPrice()%></strong><span class="sub_price">원</span></div>
							<div class='rating'>
								<%for(int i=1; i<=vo.getRating();i++){%><img class='Blackstars' src="Images/Allshare/BlackStar.png"/><%}%>
								<%if(vo.getRating()*10%10>=5){%><img class='Whitestars' src="Images/Allshare/WhiteStar.png"/><%}%>
							</div>
						</div>
					</div>
					<div class='orderListDetailThird'>
						<div class='orderListDatailOrderNumber'>수량 <strong style='font-size: 20px; color: red;'><%=vo.getEach_amount()%></strong> 개</div>
						<div class='orderListDetailOrderDate'>총 가격  <%=vo.getEach_amount()*vo.getPrice()%>원</div>
					</div> 
					<div class='orderListDetailFourth' product_number = '<%=vo.getProduct_number()%>' order_number = '<%=vo.getOrder_number()%>'>
						<button class='draftReview'>리뷰 작성</button>
						<button class='showReview'>보기</button>
					</div> 	
				</div>
					<%
						}
					}
					%>
			</div>
			
			<div class="notice">
				<h3>구매내역 안내</h3>
				<ul>
					<li>주문한 상품이력은 당일부터 최근 6개월까지의 정보를 제공합니다.</li>
					<li>약관 비동의후 , 다시 동의를 선택하신 경우에는 <b>동의하신 날부터</b>의 구매이력이 탑재됩니다.</li>
					<li>상품을 수령 한 후 2주가 경과되면 환불이 불가합니다.</li>
					<li>구매관련 영수증은 구매사이트에서 신청 후 직접 출력 가능합니다.</li>
					<li>오후 6시 이후 주문취소를 원하실 때에는 고객센터(010-7164-7233)으로 전화주세요.</li>
				</ul>
			</div>
		</div>
		</div>
<%@ include file='footer.jsp'%>
</body>
</html>