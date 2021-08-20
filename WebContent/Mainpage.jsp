<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="MainpageVO.*" %>
<%@ page import='com.admin.www.*' %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="css/Allshare.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script src="js/Allshare.js"></script>
<script>
$(function(){
	//슬라이드
	$('.bxslider').bxSlider({
		mode: 'horizontal',
		slideWidth: 1280
	});	
	//상품더보기
		var count_num = 11;
      $(".button_more").click(function(e) {
    	  
    	  e.preventDefault();         
        // $(".sbux_best_item").css('display','block');
         
         $(".bestitem").each(function(index, item) {   
            if(index>=count_num+1 && index<=count_num+12) {
               $(item).slideDown(1500);
            }
         });
         count_num += 12;   
         if(count_num>=50) {   
            count_num = 50;
            $(".button_more").hide();
         }

         $('html,body').animate({ scrollTop: $(document).height()+2000 }, 1500, function() { $('html,body').stop(); $(".bestitem").stop(); }); 
         
      });      
});
</script>
</head>
<body>
	<%@ include file='decimalFormat.jsp'%>
	<%@ include file="Header.jsp" %>

		<div class="main_home_content">	
			<div id="slide_div">
				<ul class="bxslider"> 					
					<li>
						<div>
							<img style="margin-top:30px;" class="advertise_fl" src="http://ui.ssgcdn.com/cmpt/banner/202104/2021040916592975990202222120_110.png"/>
							<div class="advertise_text fl">
								<h3 style="margin: 0px;">
									<span>One with the Sun</span><br/>
									<span>Summer MD 출시</span>
								</h3>
								<div>
									<div class="text">신비로운 바닷속 풍경을 담은 MD와 </div>
									<div class="text">다양한 스탠리 상품들</div>
								</div>
							</div>						
						</div>
					</li> 
					<li>
						<div>
							<img class="advertise_fl" src="http://ui.ssgcdn.com/cmpt/banner/202105/2021050413594325936126677612_856.png"/>
							<div class="advertise_text fl">
								<span>Gift 베스트셀러</span><br/>
								<span>스타벅스 10만원 쿠폰</span>
								<div class="text1">음료부터 디저트까지</div>
								<div class="text2">골라보세요</div>
							</div>
						</div>
					</li> 
					<li>
						<div>
							<img style="margin-top:30px;" class="advertise_fl" src="Images/MainpagePic/blueberrythumb.png"/>
							<div class="advertise_text fl">
								<h3 style="margin: 0px;">
								<span>hello! summer</span>
								</h3>
								<div>
								<div class="text">스타벅스의 두번째 여름이 찾아옵니다. </div>
								</div>
							</div>						
						</div>
					</li> 
				</ul>
			</div>
			
			<div class="bxslide_under" style="background-image:url(	http://ui.ssgcdn.com/cmpt/banner/202104/2021040917160954716299883629_876.jpg)">
				<div class='slideText'>
					<p class="sbux_heading_top">청량하게 즐기자!</p>
					<h2>Summer MD</h2>
					<div class="sbux_tag">#스타벅스 #텀블러 #머그</div>			
				</div>
			</div>
			
		
			<div class=sbux_item>
				<ul class="thmb_1st">
					<%
						ArrayList<MainpageSeasonVO> seasonList = null;
						seasonList = (ArrayList<MainpageSeasonVO>)request.getAttribute("seasonList");
						
						for(MainpageSeasonVO vo : seasonList){
					%>	
					<li class="tum1">
						<div class="prod">
							<div class="prod_top"></div>
						</div>
						<div class="thmb">
							<img src="Images/<%=vo.getProduct_category_name()%>/<%=vo.getProduct_name_eng()%>/1.png" product_number='<%=vo.getProduct_number()%>'/>
						</div>
						<div class="cunit_info">
							<img class="sb_mini_image" src="Images/Allshare/Title.png"/>													
							<div class="subtext"><%=vo.getProduct_name()%></div>		
							<div class="price"><strong><%=withCommas(vo.getPrice())%></strong><span class="sub_price">원</span></div>
							<div class='rating'>
								<%for(int i=1; i<=vo.getRating();i++){%><img class='Blackstars' src="Images/Allshare/BlackStar.png"/><%}%>
								<%if(vo.getRating()*10%10>=5){%><img class='Whitestars' src="Images/Allshare/WhiteStar.png"/><%}%>
							</div>
						</div>	
					</li>
					<%
						}
					%>	
				</ul>
			</div>
			
			<div class="sbux_heading">
				<h1>스타일 별 MD 상품 둘러보기</h1>
				<h2>마음에 드는 스벅템을 발견해 보세요</h2>
			</div>
		
			<div class=sbux_item>
				<ul class="thmb_1st">
				<%
					ArrayList<MainpageMDVO> MDlist = null;
					MDlist = (ArrayList<MainpageMDVO>)request.getAttribute("MDlist");
				
					for(MainpageMDVO vo : MDlist) {
				%>
					<li class="tum1">
						<div class="prod">
							<div class="prod_top"></div>
						</div>
						<div class="thmb">
							<img src="Images/<%=vo.getProduct_category_name()%>/<%=vo.getProduct_name_eng()%>/1.png" product_number='<%=vo.getProduct_number()%>'/>
						</div>
						<div class="cunit_info">
							<img class="sb_mini_image" src="Images/Allshare/Title.png"/>
							<div class="subtext"><%=vo.getProduct_name()%></div>
							<div class="price"><strong><%=withCommas(vo.getPrice())%></strong><span class="sub_price">원</span></div>
							<div class='rating'>
							<% for(int i=1; i<=vo.getRating(); i++) { %><img class='Blackstars' src="Images/Allshare/BlackStar.png"/><% } %>
							<% if(vo.getRating()*10%10>=5) { %><img class='Whitestars' src="Images/Allshare/WhiteStar.png"/><% } %>
							</div>
						</div>	
					</li>
					<%
						}
					%>
				</ul>	
			</div>
			
		
			<div class="sbux_heading">
				<h1>스타벅스 베스트</h1>
				<h2>스타벅스 인기상품을 만나보세요</h2>
			</div>
			
			<div class="sbux_best_item">
				<ul>	
					<%
						ArrayList<MainpageTopListVO> Toplist = null;
						Toplist = (ArrayList<MainpageTopListVO>)request.getAttribute("Toplist");
								
						for(MainpageTopListVO vo : Toplist){
							String styleTop="";
							
							if(vo.getRownum()>12) {
								styleTop = "display:none;";
							}
						%>						
					<li class="bestitem" style="<%=styleTop%>">
						<div class="best_number"><%=vo.getRownum() %></div>
						<div class="bestitem_div_image"><img src="Images/<%=vo.getImage_name()%>/<%=vo.getProduct_name_eng() %>/1.png" product_number='<%=vo.getProduct_number()%>'/></div>
						<div class="bestitem_div_p"><p><%=vo.getAttract_ment() %></p></div>
						<div><img class="sb_mini_image" src="Images/Allshare/Title.png" /></div>
						<div class="subtext"><%=vo.getProduct_name() %></div>
						<div class="price"><%=withCommas(vo.getPrice()) %><span class="bestitem_won">원</span></div>
						<div class='rating'>	
						<% for(int i=1; i<=vo.getRating(); i++) { %><img class='Blackstars' src="Images/Allshare/BlackStar.png"/><% } %>
						<% if(vo.getRating()*10%10>=5) { %><img class='Whitestars' src="Images/Allshare/WhiteStar.png"/><% } %>
						</div>
					</li>
					<%
						}
					%>
				</ul>
					
			</div>	
				<div class="button_productMore">	
					<input type="button" class="button_more" value="상품 더보기▽"/>
				</div>
		</div>
		
<%@ include file='footer.jsp'%>
</body>
</html>