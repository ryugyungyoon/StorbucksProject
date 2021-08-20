package com.admin.www;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import EachproductVO.EachproductVO;
import EachproductVO.EachprojectReviewVO;

public class EachProductAction implements Action {
	
	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url, Connect.id, Connect.pw);
		} catch (Exception e){ }
		
		return conn;
	}

	public EachproductVO eachProduct(Connection conn, int product_number){
		try {
			String sql = "SELECT * FROM product WHERE product_number = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,product_number);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				String category_name_eng = productNumberToCategoryName(conn, rs.getInt("category"));
				String product_name = rs.getString("product_name");
				String image_name = rs.getString("image_name");
				String product_name_eng = rs.getString("product_name_eng");
				String info_title = rs.getString("INFO_TITLE");
				String info_content = rs.getString("INFO_CONTENT");
				int price = rs.getInt("price");
				float rating = rs.getFloat("rating");
				
				return new EachproductVO(product_number,category_name_eng, product_name,image_name,product_name_eng,info_title,info_content,price,rating);
			}
		}catch (Exception e) {e.printStackTrace();}
		return null;
	}
	
	public ArrayList<EachproductVO> similerProduct(Connection conn, int product_category, ArrayList<EachproductVO> list) {
		try {
			String sql ="select pc.name_eng,pc.name,p.* from (select * from product where category in (select category from product where product_number = ?))p , product_category pc where pc.category = p.category";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,product_category);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				int product_number = rs.getInt("product_number");
				String category_name_eng = rs.getString("name_eng");  
				String product_name = rs.getString("product_name");
				String image_name = rs.getString("image_name");
				String product_name_eng = rs.getString("product_name_eng");
				String info_title = rs.getString("INFO_TITLE");
				String info_content = rs.getString("INFO_CONTENT");
				int price = rs.getInt("price");
				float rating = rs.getFloat("rating");	
				
				list.add(new EachproductVO(product_number,category_name_eng, product_name,image_name,product_name_eng,info_title,info_content,price,rating));
			}
			return list;
		}catch (Exception e) {e.printStackTrace();}
		return null;
	}
	
	
	public int[] similarProductNumber(Connection conn, int number,int[] repeat){
		int random = 0;
		try {
			String sql = "select count(*) from product where category in (select category from product where product_number = ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			random = rs.getInt(1);
			
		}catch (Exception e) {}
		
		
		for(int i=0; i<=3; i++) {
			repeat[i] = (int)((Math.random()*random)+1);
			for(int j=0; j<i; j++) {
				if(repeat[i]==repeat[j]) {
					i--;
					break;
				}
			}
		}
		return repeat;
	}
	
	public String productNumberToCategoryName(Connection conn, int categoryNumber) {
		try {
			String sql = "SELECT name_eng FROM product_category WHERE category=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryNumber);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {e.printStackTrace();}
		return null;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		
		int product_number = Integer.parseInt(request.getParameter("product_number"));
		
		System.out.println(product_number);
		
		EachproductVO vo = null;
		vo = eachProduct(conn, product_number);
		
		ArrayList<EachproductVO> list = new ArrayList<EachproductVO>();
		list = similerProduct(conn, product_number, list);
		
		int[] repeat = new int[4];
		repeat = similarProductNumber(conn,product_number,repeat);
		
		//현재날짜 구하기
		SimpleDateFormat sdf= new SimpleDateFormat("MM/dd (E)");
		Calendar cal = Calendar.getInstance();
		cal.add(cal.DATE, 3);
		String date = sdf.format(cal.getTime());
		
		
		
		
		
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=eachProductResult");
		request.setAttribute("vo", vo);
		request.setAttribute("list", list);
		request.setAttribute("repeat", repeat);
		request.setAttribute("date", date);
		//---------------
		rd.forward(request, response);
	}
}
