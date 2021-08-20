<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = 'java.sql.*' %>
<%@ page import = 'java.util.*' %>
<%@ page import = 'com.admin.www.*' %>
<%@ page import = 'LikedVO.*' %>
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
		//해당 상품 눌렀을때 그 페이지로
		$(".myPageWishListImg").click(function(){
			var product_number;
			product_number = $(this).parent().attr("product_number");
			alert(product_number);
			location.href="Controller?command=eachProduct&product_number="+product_number;
		});
		
		
		$(".removeLike").click(function(){
			var product_number;
			product_number = $(this).parent().attr("product_number");
			alert(product_number);
			
			if(confirm("좋아요 취소하시겠습니까?")){
				$.ajax({
					type:"get",
					url: "DeleteLike",
					data: {"product_number" : product_number},
					datatype: "json",
					success: function(data) {
						if(data.retNumber=="1"){
							alert("삭제하였습니다");
							location.reload();
						}else{
							alert("좋아요 삭제 실패");
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
		
<%@ include file="Header.jsp" %>
		
	<div class="myPageMain">
		
<%@ include file='mypageMain1.jsp'%>
<%@ include file='mypageMain2.jsp'%>		
		
		<div class="myPageMain3">
			<div class="myPageMain3firstLine">
				<h1>내가 좋아요 한 상품</h1>
			</div>
			<div class="myPageMain3secondLine">
			
				<%
					ArrayList<LikedVO> listLike = null;
					listLike = (ArrayList<LikedVO>)request.getAttribute("listlike");
					
					if(listLike==null){
				%>
					<div class="noList">아직 좋아요한 상품이 없습니다. 상품을 골라주세요</div>
				<%
					}else{
						for(LikedVO lv : listLike){
				%>
						<div class='myPageWishListProDuct' product_number='<%=lv.getProduct_number()%>'>
							<div class='removeLike'>X</div>
							<img src='Images/<%=lv.getProduct_category_name()%>/<%=lv.getProduct_name_eng()%>/1.png' class='myPageWishListImg'/>
							<img class="sb_mini_image" src="Images/Allshare/Title.png">
							<div class="subtext"><%=lv.getProduct_name()%></div>
							<div class="price"><strong><%=lv.getPrice()%></strong><span class="sub_price">원</span></div>
							<div class='rating'>
								<%for(int i=1; i<=lv.getRating();i++){%><img class='Blackstars' src="Images/Allshare/BlackStar.png"/><%}%>
								<%if(lv.getRating()*10%10>=5){%><img class='Whitestars' src="Images/Allshare/WhiteStar.png"/><%}%>
							</div>
						</div>
				<%		
						}
					}
				%>
				
			</div>
		</div>
	</div>
<%@ include file='footer.jsp'%>
</body>
</html>