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

import ReviewVO.ReviewVO;

@WebServlet("/showReview")
public class showReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
			return conn;
		}catch (Exception e) {}
		return conn;
	}
	
	public ReviewVO getReview(Connection conn, ReviewVO rv,String member_id, int product_number, int order_number) {
		try {
			String sql = "select * from review where writer_id = ? and product_number = ? and rno = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, product_number);
			pstmt.setInt(3, order_number);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			String title = rs.getString("title");
			String content = rs.getString("content");
			int rating = rs.getInt("rating");
			int productNumber = rs.getInt("product_number");
			int orderNumber = rs.getInt("rno"); //순서 헷갈림 주의
			
			rv = new ReviewVO(title,content,rating,orderNumber,productNumber);
			rs.close();
			pstmt.close();
			return rv;
		}catch (Exception e) {}
		return rv;
	}
	
	
	public int checkDraft(Connection conn, String member_id , int product_number, int order_number) {
		int number = 0;
		try {
			String sql = "select count(*) from review where writer_id = ? and product_number = ? and rno = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, product_number);
			pstmt.setInt(3, order_number);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			number = rs.getInt(1);
			
			rs.close();
			pstmt.close();
			
			return number;
		}catch (Exception e) {System.out.println("디비 오류");}
			return number;
	}
	
	
	
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		Connection conn = null;
		conn = connect(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		int product_number = Integer.parseInt(request.getParameter("product_number"));
		int order_number = Integer.parseInt(request.getParameter("order_number"));
		
		
		ReviewVO rv = null;
		rv = getReview(conn,rv,member_id,product_number,order_number);
		
		int retNumber = -1;
		retNumber = checkDraft(conn,member_id, product_number,order_number);
		
		
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		
		
		if(retNumber==0) {
			obj.put("retNumber", retNumber);		
		}else{
			obj.put("retNumber", retNumber);		
			obj.put("title", rv.getTitle());		
			obj.put("content", rv.getContent());		
			obj.put("rating", rv.getRating());		
		}
		
		out.print(obj);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
