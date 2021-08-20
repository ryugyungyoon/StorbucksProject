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

@WebServlet("/AddToWishList")
public class AddToWishList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
			return conn;
	}
	
	public boolean addToWishList(Connection conn, int product_number,String member_id,int amount) {
		boolean add = false;
		try {
			System.out.println(product_number);
			System.out.println(member_id);
			System.out.println(amount);
			
			String sql = "insert into wishlist values (?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_number);
			pstmt.setString(2, member_id);
			pstmt.setInt(3, amount);
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("위시리스트에 성공적으로 저장완료");
				add = true;
				return add;
			}
		}catch (Exception e) {System.out.println("위시리스트에 저장못함");}
		return add;
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
	
		int retNumber = -1;
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		int product_number = Integer.parseInt(request.getParameter("product_number"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		
		if(addToWishList(conn,product_number,member_id,amount)) {
			retNumber = 1;
		}else {retNumber = 0;}
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();		
		obj.put("retNumber", retNumber);
		out.print(obj);
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
