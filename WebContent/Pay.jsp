<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import='com.admin.www.*' %>
<%@ page import='PayVO.*' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
<link rel="stylesheet" href="css/ssag.css">
<link rel="stylesheet" href="css/Allshare.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="js/Allshare.js"></script>
<script>
	
	$(function(){
		$("#couponNumber").change(function() {
			var num1 = Number($(".pay_info2_p9 span").eq(0).text().replace('원',''));
			var a = $(this).val();
			
			
			var num2;
		 	if(a!="쿠폰선택"){ 
				if(a.length==3){   // 퍼센트 할인일 때.
					var pct = $(this).val();
					pct = Number(pct.replace("%",""))*0.01;
					$(".coupon_name_text").text(num1*pct + "원");  // .coupon_name_text 는 '할인금액'
				
					num2 = num1*pct;
				} else {           // 금액 할인일 때.
					var a = Number($(this).val().replace('원',''))*-1;
					$(".coupon_name_text").text(a+'원');           // .coupon_name_text 는 '할인금액'
					num2 = a;  // 할인금액을 0으로.
				}
			 
		 	} else {    // '쿠폰선택'을 선택했으면.
		 		$(".coupon_name_text").text('0원');               // .coupon_name_text 는 '할인금액'
		 		num2 = 0;    // 할인금액을 0으로.
		 	}
			var result = num1-num2;
			$(".final_price").text(result+"원");
		});
		
		
		
		///배송지 입력관련
		$(".select_area2_p9").change(function(){
			if(6==$(this).val()){
				$(".customerMessage").css('display','block');
				e.preventDefault();
			}else{
				$(".customerMessage").css('display','none');
				e.preventDefault();
			}
			
			
		});
		
		$(".button-size_p9").click(function(){
			
			if($("#checking2").is(':checked')){
				
				var product_number = $(this).parents().find(".content_order3-1_p9 img").attr("product_number");
				var amount = $(".eachproductAmount").text();
				var used_c_number = $("#couponNumber option:selected").attr("id");
				var cost = $(this).parents().find(".pay_info2_p9 .final_price").text();
				cost = cost.replace("원", "");
				var requirements = $("#requirements option:selected").text();
				requirements = encodeURI(requirements);
				
				location.href = "Controller?command=insertintoOrderList&product_number="+product_number+"&amount="+amount+"&used_c_number="+used_c_number+"&cost="+cost+"&requirements="+requirements;
			 } else alert("체크박스를 체크해주세요!");
			
		});
	});
</script>
<style>
	.changeSomeofInfo{
		margin-left: 10px; color:#97938d
	}
	.customerMessage {
		display:none;
	}
</style>
</head>
<body>
	<div class="main_content">
		
	<%@ include file="Header.jsp" %>
	
		<div class="main_content2_p9">
			<h1>결제하기</h1>
			<div>
				<div class="content_head_title_p9">
					<h2>받는 분 정보</h2>
				</div>
				<div>
					<div class="member_content2_p9">
						<div class="member_content2-1_p9"><span>배송지 정보</span></div>
						<div class="member_content2-2_p9">
						<%
							MemberVO member = (MemberVO)request.getAttribute("userInfo");
						%>
							<div>[우리집] <%=member.getAdress()%><span class='changeSomeofInfo'>배송지 변경></span></div>
						</div>
					</div>
				
				 	<div class="member_content2_p9"> 
						<div class="member_content2-1_p9"><span>택배배송 요청사항</span></div>

						<div class="select_area_p9" >
							<select class="select_area2_p9" id='requirements'>
								<option value="1">배송기사에게 전달되는 메세지 입니다. 선택하여 주세요.</option>
								<option value="2">부재 시 경비실에 맡겨주세요</option>
								<option value="3">부재 시 문 앞에 놓아주세요</option>
								<option value="4">직접 받겠습니다</option>
								<option value="5">배송 전에 연락주세요</option>
								<option value="6">직접입력</option>
							</select>
						</div>

						<div class='customerMessage'>
							<input type='text' placeholder='요청사항을 직접 입력하세요.' style='margin: 12px 0px 8px 198px; width: 495px; height: 30px;'/>
						</div>
				 	</div>
					
					
					<div class="member_content2_p9">
						<div class="member_content2-3_p9">
							<div class="member_content2-1_p9"><span>휴대폰</span></div>
							<span><%=member.getPhone() %></span>
							<span class='changeSomeofInfo'>인증번호 변경하기 ></span>
						</div>
						<div class="member_content2-3_p9">
							<div class="member_content2-1_p9"><span>주문자명/이메일</span></div>
							<span><%=member.getName() %> / <%=member.getEmail() %></span>
							<span class='changeSomeofInfo'>주문자 정보변경 ></span>
						</div>
					</div>
				</div>
			<%
				ArrayList<ProductVO> product = (ArrayList<ProductVO>)request.getAttribute("productList");
				
				
				int totalprice = 0;
				
				for(ProductVO vo : product){
					totalprice += vo.getEachproductprice();							
			%>
				<div class="content_order_p9">				
				
					<h2>수량 <span class='eachproductAmount'><%=vo.getAmount()%></span></h2>
					<div class="content_order3_p9">
						<div class="content_order3-1_p9">
							<img product_number='<%=vo.getProduct_number()%>' style="width:90px; height:90;" src="Images/<%=vo.getCategory_name_eng() %>/<%=vo.getProduct_name_eng() %>/1.png"/>
						</div>
						<div class="content_order3-2_p9">
							<div><img style="width:50px; height:17;" src="Images/PayPic/스타벅스.png"></div>
							<div>스타벅스</div>
							<div><%=vo.getProduct_name() %></div>
							<% for(int i=1; i<=vo.getRating(); i++) { %><img style="width:16px; height:16px;" src="Images/MainpagePic/starsFull.png"/><% } %>
							<% if(vo.getRating()*10%10>=5) { %><img style="width:16px; height:16px;" src="Images/MainpagePic/starsEmpty.png"/><% } %>
						</div>
						<div class="content_order3-3_p9">
							<div class="content_order_price_p9">
								<em class="price_font_p9"><%=vo.getEachproductprice()%></em>
								<span>원</span>
							</div>
						</div>
					</div>
				</div>
			<%
				}
			%>
				<div>
					<div class="sale_title_p9"><h2>할인정보</h2></div>
					<div class="sale_info2_p9">
						<dl class="sale_info2-l_p9">
							<dt class="sale_info2-1_p9"><span>주문금액</span></dt>
							<dt class="sale_info2-2_p9"><span><%=totalprice%></span>원</dt>
						</dl>
					</div>
					<div class="sale_info2_p9">
						<dl class="sale_info2-l_p9">
							<dt class="sale_info2-1_p9">쿠폰할인</dt>
							<dt class="sale_info2-2_p9">
								<span class='coupon_name_text'></span> [할인] 
								<select id='couponNumber'>
									<option id='0'>쿠폰선택</option>
									<%
										ArrayList<CouponVO> list2 = (ArrayList<CouponVO>)request.getAttribute("couponList");
											for(int i=0; i<=list2.size()-1; i++){
												 String strCouponName = list2.get(i).getCoupon_name();
												if(strCouponName.contains("%") || (strCouponName.contains("원") && totalprice>=Integer.parseInt(strCouponName.replace("원", ""))*-1) ) {
									%>
										<option class='coupon_name' id='<%=list2.get(i).getCoupon_number()%>'><%=list2.get(i).getCoupon_name()%></option>
									<%	
												}	
											}		
									%>
								</select>
							</dt>
						</dl>
					</div>
					<div class="sale_info2_p9">
						<dl class="sale_info2-l_p9">
							<dt class="sale_info2-1_p9"><span>할인 후 금액</span></dt>
							<dt class="sale_info2-2_p9"><span class="final_price"><%=product.get(0).getEachproductprice()%>원</span></dt>
						</dl>
					</div>
				</div>
				
				<div class="pay_info_p9">
					<div class="pay_info2_p9">
						주문금액 : <span><%=product.get(0).getEachproductprice()%>원</span>
						 - 상품 및 쿠폰 할인<span class='coupon_name_text'></span>
						 = 결제예정금액 : <span class="final_price"><%=product.get(0).getEachproductprice()%></span>
					</div>
					
					<div class="padding2_p9">
						<input type="checkbox" id="checking2" onclick='selectAll(this.checked);'>
						<label for="checking2"><span>주문 상품정보 및 서비스 이용약관에 모두 동의하십니까?</span></label>
					</div>
					
				</div>
			</div>
		</div>
			<div style="text-align:center;">
				<button class="button-size_p9">결제하기</button>
			</div>	
	</div>
<%@ include file='footer.jsp'%>
</body>
</html>