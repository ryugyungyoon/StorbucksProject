package com.admin.www;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ModifyReviewAction implements Action {

	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
			return conn;
		}catch (Exception e) {System.out.println("연동오류");}
			return conn;
	}
	
	
	public boolean ModifyReview(Connection conn, String title, String content, int rating, String member_id , int product_number ,int order_number) {
		boolean modify = false;
		
		System.out.println(title);
		System.out.println(content);
		System.out.println(member_id);
		System.out.println(product_number);
		System.out.println(order_number);
		
		
		try {
			String sql ="update review set title = ? , content= ?, rating = ?  where writer_id = ? and product_number = ? and rno = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, rating);
			pstmt.setString(4, member_id);
			pstmt.setInt(5, product_number);
			pstmt.setInt(6, order_number);
			int result = pstmt.executeUpdate();
			if(result==1) {
				modify = true;
				return modify;
			}
		}catch (Exception e) { e.printStackTrace();}
			return modify;
	}
	
	public boolean updateReview(Connection conn, int product_number) {
	      boolean up = false;
	      
	      float avg = 0;
	      String num = null;
	      try {
	         String sql = "select avg(rating) from review where product_number = ?";
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, product_number);
	         ResultSet rs = pstmt.executeQuery();
	         
	         rs.next();
	         avg = rs.getFloat(1);
	         System.out.println(avg);
	         num = String.format("%.1f", avg);
	         System.out.println(num);
	         pstmt.close();
	      } catch (Exception e) {System.out.println("업데이트 실패");}
	      
	      try {
	         String sql = "update product set rating=? where product_number=?";
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, num);
	         pstmt.setInt(2, product_number);
	         
	         int result = pstmt.executeUpdate();
	         if(result==1) {
	            up = true;
	            pstmt.close();
	            return up;
	         }
	      }catch (Exception e) {System.out.println("업데이트 실패");}
	      return up;
	   }
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		int product_number = Integer.parseInt(request.getParameter("product_number"));
		int order_number = Integer.parseInt(request.getParameter("order_number"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int rating = Integer.parseInt(request.getParameter("rating"));
		
		if(ModifyReview(conn,title,content,rating,member_id,product_number,order_number)) {
			if(updateReview(conn, product_number)) {
				request.getRequestDispatcher("MainpageServlet").forward(request, response);
			}
		}
		
	}
}
