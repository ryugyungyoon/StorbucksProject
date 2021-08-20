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

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
					
		}catch (Exception e) {System.out.println("오류");}
		return conn;
	}
	
	public boolean checkId(Connection conn, String id , String pw) {
		boolean check = false;
		
		try {
			String sql = "select pw from member where id = ? ";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString("pw").equals(pw)) {
					check = true;
					return check;
				}
				return check;
			}
			return check;
			
		}catch (Exception e) {System.out.println("디비에서 로그인 확인 실패");}

		return check;
	}
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		int retNumber = -1;
		
		Connection conn = null;
		conn = connect(conn);
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();

		
		if(checkId(conn,id,pw)) {
			retNumber = 1;
			HttpSession session = request.getSession();
			session.setAttribute("login_id", id);
		}else retNumber = 0;
		
		obj.put("login_check", retNumber);		
		out.print(obj);
	}

	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
