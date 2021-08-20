window.onload = function(){
	//메인헤더-----------------------------------------------
	
	//로고클릭시 메인으로
	$(".logo").click(function(){
		location.href="MainpageServlet";	
	});
	//로그아웃
	$(".btn_logout").click(function(){
		alert("로그아웃 되었습니다.");
		location.href='Controller?command=logout';
	});
	//검색창
	$(".searchPage").click(function(){
		var product_name = $(this).parent().find("input").val();
		
		if(product_name!=''){
			location.href="Controller?command=searchpage&product_name="+encodeURI(product_name);
		} else {alert('검색어를 입력하세요');}
	});
	//메인홈페이지-------------------------------------
	//상품들 클릭했을때 해당 제품 홈페이지로 이동
	$(".tum1>.thmb>img, li.bestitem>div.bestitem_div_image>img").click(function() {
		var product_number = $(this).attr("product_number");
		location.href = "Controller?command=eachProduct&product_number=" + product_number;
	});
	
	
	//productbycategory 페이지
	
	//카테고리 클릭시 해당 상품으로 이동
	$(".categoryEach").click(function(){
		 var product_number = $(this).attr("product_number");
         location.href = "Controller?command=eachProduct&product_number=" + product_number;
	});
	//작은검색창
	$(".srch_btn2").click(function() {
		var product_name = $(this).parent().find("input").val();
		if(product_name!=''){
			location.href="Controller?command=searchpage&product_name="+encodeURI(product_name);	
		}else alert('검색어를 입력하세요');
	});
	//eachproduct 페이지----------------------------
	
	//상품상세정보 클릭시
	$(".pyodiv1").click(function(){
	var offset = $('.thispoint1').offset();
	$("html").animate({scrollTop : offset.top}, 400);
	});
	//고객리뷰 클릭시
	$(".pyodiv2").click(function(){
	var offset = $('.thispoint2').offset();
	$('html').animate({scrollTop : offset.top}, 400);
	});
	//배송/반품/교환 안내 클릭시
	$(".pyodiv3").click(function(){
	var offset = $('.thispoint3').offset();
	$('html').animate({scrollTop : offset.top}, 400);
	});
	
	//마우스누르는것으로 제품사진 병경
	$(".roundleftbottom>img").mouseenter(function() {
		var src = $(this).attr("src");
		$(".roundleft>img").attr("src", src);
	});

	//다른상품눌렀을때 이동
	$(".last1").click(function(){
		 var product_number = $(this).attr("product_number");
         location.href = "Controller?command=eachProduct&product_number=" + product_number;
	});
	
	//상품 더보기 눌렀을떄
	$(".togethermore").click(function() {
		var product_number = $(".roundleftHead").attr("product_number");
		location.href="Controller?command=eachproductChangeIntoProductcategory&product_number="+product_number;
	});
	//마이페이지---------------------------------------------
	$(".openandclose").click(function() {
		if("block" == $(this).children("ul.myPageMainDetail").css("display")){
			$(this).children("ul.myPageMainDetail").css("display","none");
		}else{
			$(this).children("ul.myPageMainDetail").css("display","block");
		}
	});
	//메뉴보기 눌렀을때
	$(".menu").click(function() {
		if("none" == $(this).parents().children("div .mypageArea").css("display")){
			$(this).parents().children("div .mypageArea").css("display","block");
		}else {
			$(this).parents().children("div .mypageArea").css("display","none");
		}
	});
	
	//좋아요 눌럿을때
	$(".list4").click(function(){
		 location.href = "Controller?command=mypageLike";			
	});
	
};





