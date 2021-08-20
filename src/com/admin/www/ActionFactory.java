package com.admin.www;

public class ActionFactory {
	private static final ActionFactory instance = new ActionFactory();
	private ActionFactory(){}
	static ActionFactory getInstance() {
		return instance;
	}
	
	
	Action getAction(String command) {
		Action action = null;
		
		switch (command) {
			//네이버로그인
			case "naver_login" :
				action = new Naver_loginAction();
				break;
			//-------------
			case "mainpage":
				action = new MainpageAction();
				break;
			case "mainpageResult":
				action = new MainpageResult();
				break;
			case "logout" :
				action = new LogoutAction();
				break;
			case "searchpage" :
				action = new SearchPageAction();
				break;
			case "searchpageResult" :
				action = new SearchpageResult();
				break;
			case "register" :
				action = new RegisterAction();
				break;
			case "registerResult" :
				action = new RegisterResult();
				break;
			case "eachProduct" :
				action = new EachProductAction();
				break;
			case "eachProductResult" :
				action = new EachProductResult();
				break;
			case "eachproductChangeIntoProductcategory" :
				action = new EachproductChangeIntoProductcategoryAction();
				break;
			case "productcategory" :
				action = new ProductcategoryAction();
				break;
			case "ProductcategoryResult" :
				action = new ProductcategoryResult();
				break;
			case "mypageMain" :
				action = new MypageMainAction();
				break;
			case "mypageMainResult" :
				action = new MypageMainResult();
				break;
			case "mypageDrop" : 
				action = new MypageDropAction();
				break;
			case "mypageDropResult" :
				action = new MypageDropResult();
				break;
			case "mypageLike" :
				action = new MypageLikedAction();
				break;
			case "mypageLikedResult" :
				action = new MypageLikedResult();
				break;
			case "mypageChangeInfo" :
				action = new MypageChangeInfoAction();
				break;
			case "mypageChangeInfoPass" :
				action = new MypageChangeInfoPass();
				break;
			case "mypageChangeInfoResult" :
				action = new MypageChangeInfoResult();
				break;
			case "mypageChangePW" :
				action = new MypageChangePWAction();
				break;
			case "mypageChangePWResult" :
				action = new MypageChangePWResult();
				break;
			case "mypageOrderList" :
				action = new MypageOrderListAction();
				break;
			case "mypageOrderListResult" :
				action = new MypageOrderListResult();
				break;
			case "pay" :
				action = new PayAction(); 
				break;
			case "payResult" :
				action = new PayResult();
				break;
			case "insertintoOrderList" :
				action = new InsertintoOrderListAction();
				break;
			case "writeReview" :
				action = new WriteReviewAction();
				break;
			case "writeReviewResult" :
				action = new WriteReviewResult();
				break;
			case "modifyReview" :
				action = new ModifyReviewAction();
				break;
				//이거는왜 리절트없음
		}
		
		return action;
	}
	
	
	
	
	
	
}
