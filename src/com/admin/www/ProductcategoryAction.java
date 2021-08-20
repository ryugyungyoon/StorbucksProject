package com.admin.www;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ProductbyCategoryVO.ProductCategoryVO;

public class ProductcategoryAction implements Action {

	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
	
		return conn;
	}
	
	
	
	public ArrayList<ProductCategoryVO> getProductInfo(Connection conn, ArrayList<ProductCategoryVO> productList, int categoryNumber){
		
		try {
			String sql ="select pc.name,pc.name_eng,p.* from product p ,product_category pc where pc.category = ? and pc.category = p.category";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryNumber);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String category_name = rs.getString("NAME");
				String category_name_eng = rs.getString("NAME_ENG");
				String product_name = rs.getString("product_name");
				String product_name_eng = rs.getString("product_name_eng");
				int product_number = rs.getInt("product_number");
				int price = rs.getInt("price");
				float rating = rs.getFloat("rating");
				
				
				productList.add(new ProductCategoryVO(category_name,category_name_eng,product_name,product_name_eng,product_number,price,rating));
			}
			rs.close();
			pstmt.close();
			return productList;
		}catch (Exception e) {}
			return productList;
	}
	
	
	public int countCategory(Connection conn, int categoryNumber) {
		int number;
		
		try {
			String sql = "select count(*) from product where category = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryNumber);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			number =  rs.getInt(1);
			rs.close();
			pstmt.close();
			
			return number;
		}catch (Exception e) {}
			return 0;
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		ArrayList<ProductCategoryVO> productList = new ArrayList<>();
		int categoryNumber = Integer.parseInt(request.getParameter("categoryNumber"));
		
		int number = 0;
		
		productList = getProductInfo(conn,productList,categoryNumber);
		
		number = countCategory(conn,categoryNumber);
		
		
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=ProductcategoryResult");
		request.setAttribute("productList", productList);
		request.setAttribute("number", number);
		rd.forward(request, response);
	}

}
