package com.admin.www;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MypageChangePWAction implements Action {
	
	public Connection connect(Connection conn){
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
		return conn;
	}
	
	public boolean getPw (Connection conn,String member_id , String pw){
		boolean getPw = false;
		
		try {
			String sql = "update member set pw = ? where id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setString(2, member_id);
			int result = pstmt.executeUpdate();

			if(result == 1) {
				getPw = true;
				return getPw;
			}else {return getPw;}
		} catch (SQLException e) {e.printStackTrace();}
		return getPw;
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		String pw = request.getParameter("pw");
		
		
		if(getPw(conn, member_id,pw)) {
			RequestDispatcher rd = request.getRequestDispatcher("Controller?command=mypageChangePWResult");
			rd.forward(request, response);
		}else {
			request.getRequestDispatcher("mypageChangePW.jsp").forward(request, response);
		}
		
		
		
	}
}
