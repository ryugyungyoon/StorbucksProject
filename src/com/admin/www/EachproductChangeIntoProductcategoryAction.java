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

public class EachproductChangeIntoProductcategoryAction implements Action {

	public Connection connect(Connection conn) {
		try{
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
			System.out.println("연동성공");
		}catch(Exception e){ System.out.println("연동실패");}
		
		return conn;
	}
	
	public int getCategoryNumber(Connection conn,int product_number) {
		
		try {
			String sql = "select category from product where product_number = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_number);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			
			return rs.getInt(1);
		}catch (Exception e) {}
		
		return 0;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int product_number = Integer.parseInt(request.getParameter("product_number"));
		Connection conn = null;
		conn = connect(conn);
		
		int categoryNumber = getCategoryNumber(conn,product_number);
		
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=productcategory&categoryNumber="+categoryNumber);
		rd.forward(request, response);
		
		
		
		
	}

}
