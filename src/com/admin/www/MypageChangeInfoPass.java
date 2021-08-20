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

public class MypageChangeInfoPass implements Action {
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
	
		return conn;
	}
	
	public boolean updateInfo(Connection conn, String phone, String email, String address, String member_id){
		
		boolean pass = false;
		
		try {
			String sql = "update member set phone = ?, email=?, address=? where id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, phone);
			pstmt.setString(2, email);
			pstmt.setString(3, address);
			pstmt.setString(4, member_id);
			int result = pstmt.executeUpdate();

			if(result==1) {
				 pass = true;
				 return pass;
			}else {
				System.out.println("업데이트 실패");
				return pass;
			}
		
			
		} catch (SQLException e) {	e.printStackTrace();}
		
		return pass;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		System.out.println(member_id);
		
		String phone = request.getParameter("phoneselect");
		phone += request.getParameter("phone");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		address += " ";
		address += request.getParameter("addressDetail");
		
		
		if(updateInfo(conn, phone, email, address,member_id)) {
			RequestDispatcher rd = request.getRequestDispatcher("Controller?command=mypageChangeInfoResult");
			rd.forward(request, response);
		}else {
			System.out.println("오류");
		}
		
	}

}
