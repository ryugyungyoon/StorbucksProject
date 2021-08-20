package com.admin.www;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

@WebServlet("/DeleteLike")
public class DeleteLike extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
			return conn;
		}catch (Exception e) {e.printStackTrace();}
		return conn;
	}
	
	public boolean deleteLiked(Connection conn, String member_id, int product_number) {
		boolean delete = false;
		
		try {
			String sql ="delete from liked where member_id = ? and product_number = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, product_number);
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				delete = true;
				return delete;
			}
		}catch (Exception e) {e.printStackTrace();}
		return delete;
	}
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		int product_number = Integer.parseInt(request.getParameter("product_number"));
		
		int retNumber = -1;
		
		if(deleteLiked(conn,member_id,product_number)){
			retNumber=1;
		}else retNumber=0;
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();		
		obj.put("retNumber", retNumber);
		out.print(obj);
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
