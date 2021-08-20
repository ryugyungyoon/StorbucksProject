<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = 'EachproductVO.*' %>
<%@ page import = 'com.admin.www.*' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/storbucksCss.css">
<link rel="stylesheet" type="text/css" href="css/Allshare.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="js/Allshare.js"></script>
<script>

//3자리수 콤마
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

$(function(){
	eachprice =  $(".amountprice").val();
	eachprice = eachprice.replace(",","");
	//+버튼클릭
	$("#p").click(function(){
		eachamount = Number($("#eachamount").val());
		eachamount += 1;
		
		$("#eachamount").val(eachamount); //수량증가
		
		var total = 0;
		total = Number(eachprice)*eachamount;
		
		total = numberWithCommas(total);
		$(".amountprice").val(total);
	});
	//-버튼클릭		
	$("#m").click(function(){
		eachamount = Number($("#eachamount").val());
		eachamount -= 1;
		
		if(eachamount >0){
			$("#eachamount").val(eachamount);
			
			var total = Number(eachprice)*eachamount;
			total = numberWithCommas(total);					
			$(".amountprice").val(total);
		}
		else {
			alert('최소 한개의 수량이 있어야 합니다.')
		}
	});
	//좋아요 눌렀을떄
	$(".jjim").click(function(){
		var product_number = $(this).parents().find(".roundleftHead").attr("product_number")
		var login_id = '<%=session.getAttribute("login_id")%>';
		
		if(login_id!='null'){
			$.ajax({
				type:"get",
				url: "AddToLiked",
				data: {"product_number" : product_number},
				datatype: "json",
				success: function(data) {
					if(data.retNumber=="1"){
						alert("좋아요 목록에 저장되었습니다.");
					}else{
						alert("이미 찜한 상품입니다!");
					}
				},											
				error: function(request, status, error) { alert(status); alert(error);}
			});
		}else{alert("로그인 먼저 해주세요");}
	});
	//장바구니 눌렀을때
	$(".jangbaguni").click(function(){
		var product_number = $(this).parents().find(".roundleftHead").attr("product_number");
		var amount = $(this).parents().find("#eachamount").val();
		
		
		var login_id = '<%=session.getAttribute("login_id")%>';
		
		if(login_id!='null'){
			$.ajax({
				type:"get",
				url: "AddToWishList",
				data: {"product_number" : product_number, "amount" : amount},
				datatype: "json",
				success: function(data) {
					if(data.retNumber=="1"){
						alert("장바구니에 등록되었습니다.");
					}else{
						alert("이미 장바구니에 등록된 상품입니다!");
					}
				},											
				error: function(request, status, error) { alert(status); alert(error);}
			});
		}else{alert("로그인 먼저 해주세요");}
	});
	//바로구매 눌렀을 때
	 $(".baro").click(function(){
		 
		 var login_id = '<%=session.getAttribute("login_id")%>'; 
		 
		 if(login_id!='null'){
			var product_number = $(this).parents().find(".roundleftHead").attr("product_number")
			var amount = $(".input_amount").val();
			location.href="Controller?command=pay&product_number="+product_number+"&amount="+amount;
		 }else{ alert("로그인 해야 구매가능")}
		 
	});
}); // the end of $(function). 
</script>

<script>
	//리뷰 최신순 함수
	function ratingLatest(page,productNumber){
		$.ajax({
			type : "get",
			url : "RatingLatestServlet",
			data :{"page" : page, "productNumber" : productNumber},
			datatype:"json",
			success: function(data){
				//------------------------------	
				var total = Object.keys(data.list).length;
					var str = '';
					for(var i=0; i<=total-1; i++) {
						var rating = data.list[i].rating;
						var img = "<div class='rating'>";
						for(var j=1; j<=rating; j++){
							img += "<img class='Blackstars' src='Images/Allshare/BlackStar.png'/>";
						}
						img += '</div>'
						
						str += '<div class="reviewpage">'
								+'<div class="reviewNum">'+data.list[i].rno+'</div>'
								+'<div class="reviewRating">'+img+'</div>'
								+'<div class="reviewTitle">'+data.list[i].title+'</div>'
								+'<div class="reviewId">'+data.list[i].writer_id+'</div>'
								+'<div class="reviewDate">'+data.list[i].review_date+'</div>'
								+'<textarea placeholder="'+data.list[i].content+'" class="contentop"></textarea>'
								+'</div>';
					}
					$(".lastboard").html(str);
				//------------------------------	
					var pageList = data.pageList;
	
					var text='';
					for(var i=1; i<=pageList; i++){
						
						if(page==i){
							text+= "<div class='btn_pageNone'>"+i+"</div>"							
						}else{
							text+= "<button class='btn_page' value='"+i+"'>"+i+"</button>";
						}
					}
					$(".boardnum").html(text);
			},
			error: function(request, status , error) {
				var str = "<p>리뷰가 없습니다. 리뷰를 작성해주세요</p>";
				$(".mainpage3").html(str);
			}
		});
	}

//리뷰 평점높은순 함수
function ratingOver(page,productNumber){
	$.ajax({
		type : "get",
		url : "RatingOverServlet",
		data :{"page" : page , "productNumber" : productNumber},
		datatype:"json",
		success: function(data){
			//------------------------------	
			var total = Object.keys(data.list).length;
				var str = '';
				for(var i=0; i<=total-1; i++) {
					var rating = data.list[i].rating;
					var img = "<div class='rating'>";
					for(var j=1; j<=rating; j++){
						img += "<img class='Blackstars' src='Images/Allshare/BlackStar.png'/>";
					}
					img += '</div>'
					
					str += '<div class="reviewpage">'
							+'<div class="reviewNum">'+data.list[i].rno+'</div>'
							+'<div class="reviewRating">'+img+'</div>'
							+'<div class="reviewTitle">'+data.list[i].title+'</div>'
							+'<div class="reviewId">'+data.list[i].writer_id+'</div>'
							+'<div class="reviewDate">'+data.list[i].review_date+'</div>'
							+'<textarea placeholder="'+data.list[i].content+'" class="contentop"></textarea>'
							+'</div>';
				}
				$(".lastboard").html(str);
			//------------------------------	
				var pageList = data.pageList;
				
				var text='';
				for(var i=1; i<=pageList; i++){
					
					if(page==i){
						text+= "<div class='btn_pageNone'>"+i+"</div>"							
					}else{
						text+= "<button class='btn_page' value='"+i+"'>"+i+"</button>";
					}
				}
				$(".boardnum").html(text);
		},
		error: function(request, status , error) { alert(status); alert(error); }
	});
}
//리뷰 평점낮은순 함수
function ratingDown(page,productNumber){
	$.ajax({
		type : "get",
		url : "RatingDownServlet",
		data :{"page" : page, "productNumber" : productNumber},
		datatype:"json",
		success: function(data){
			//------------------------------	
			var total = Object.keys(data.list).length;
				var str = '';
				for(var i=0; i<=total-1; i++) {
					var rating = data.list[i].rating;
					var img = "<div class='rating'>";
					for(var j=1; j<=rating; j++){
						img += "<img class='Blackstars' src='Images/Allshare/BlackStar.png'/>";
					}
					img += '</div>'
					
					str += '<div class="reviewpage">'
							+'<div class="reviewNum">'+data.list[i].rno+'</div>'
							+'<div class="reviewRating">'+img+'</div>'
							+'<div class="reviewTitle">'+data.list[i].title+'</div>'
							+'<div class="reviewId">'+data.list[i].writer_id+'</div>'
							+'<div class="reviewDate">'+data.list[i].review_date+'</div>'
							+'<textarea placeholder="'+data.list[i].content+'" class="contentop"></textarea>'
							+'</div>';
				}
				$(".lastboard").html(str);
			//------------------------------	
				var pageList = data.pageList;
				
				var text='';
				for(var i=1; i<=pageList; i++){
					
					if(page==i){
						text+= "<div class='btn_pageNone'>"+i+"</div>"							
					}else{
						text+= "<button class='btn_page' value='"+i+"'>"+i+"</button>";
					}
				}
				$(".boardnum").html(text);
		},
		error: function(request, status , error) {alert(status); alert(error);}
	});
}

$(function(){
	var page = 1;
	
	var productNumber = $(".roundleftHead").attr("product_number");
	//맨처음 페이지 로딩될때 기본값
	ratingLatest(page,productNumber);
	$("#reviewCategorySelected").change(function(){
		var state = $('#reviewCategorySelected option:selected').val();
		if(state =='ratingLatest'){
			ratingLatest(page,productNumber);
		}else if(state=='ratingOver'){
			ratingOver(page,productNumber);
		}
		else if(state='ratingDown'){
			ratingDown(page,productNumber);
		}
	});	
});//end of $(function())
	
$(document).on('click', '.reviewTitle', function(){
	//리뷰제목 클릭시 리뷰내용나오게
	if("block" == $(this).parent().find(".contentop").css("display")){
		$(this).parent().find(".contentop").css("display","none");
	}else{
		$(this).parent().find(".contentop").css("display","block");
	}
	
});
$(document).on('click','.btn_page',function(){
	//리뷰페이지 버튼 클릭시 페이징
	var page = $(this).val();
	var productNumber = $(".roundleftHead").attr("product_number");
	var category = $(this).parents().find('#reviewCategorySelected option:selected').val();
	
	if(category =='ratingLatest'){
		ratingLatest(page, productNumber);
	}else if(category == 'ratingOver'){
		ratingOver(page, productNumber);
	}else if(category == 'ratingDown'){
		ratingDown(page, productNumber);
	}
});
</script>
<style>
	#reviewCategorySelected, #reviewCategorySelected option{
		cursor:pointer;
	}
</style>
</head>
<body>
<% 
	String date = "";
	date = (String)(request.getAttribute("date"));
%>

<%@ include file='decimalFormat.jsp' %>
<%@ include file="Header.jsp" %>
<div class="mainpage">
		<div style='height: 850px;'>
			<div class="roundleft">
				<%
					EachproductVO vo = (EachproductVO)request.getAttribute("vo");
				%>
				<img class='roundleftHead' src="Images/<%=vo.getCategory_name_eng()%>/<%=vo.getProduct_name_eng()%>/1.png" product_number='<%=vo.getProduct_number()%>'/>
				<div class="roundleftbottom">
					<img src = "Images/<%=vo.getCategory_name_eng()%>/<%=vo.getProduct_name_eng()%>/1.png" class="smallimage">
					<img src = "Images/<%=vo.getCategory_name_eng()%>/<%=vo.getProduct_name_eng()%>/2.png" class="smallimage"/>
					<img src = "Images/<%=vo.getCategory_name_eng()%>/<%=vo.getProduct_name_eng()%>/3.png" class="smallimage"/>
				</div>
				<div>
					<div class='rating'>
						<%for(int j=1; j<=vo.getRating();j++){%><img class='Blackstars' src="Images/Allshare/BlackStar.png"/><%}%>
						<%if(vo.getRating()*10%10>=5){%><img class='Whitestars' src="Images/Allshare/WhiteStar.png"/><%}%>
					</div>	
					<span class="bestitem_scope"><%=vo.getRating()%>/5점</span>
				</div>
			</div>
			
			<div class="roundright">
				<div style='margin-left: 15px;'>
					<div class=please4>[스타벅스]<%=vo.getProduct_name()%></div>
				</div>
				<div class="option3">
					<div class="eachproduct_area">
							<span class="cpprice">정가</span>
							<span class="cpprices"><%=withCommas(vo.getPrice())%>원</span>
					</div>
					<div class="eachproduct_area">
							<span class="cpprice">최저가</span>
							<span class="cpprices"><%=withCommas((int)(vo.getPrice()*0.9))%>원~</span>
					</div>
					<div class="eachproduct_area">
							<span class="cpprice">배송비</span>
							<span class="cpprices">무료</span>
					</div>
					<div class="eachproduct_area">
							<span class="cpprice">배송정보</span>
							<span class="cpprices"><%=date%> 도착 예정 (최대 5일 이내 도착, 토/일 공휴일 제외)</span>
					</div>
				</div>
				<div class="pricens2">
					<div class="rightpyo1">
						<div style="margin: 0px 0px 20px 30px;">
							<span class="into">[스타벅스]<%=vo.getProduct_name()%></span>
						</div>	
							<div class="amount">
								<button id = "m">-</button>
									<input class="input_amount" type='text' value='1' style="width: 20px;" id="eachamount"/>
								<button id = "p">+</button>
							</div>	
					</div>
				</div>
			
				<div class="eachproduct_area">합계 
					<input type ="text" value = <%=withCommas(vo.getPrice())%> class="amountprice" readonly/>
		   			원
				</div>
	 			<div class="rightpyo2">
				   	<span class="jangbaguni">장바구니</span>
				   	<span class="baro">바로구매</span>
				   	<span class="jjim">좋아요</span>
	   			</div>
			</div>
			
		</div>

	<div>
		<span class="togetherworld">함께 보면 좋은 상품</span>
		<span class='togethermore'>더보기 > </span>
	</div>
						
	<div class="last">
		<%
			ArrayList<EachproductVO> list = (ArrayList<EachproductVO>)request.getAttribute("list");
			int[] repeat = (int[])request.getAttribute("repeat");		
			
			
			for(int i=1; i<=4; i++){
		%>
		<div class="last1" product_number ='<%=list.get((repeat[i-1])-1).getProduct_number()%>'>
			<img src = "Images/<%=list.get((repeat[i-1])-1).getCategory_name_eng()%>/<%=list.get((repeat[i-1])-1).getProduct_name_eng()%>/1.png" class="lastimage"/>
			<img class="sb_mini_image" src="Images/Allshare/Title.png"/>		
			<div class="subtext"><%=list.get((repeat[i-1])-1).getProduct_name()%></div>
			<div class="price"><%=withCommas(list.get((repeat[i-1])-1).getPrice())%>원</div>
			<div class='rating'>
				<%for(int j=1; j<=list.get((repeat[i-1])-1).getRating();j++){%><img class='Blackstars' src="Images/Allshare/BlackStar.png"/><%}%>
				<%if(list.get((repeat[i-1])-1).getRating()*10%10>=5){%><img class='Whitestars' src="Images/Allshare/WhiteStar.png"/><%}%>
			</div>
			<span class="bestitem_scope"><%=list.get((repeat[i-1])-1).getRating()%>점</span>
		</div>
		<%		
			}
		%>
	</div>
	
		<div class="pyodiv">
			<div class="pyodiv1">상품상세정보</div>
			<div class="pyodiv2">고객리뷰</div>
			<div class="pyodiv3">배송/반품/교환 안내</div>
		</div>
		
		<div class="thispoint1">
			<div class="sangsae1">
				<h1>상품상세정보</h1>
				<div>상품번호 : <%=vo.getProduct_number()%></div>
			</div>
			<div>
				<div class="inforworld"><%=vo.getInfo_title()%></div>
				<div class="tellinfor"><%=vo.getInfo_content()%></div>
			</div>
			<div class='productDetail'>
				<img src = "Images/<%=vo.getCategory_name_eng()%>/<%=vo.getProduct_name_eng()%>/1.png">
			</div>
			<div class='productDetail'>
				<img src = "Images/<%=vo.getCategory_name_eng()%>/<%=vo.getProduct_name_eng()%>/2.png">
			</div>
			<div class='productDetail'>
				<img src = "Images/<%=vo.getCategory_name_eng()%>/<%=vo.getProduct_name_eng()%>/3.png">
			</div>
		</div>
			
		<div class="thispoint2">
		
		
		
			<div class="mainpage3">
				<div class="customorReview">고객리뷰</div>	
				<div class="reviewtext">※ 리뷰 등록,삭제 및 상세 내용은[마이페이지>리뷰관리]에서 확인하실 수 있습니다.</div>
				<div class="reviewSelect">
					<select id = "reviewCategorySelected">
						<option value = "ratingLatest" selected>최신순</option>
						<option value = "ratingOver">평점높은순</option>
						<option value = "ratingDown">평점낮은순</option>
					</select>
				</div>
			
				<div class="lastboard"> <!-- 여기에 항시로 ajax로 로딩할꺼임 --></div>
				<div class="boardnum"> <!-- 여기사이에 버튼들 페이징하는버튼들 이전 다음 그런것까지 --> </div>
			</div>
		
		
		
		
		
		</div>
		
		<div class='thispoint3'>
				<div class="deliverytitle">배송안내</div>
				<div class="delivery">
					<div class="deliveryImage1">
						<img src ="Images/eachproductPic/택배배송.png"/>
					</div>
					<div class="deliveryImage2">
						<div class="deliveryworld">택배배송</div>
						<div>업체 및 산지에서 주문 후 평균 2~3일 이내 택배 배송됩니다.</div>
					</div>
					<div class="deliveryImage3">
						<span class="deliveryoption">상품상세 상단 표기된 배송비 참고</span>
					</div>
				</div>
				<div class="delivery">
					<div class="deliveryImage1">
						<img src ="Images/eachproductPic/매장픽업.png"/>
					</div>
					<div class="deliveryImage2">
						<div class="deliveryworld">매장픽업</div>
						<div>오프라인 매장에서 직접 방문해서 상품을 픽업! 더 빠르게 만나보세요!</div>
					</div>
					<div class="deliveryImage3">
						<span class="deliveryoption">배송비없음</span>
					</div>
				</div>
				<div class="delivery">
					<div class="deliveryImage1">
						<img src ="Images/eachproductPic/해외배송.png"/>
					</div>
					<div class="deliveryImage2">
						<div class="deliveryworld">해외배송</div>
						<div class="deliverycontent3">Storbucks 상품이 해외 특급 우편을 통해 해외배송 됩니다.</div>
					</div>
					<div class="deliveryImage3">
						<span class="deliveryoption">배송비없음</span>
					</div>
				</div>
				<ul class="deliverylastworld">
					<li>택배 배송기일은 휴일 포함여부 및 상품 재고상황, 택배사 사정에 의해 지연될 수 있습니다.</li>
					<li>제주/도서산간 지역은 추가 운임이 발생할 수 있습니다.</li>
					<li>[다중배송] 장바구니에서 여러 주소지로 한번에 주문 결제가 가능합니다. (일부상품 제외)</li>
				</ul>
				<div class="deliverytitle">교환 및 반품 안내</div>
				<div class="delivery">
					<div class="exchangetitle"> 교환 반품 신청기간</div>
					<div class="exchangeImage1">
						<div class="exchangeworld">단순변심 및 사이즈/색상 불만에 관련된 교환/반품 신청은 배송완료 후 7일 이내에 가능합니다.</div>
						<div class="exchangeworld">상품이 표기/광고내용과 다르거나 계약내용과 다른 경우 상품을 받으신 날부터 3개월 이내,</div>
						<div class="exchangeworld">또는 사실을 알게된 날(알 수 있었던 날)부터 30일 이내에 신청 가능합니다.</div>
						<div class="deliverycontent1"></div>
					</div>
				</div>
				<div class="exchange1">
					<div class="exchangetitle"> 교환 반품 신청기간</div>
						<div class="exchangeImage1">
							<div class="exchangeworld" style='color:red;'>전자상거래 등에서 소비자보호에 관한 법률에 따라 다음의 경우 청약철회가 제한될 수 있습니다.</div>
							<div class="exchangeworld">고객님이 상품 포장을 개봉하여 사용 또는 설치 완료되어 상품의 가치가 훼손된 경우</div>
							<div class="exchangeworld">(단, 내용 확인을 위한 포장 개봉의 경우는 예외)</div>
							<div class="exchangeworld">고객님의 단순변심으로 인한 교환/반품 신청이 상품 수령한 날로부터 7일이 경과한 경우</div>
							<div class="exchangeworld">신선식품(냉장/냉동 포함)을 단순변심/주문착오로 교환/반품 신청하는 경우</div>
							<div class="exchangeworld">고객님의 사용 또는 일부 소비에 의해 상품의 가치가 훼손된 경우</div>
							<div class="exchangeworld">시간 경과에 따라 상품 등의 가치가 현저히 감소하여 재판매가 불가능한 경우</div>
							<div class="exchangeworld">복제가 가능한 재화 등의 포장을 훼손한 경우(DVD, CD, 도서 등 복제 가능한 상품)</div>
							<div class="exchangeworld">고객님이 이상 여부를 확인한 후 설치가 완료된 상품의 경우(가전, 가구, 헬스기구 등)</div>
							<div class="exchangeworld">구매한 상품의 구성품이 누락된 경우(화장품 세트, 의류부착 악세서리, 가전제품 부속품, 사은품 등)</div>
							<div class="exchangeworld">기타, 상품의 교환, 환불 및 상품 결함 등의 보상은 소비자분쟁해결기준(공정거래위원회 고시)에 의함</div>
						</div>
				</div>
				<div class="exchangelastworldmain">
						<div class="exchangelastworld">자세한 내용은 고객센터로 문의 부탁드립니다. (A/S 문의는 제조사로 먼저 문의 시 빠르게 처리 가능합니다.)</div>
						<div class="exchangelastworld">전자상거래 등에서의 소비자 보호에 관한 법률에 의한 반품규정이 판매자가 상품상세 페이지 등에서 개별적으로 고지 또는 지정한 반품조건보다 우선합니다.</div>
			   </div>
		</div>
	</div>
<%@ include file='footer.jsp'%>
</body>
</html>