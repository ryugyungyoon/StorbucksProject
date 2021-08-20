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

public class MypageMainAction implements Action {

	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {System.out.println("오류");}
		return conn;
	}
	
	public int getCouponAmount(Connection conn,String member_id) {
		try {
			String sql = "select count(*) from coupon where member_id = ? ";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch (Exception e) {}
		return 0;
	}
	private int getLikedAmount(Connection conn, String member_id) {
		try {
			String sql = "select count(*) from liked where member_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch (Exception e) {}
		return 0;
	}
	private int getReviewAmount(Connection conn, String member_id) {
		try {
			String sql = "select count(*) from review where writer_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch (Exception e) {}
		return 0;
	}
	private int getOrderListAmount(Connection conn, String member_id) {
		try {
			String sql = "select count(*) from order_table where member_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch (Exception e) {}
		return 0;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		int couponAmount = getCouponAmount(conn,member_id);
		int likedAmount = getLikedAmount(conn,member_id);
		int reviewAmount = getReviewAmount(conn, member_id);
		int orderListAmount =getOrderListAmount(conn, member_id);
		
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=mypageMainResult");
		request.setAttribute("couponAmount", couponAmount);
		request.setAttribute("likedAmount", likedAmount);
		request.setAttribute("reviewAmount", reviewAmount);
		request.setAttribute("orderListAmount", orderListAmount);
		rd.forward(request, response);
	}
}
