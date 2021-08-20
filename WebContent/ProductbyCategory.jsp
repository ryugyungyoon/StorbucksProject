<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import='ProductbyCategoryVO.*' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>각 카테고리별</title>
<link rel="stylesheet" href="css/storebucks.css"/>
<link rel="stylesheet" href="css/Allshare.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="js/Allshare.js"></script>
<style>
	ul >li {
		list-style:none;
		display:inline-block;
	}
	.productCategoryImg{
		height: 230px;
		width: 256px;
		cursor:pointer;
	}
</style>
</head>
<body>
	<%@ include file='decimalFormat.jsp'%>
	<%
		ArrayList<ProductCategoryVO> productList = null;
		productList = (ArrayList<ProductCategoryVO>)request.getAttribute("productList");
	%>
	<div id="body_Category">
		
			<%@ include file="Header.jsp" %>
		
		<h3>Home / <%=productList.get(0).getCategory_name()%></h3>
		<div class="ct_Title">
			<h1><%=productList.get(0).getCategory_name()%></h1>
			<div class="ct_Product"><span style="color:red;">${number}</span>개의 상품이 있습니다.</div>	
		</div>

		<div class="category_Mainmenu">			
			<div class="main_Products">
				
				<div style='margin: 30px 0px;'>
				<%
					for(ProductCategoryVO pc : productList){
				%>
					<div class='categoryEach' product_number='<%=pc.getProduct_number()%>'>					
						<img class='productCategoryImg' src='Images/<%=pc.getCategory_name_eng()%>/<%=pc.getProduct_name_eng()%>/1.png' '>
						<div class="cunit_info">
							<img class="sb_mini_image" src="Images/Allshare/Title.png"/>
							<div class="subtext"><%=pc.getProduct_name()%></div>
							<div class="price"><%=withCommas(pc.getPrice())%><span class="ssg_tx">원</span></div>
							<div class='rating'>
							<% for(int i=1; i<=pc.getRating(); i++) { %><img class='Blackstars' src="Images/Allshare/BlackStar.png"/><% } %>
							<% if(pc.getRating()*10%10>=5) { %><img class='Whitestars' src="Images/Allshare/WhiteStar.png"/><% } %>
							</div>
						</div>
					</div>
				<%
					}
				%>
				
				
				</div>
				
			</div>

<%@ include file="SearchMenu.jsp" %>		
			
		</div>	
	</div>	
<%@ include file='footer.jsp'%>
</body>
</html>