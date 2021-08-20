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

@WebServlet("/checkReview")
public class checkReview extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
			return conn;
		}catch (Exception e) {System.out.println("연동실패");}
		return conn;
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
	
	
	
	//////////////////////
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		int product_number = Integer.parseInt(request.getParameter("product_number"));
		int order_number = Integer.parseInt(request.getParameter("order_number"));

		int retNumber = -1;
		
		
		
		if(checkDraft(conn,member_id,product_number,order_number)==1) {
			retNumber = 1;
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
