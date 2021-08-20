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
import java.net.URLDecoder;

import SearchPageVO.SearchPageVO;

public class SearchPageAction implements Action {

	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
		
		return conn;
	}
	
	public ArrayList<SearchPageVO> search(HttpServletRequest request,HttpServletResponse response,Connection conn, String search_product_name, ArrayList<SearchPageVO> searchList) throws ServletException, IOException{
		try {
			
			String sql = "select pc.name_eng,p.* from (select * from product where product_name like ?)p , product_category pc where pc.category = p.category";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+search_product_name+"%");
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String category_name_eng = rs.getString("NAME_ENG");
				String product_name = rs.getString("PRODUCT_NAME");
				String product_name_eng = rs.getString("product_name_eng");
				int product_number = rs.getInt("product_number");
				int price = rs.getInt("price");
				float rating = rs.getFloat("rating");
				
				if(searchList == null) searchList = new ArrayList<SearchPageVO>();
				searchList.add(new SearchPageVO(category_name_eng,product_name,product_name_eng,product_number,price,rating));
			}
			rs.close();
			pstmt.close();
			return searchList;
			
		}catch (Exception e){
			e.printStackTrace();
		}
		return searchList;
	}
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		
		String search_product_name = URLDecoder.decode(request.getParameter("product_name"), "UTF-8");
		
		Connection conn = null;
		conn = connect(conn);
		
		ArrayList<SearchPageVO> searchList = null;
		
		searchList = search(request,response,conn,search_product_name,searchList);
		
		System.out.println(search_product_name);
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=searchpageResult");
		request.setAttribute("searchList", searchList);
		rd.forward(request, response);
	
	}
}
