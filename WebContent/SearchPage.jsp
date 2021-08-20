<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import='SearchPageVO.*' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색창</title>
<link rel="stylesheet" href="css/storebucks.css"/>
<link rel="stylesheet" href="css/Allshare.css">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="js/Allshare.js"></script>
<script>
	$(function(){
		//각 제품클릭했을때 이동
		$(".categoryEach").click(function(){
			 var product_number = $(this).attr("product_number");
	         location.href = "Controller?command=eachProduct&product_number=" + product_number;
		});
		

		
	});
	
	</script>
<style>
	ul >li {
		list-style:none;
		display:inline-block;
	}
</style>
</head>
<body>
	<%@ include file='decimalFormat.jsp' %>

	<div id="body_Category">
		
		<%@ include file="Header.jsp" %>
		
		<div class="ct_Title">
		</div>

		<div class="category_Mainmenu">			
			<div class="main_Products">
				<%
					ArrayList<SearchPageVO> searchList = new ArrayList<>();
					searchList = (ArrayList<SearchPageVO>)request.getAttribute("searchList");
					
					if(searchList==null) {
				%>
				<div style='text-align:center; margin-top:100px;'>
					<h1>검색어 '<%=request.getParameter("product_name") %>' 에 해당하는 상품이 없습니다</h1>
				</div>
				<%					
					} else {
				%>
				<div class="check_box_Delivery"></div>
				
				<div style='margin: 30px 0px;'>
				<% 
						for(SearchPageVO sp : searchList){

				%>
					<div class='categoryEach' product_number='<%=sp.getProduct_number()%>'>					
						<img src='Images/<%=sp.getCategory_name_eng()%>/<%=sp.getProduct_name_eng()%>/1.png' style='height: 230px; width: 256px;'>
						<div class="cunit_info">
							<img class="sb_mini_image" src="Images/Allshare/Title.png"/>
							<div class="subtext"><%=sp.getProduct_name()%></div>
							<div class="price"><%=withCommas(sp.getPrice())%><span class="ssg_tx">원</span></div>
							<div class='rating'>
								<%for(int i=1; i<=sp.getRating();i++){%><img class='Blackstars' src="Images/Allshare/BlackStar.png"/><%}%>
								<%if(sp.getRating()*10%10>=5){%><img class='Whitestars' src="Images/Allshare/WhiteStar.png"/><%}%>
							</div>
						</div>
					</div>
				<%
						}
				
				
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