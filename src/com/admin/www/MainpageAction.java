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

import MainpageVO.MainpageMDVO;
import MainpageVO.MainpageSeasonVO;
import MainpageVO.MainpageTopListVO;


public class MainpageAction implements Action {

	public ArrayList<MainpageSeasonVO> getSeason(Connection conn, ArrayList<MainpageSeasonVO> seasonList) throws Exception{
		String sql="select pc.name_eng,p.* from season s, product p, product_category pc where s.product_number = p.product_number and pc.category = p.category";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()){
			String product_category_name = rs.getString("NAME_ENG");
			String product_name_eng = rs.getString("product_name_eng"); 
			String product_name = rs.getString("PRODUCT_NAME");
			int price = rs.getInt("PRICE");		
			float rating = rs.getFloat("RATING");
			int product_number = rs.getInt("PRODUCT_NUMBER");
			
			seasonList.add(new MainpageSeasonVO(product_category_name,product_name_eng,product_name ,price,rating,product_number));
		}
		System.out.println("시즌제품 연동성공");
		pstmt.close();
		rs.close();
		return seasonList;
		
	}
	
	public ArrayList<MainpageMDVO> getMDpick(Connection conn, ArrayList<MainpageMDVO> MDlist) throws Exception{
		String sql = "select pc.name_eng,p.* from md m, product p,product_category pc where m.product_number = p.product_number and p.category = pc.category";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()){
			String product_category_name = rs.getString("NAME_ENG");
			String product_name_eng = rs.getString("product_name_eng"); 
			String product_name = rs.getString("PRODUCT_NAME");
			int price = rs.getInt("PRICE");		
			float rating = rs.getFloat("RATING");
			int product_number= rs.getInt("product_number");
	
			MDlist.add(new MainpageMDVO(product_category_name,product_name_eng,product_name ,price,rating,product_number));
		}
		System.out.println("MD픽 연동성공");
		pstmt.close();
		rs.close();
		
		return MDlist;
	}
	
	public ArrayList<MainpageTopListVO> getToplist(Connection conn, ArrayList<MainpageTopListVO> Toplist) throws Exception{
		String sql = "select rownum rnum, pc.name_eng,p.* from (select * from product order by rating desc) p,product_category pc where pc.category = p.category";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()){
			int rownum = rs.getInt("rnum");
			int product_number = rs.getInt("product_number");
			int price = rs.getInt("price");
			float rating = rs.getFloat("rating");
			String image_name = rs.getString("NAME_ENG"); 
			String product_name = rs.getString("product_name");
			String product_name_eng = rs.getString("product_name_eng");
			String attract_ment = rs.getString("attract_ment");					
			
			Toplist.add(new MainpageTopListVO(rownum,product_number,price,rating,image_name,product_name,product_name_eng,attract_ment));	
		}
		System.out.println("탑리스트 연동성공");
		pstmt.close();
		rs.close();
		return Toplist;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Connection conn = null;
		
		try{
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch(Exception e){ System.out.println("연동실패");}
		
//-------------------	시즌제품 구하는 메서드	
			ArrayList<MainpageSeasonVO> seasonList = new ArrayList<MainpageSeasonVO>();		

			try {
				seasonList = getSeason(conn,seasonList);
			} catch (Exception e) {
				e.printStackTrace();
			}
//---------------------- MD픽 제품 구하는 메서드
			ArrayList<MainpageMDVO> MDlist = new ArrayList<MainpageMDVO>();
			
			try {
				MDlist = getMDpick(conn, MDlist);
			} catch (Exception e) {
				e.printStackTrace();
			}
//----------------------------------		
		
			ArrayList<MainpageTopListVO> Toplist = new ArrayList<MainpageTopListVO>();
			
			try {
				Toplist = getToplist(conn, Toplist);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//----------------------------------
			
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=mainpageResult");
		request.setAttribute("seasonList", seasonList);
		request.setAttribute("MDlist", MDlist);
		request.setAttribute("Toplist", Toplist);
		rd.forward(request, response);
	}
}
