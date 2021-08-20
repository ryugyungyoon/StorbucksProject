package com.admin.www;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class InsertintoOrderListAction implements Action {

	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {System.out.println("연결오류");}
		return conn;
	}
	
	public String getAddress(Connection conn, String member_id) {
		try {
			String sql = "select address from member where id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			return rs.getString(1);
		}catch (Exception e) {System.out.println("주소 못가져옴");}
		return "null";
	}
	
	public boolean addToOrderList(Connection conn, String member_id, String product_number_amount,String order_address,int used_c_number, int cost, String requirements) {
		boolean DBresult = false;
		
		try {
			String sql = "insert into order_table (member_id,product_number_amount, order_address, used_c_number, cost, requirements,order_number) values (?,?,?,?,?,?,order_seq.nextval)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setString(2, product_number_amount);
			pstmt.setString(3, order_address);
			pstmt.setInt(4, used_c_number);
			pstmt.setInt(5, cost);
			pstmt.setString(6,requirements);
			
			int result = pstmt.executeUpdate();
			
			if(result==1) {
				DBresult = true;
				return DBresult;
			}
		}catch (Exception e) { e.printStackTrace(); System.out.println("오더리스트에 삽입 실패!");}
		return DBresult;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	int product_number = Integer.parseInt(request.getParameter("product_number"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	int used_c_number = Integer.parseInt(request.getParameter("used_c_number"));
	System.out.println(used_c_number);
	int cost = Integer.parseInt(request.getParameter("cost"));
	String requirements = URLDecoder.decode(request.getParameter("requirements"), "UTF-8");
	
	HttpSession session = request.getSession();
	String member_id = (String)(session.getAttribute("login_id"));
	String address = "";
	String product_number_amount = "";
	
	product_number_amount += product_number;
	product_number_amount += "_";
	product_number_amount += amount;
	
	Connection conn = null;
	conn = connect(conn);
	
	address = getAddress(conn,member_id);
	

	if(addToOrderList(conn,member_id,product_number_amount,address,used_c_number,cost,requirements)) {
		request.getRequestDispatcher("MainpageServlet").forward(request, response);;
	}
	
	
	
	
	
	}
}
