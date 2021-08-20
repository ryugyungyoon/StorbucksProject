package com.admin.www;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MypageDropAction implements Action {
	
	public Connection getConnection(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch(Exception e){
		}return conn;
	}
	public boolean mypageDrop(Connection conn,String id) throws ServletException, IOException {
		boolean delete = false;
		
		try {
			String sql = "delete from member where id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			
			int result = pstmt.executeUpdate();
			
			if(result==1) {
				System.out.println("아이디 삭제 성공!");
				delete = true;
				return delete;
			}
		}catch (Exception e) {System.out.println("삭제오류"); return delete;}
		
		return delete;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn =null;
		conn =getConnection(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		if(mypageDrop(conn,member_id)){
			request.getRequestDispatcher("Controller?command=mypageDropResult").forward(request, response);
		}else {
			System.out.println("오류");
		}
	}

}
