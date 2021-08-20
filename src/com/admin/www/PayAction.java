package com.admin.www;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import PayVO.CouponVO;
import PayVO.MemberVO;
import PayVO.ProductVO;

public class PayAction implements Action {
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url, Connect.id, Connect.pw);
		} catch (Exception e){ }
		
		return conn;
	}

	public MemberVO getMember(Connection conn, MemberVO memberInfo,String id){
		
		try {
			String sql = "select name,phone,email,address from member where id=?";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, 	id);
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			String name = rs.getString("name");
			String phone = rs.getString("phone");
			String email = rs.getString("email");
			String address = rs.getString("address");
			memberInfo = new MemberVO(name,phone,email,address);
			
			return memberInfo;
		}catch (Exception e) {System.out.println("오류");}
		
		return memberInfo;
	}
	
	
	public ArrayList<ProductVO> getProduct(Connection conn, int product_number, int amount,ArrayList<ProductVO> productList){
		
		try {
			String sql = "select * from product p ,product_category pc where p.category = pc.category and product_number = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_number);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
					String category_name_eng= rs.getString("name_eng");
					String product_name_eng = rs.getString("product_name_eng");
					String product_name = rs.getString("product_name");
					//product_number
					int eachprice = rs.getInt("price");
					//amount
					int eachproductprice = eachprice*amount;
					float rating = rs.getFloat("rating");
					
				productList.add(new ProductVO(category_name_eng,product_name_eng,product_name,product_number,eachprice,amount,eachproductprice,rating));
				return productList;
			}
			return productList;
		}catch (Exception e) {}
		return productList;
	}

	public ArrayList<CouponVO> getCouponListFromMember(Connection conn,ArrayList<CouponVO> couponList, String id) {	
		
		try{
			String sql ="select ct.name, c.* from (select * from coupon where member_id=?)c, coupon_type ct where c.c_number = ct.c_number";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String member_id = rs.getString("MEMBER_ID");
				String coupon_name = rs.getString("name");
				int coupon_number = rs.getInt("c_number");
				
				couponList.add(new CouponVO(member_id,coupon_name,coupon_number));
			}
			
			
		}catch (Exception e) {System.out.println("오류");}
		
		return couponList;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int product_number = Integer.parseInt(request.getParameter("product_number")); //상품 번호가져옴
		int amount = Integer.parseInt(request.getParameter("amount")); //수량가져옴

		Connection conn = null;
		conn = connect(conn);
		
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		
		// 멤버 정보들 담았음 --------------
		MemberVO userInfo = new MemberVO();
		userInfo = getMember(conn,userInfo,member_id);
		// 제품 정보 담았음 --------------------
		ArrayList<ProductVO> productList = new ArrayList<>();
		productList = getProduct(conn,product_number,amount,productList);
		// 쿠폰정보 담았음 ---------------------
		ArrayList<CouponVO> couponList = new ArrayList<>();
		couponList = getCouponListFromMember(conn,couponList,member_id);
		//-----------------------------------------------
		System.out.println("여기까지 성공적으로 완료");
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=payResult");
		request.setAttribute("userInfo",userInfo);
		request.setAttribute("productList", productList);
		request.setAttribute("couponList", couponList);
		
		rd.forward(request, response);
	}
}
