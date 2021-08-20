package com.admin.www;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

@WebServlet("/CouponDuplicate")
public class CouponDuplicate extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
			return conn;
		}catch (Exception e) {e.printStackTrace();}
		
		return conn;
	}
	
	public boolean checkCoupon(Connection conn, String member_id, String[] arr) {
		boolean success = false;
		
		for(int i=0; i<=arr.length-1; i++) {
			try {
				String sql = "select count(*) from coupon where member_id =? and c_number = ?";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, member_id);
				pstmt.setString(2, arr[i]);
				ResultSet rs = pstmt.executeQuery();
				rs.next();
				if(rs.getInt(1)==0) {
					success = true;
				}else {
					success = false;
					return success;
				}
			}catch (Exception e) {e.printStackTrace();}
		}
		return success;
	}
	public boolean insertCoupon(Connection conn, String member_id, String[] arr) {
		boolean success = false;
		
		for(int i=0; i<=arr.length-1; i++) {
			try {
				String sql = "insert into coupon (member_id,c_number) values (?,?)";
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, member_id);
				pstmt.setString(2, arr[i]);
				
				int result = pstmt.executeUpdate();
				if(result==1) {
					success = true;
				}else {
					success = false;
					return success;
				}
			}catch (Exception e) {e.printStackTrace();}
		}
		return success;
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		Connection conn = null;
		conn = connect(conn);
		
		String coupon_list = request.getParameter("coupon_list");
		
		coupon_list = coupon_list.replace("[", "");
		coupon_list = coupon_list.replace("]", "");
		coupon_list = coupon_list.replace("\"", "");
	
		String[] arr = coupon_list.split(",");
		System.out.println(Arrays.toString(arr));
		
		int retNumber = -1;
		
		if(checkCoupon(conn,member_id,arr)) {
			
			if(insertCoupon(conn,member_id,arr)) {
				retNumber = 0;
			}else {retNumber=1;}
		
		}else {retNumber = 1;}
		
		System.out.println(retNumber);
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();		
		obj.put("retNumber", retNumber);
		out.print(obj);
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
