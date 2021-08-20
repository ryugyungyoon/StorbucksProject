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

import org.json.simple.JSONObject;

@WebServlet("/RegisterIdcheck")
public class RegisterIdcheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public Connection Connect(Connection conn) {
		
		try {	
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
		
		return conn;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = Connect(conn);
		
		String id = request.getParameter("id");
		int retNumber;
		int overlap = -1;
		
		try {
			String sql = "select count(*) from member where id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			overlap = rs.getInt(1);
		}catch (Exception e) {}
		
		if(overlap==0) retNumber = 0;
		else retNumber = 1;
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();		
		obj.put("login_check", retNumber);
		out.print(obj);
	}


}
