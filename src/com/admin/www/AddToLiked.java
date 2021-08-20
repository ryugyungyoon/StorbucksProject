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

@WebServlet("/AddToLiked")
public class AddToLiked extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
		return conn;
	}
	
	public boolean addLiked(Connection conn, String product_number, String id) {
		
		boolean add = false;
		
		try {
			String sql = "insert into LIKED values (?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_number);
			pstmt.setString(2, id);
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("들어오냐?");
				add = true;
				return add;
			}
			
		}catch (Exception e) {System.out.println("좋아요 저장안됨");}
		
		return add;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)(session.getAttribute("login_id"));
		String product_number = request.getParameter("product_number");
		
		System.out.println(id);
		System.out.println(product_number);
		
		int retNumber = -1;
		
		Connection conn = null;
		conn = connect(conn);
		
		if(addLiked(conn,product_number,id)) {
			retNumber = 1;
		}else {retNumber=0;}
		
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();		
		obj.put("retNumber", retNumber);
		out.print(obj);
		
	}
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
