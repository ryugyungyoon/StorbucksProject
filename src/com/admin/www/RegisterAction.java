package com.admin.www;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegisterAction implements Action {
	
	public Connection connect(Connection conn){
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
		return conn;
	}
	
	public boolean register(Connection conn,String id,String pw,String name,String address,String phone,String email) {
		boolean register = false;
		
		try {
			String sql = "insert into member (id,pw,name,address,phone,email) values (?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2,pw);
			pstmt.setString(3,name);
			pstmt.setString(4,address);
			pstmt.setString(5,phone);
			pstmt.setString(6,email);
			
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				register = true;
				return register;
			}
			return register;
		}catch (Exception e) {System.out.println("회원가입 오류");}
		
		return register;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String address = request.getParameter("address");
		address += " ";
		address += request.getParameter("addressDetail");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		
		if(register(conn,id,pw,name,address,phone,email)) {
			HttpSession session = request.getSession();
			session.setAttribute("login_id", id);
			
			RequestDispatcher rd = request.getRequestDispatcher("Controller?command=registerResult");
			rd.forward(request, response);
		}else {
			System.out.println("오류");
		}
		
		
		
	}
}
