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

public class WriteReviewAction implements Action {
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);		
			return conn;
		}catch (Exception e) {}
		return conn;
	}

	public boolean setReview(Connection conn, int order_number,String member_id, String title, String content, int rating, int product_number) {
		boolean set = false;
		
		try {
			String sql = "insert into review (rno,writer_id,title,content,rating,product_number) values (?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_number);
			pstmt.setString(2, member_id);
			pstmt.setString(3, title);
			pstmt.setString(4, content);
			pstmt.setInt(5, rating);
			pstmt.setInt(6, product_number);
			
			int result = pstmt.executeUpdate();
			if(result==1) {
				set = true;
				return set;
			}
		}catch (Exception e) {System.out.println("디비 등록 실패");}
		return set;
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
		HttpSession session = request.getSession();
		
		int order_number = Integer.parseInt(request.getParameter("order_number"));
		String member_id = (String)(session.getAttribute("login_id"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int rating = Integer.parseInt(request.getParameter("rating"));
		int product_number = Integer.parseInt(request.getParameter("product_number"));
		
		Connection conn = null;
		conn = connect(conn);
		
		if(setReview(conn,order_number,member_id,title,content,rating,product_number)) {
	         
			if(updateReview(conn, product_number)) {request.getRequestDispatcher("Controller?command=writeReviewResult").forward(request, response);}
	     
		}else {System.out.println("무언가 오류");}
		
		
		
	}
}
