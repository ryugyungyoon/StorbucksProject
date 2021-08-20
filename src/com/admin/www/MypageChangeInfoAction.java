package com.admin.www;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import MypageMemberInfoVO.MemberInfoVO;

public class MypageChangeInfoAction implements Action {
	
	public Connection connect(Connection conn) {
		try{
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
			}catch(Exception e){}
			
			return conn;
			}

	public MemberInfoVO getlistinfo(Connection conn, MemberInfoVO member_infovo,String member_id){
		try {
			String sql = "select * from member where id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			rs.next(); 
			String id = rs.getString("id");
			String name = rs.getString("name");
			
			member_infovo = new MemberInfoVO(id,name);
			
			pstmt.close();
			rs.close();
		}catch (Exception e) {System.out.println("sql문 오류");}
		
		return member_infovo;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		MemberInfoVO member_infovo = null;
		member_infovo =  getlistinfo(conn,member_infovo,member_id);
		
		RequestDispatcher rd = request.getRequestDispatcher("mypageChangeInfo.jsp");
		request.setAttribute("member_infovo", member_infovo);
		rd.forward(request, response);
	}

}
