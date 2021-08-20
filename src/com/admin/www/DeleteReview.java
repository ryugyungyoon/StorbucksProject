package com.admin.www;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

@WebServlet("/DeleteReview")
public class DeleteReview extends HttpServlet {
	
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
		return conn;
	}
	
	public boolean removeReview(Connection conn, String member_id, int product_number, int order_number) {
		boolean success = false;
		
		try {
			String sql = "delete from review where writer_id = ? and product_number =? and rno = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, product_number);
			pstmt.setInt(3, order_number);
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				success = true;
				return success;
			}
		}catch (Exception e) {}
			return success;
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
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		int retNumber = -1;
		
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		int product_number = Integer.parseInt(request.getParameter("product_number"));
		int order_number = Integer.parseInt(request.getParameter("order_number"));
		
		if(removeReview(conn,member_id,product_number,order_number)) {
			if(updateReview(conn, product_number)) {
				retNumber = 1;
			}
		}else retNumber = 0;
		
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();		
		obj.put("retNumber", retNumber);
		out.print(obj);
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
}
