<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = 'com.admin.www.*' %>
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
		//전체선택시 전체 체크
		$('#all_click').click(function(){
			var checked = $('#all_click').is(':checked');
			if(checked){
				$('input:checkbox').prop('checked',true);
			}else{
				$('input:checkbox').prop('checked',false);
			}
		});
	});//end of function
	$(document).on('click', '.clickButton', function(){
		//다운받기 클릭시 ajax
		var coupon_list = [];
		var check_length = $('input:checkbox[class=click_check]:checked').length;
		var circle = 0;
		$('.click_check:checked').each(function() {
			alert($(this).val());
			var coupon_number = $(this).val();
			coupon_list[circle] = coupon_number;
			circle++;
		});
//alert(coupon_list);
		$.ajax({
			type:"get",
			url: "CouponDuplicate",
			data: {"coupon_list" : JSON.stringify(coupon_list)},
			datatype: "json",
			success: function(data) {
//alert("data.retNumber : " + data.retNumber);
				if(data.retNumber == "0"){
					alert("쿠폰이 다운로드 되었습니다!");
				}else{
					alert("이미 다운한 쿠폰입니다!");
				}
			},											
			error: function(request, status, error) { alert(status); alert(error);}
		});
	});
</script>
</head>
<body>
<%@ include file="Header.jsp" %>

	<div class="myPageMain">
		
<%@ include file='mypageMain1.jsp'%>
<%@ include file='mypageMain2.jsp'%>
		
		<div class="myPageMain3">
			<div class="myPageMain3firstLine">
				<h1>쿠폰</h1>
			</div>
			<div class="myPageMain3secondLine">
					<span class="downloadableCoupon">다운 가능한 쿠폰</span>
					<div class="chooseAll"><input id='all_click' type="checkbox"/>전체선택</div>
				<div class="couponList1">
					<input class='click_check' type="checkbox" value='1'/>
				</div>
				<div class="couponList2">
					<input class='click_check' type="checkbox" value='2'/>
				</div>
				<div class="couponList3">
					<input class='click_check' type="checkbox" value='3'/>
				</div>
			</div>
			
			<div class="clickButton">다운받기</div>
			
			<div class="notice">
				<h3>쿠폰안내</h3>
				<ul>
					<li>사용기간이 만료된 쿠폰은 보유 목록에서 자동으로 삭제됩니다.</li>
					<li>동일한 쿠폰인 경우, ‘쿠폰할인율 별 적용상품’이 다를 수 있으며, 할인율 별로 쿠폰의 개수가 합산됩니다.</li>
					<li>주문 결제하실 때 ‘쿠폰’을 직접 선택하여 사용하기를 하지 않은 경우, 쿠폰 할인 금액은 자동으로 할인되지 않습니다.</li>
					<li>단 상품발송 전 주문을 전체 취소하신 경우에는 쿠폰을 다시 사용하실 수 있습니다.</li>
					<li>결제할인쿠폰은 상품권, 서비스상품, 행사상품, 특가상품 등 일부 상품에는 적용되지 않습니다.</li>
					<li>쿠폰 할인 금액이 총 결제 금액보다 크더라도 차액은 환급되지 않습니다.</li>
					<li>지급된 쿠폰은 타 회원계정에 양도하거나, 현금 환급이 불가합니다.</li>
					<li>1개의 결제건당 1개의 쿠폰만 사용 가능합니다.</li>
				</ul>
			</div>
		</div>
	</div>
<%@ include file='footer.jsp'%>
</body>
</html>