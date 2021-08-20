package com.admin.www;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import EachproductVO.EachprojectReviewVO;

@WebServlet("/RatingDownServlet")
public class RatingDownServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public Connection connect(Connection conn) {
		try {
		Class.forName(Connect.driver);
		conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}
		catch(Exception e) {}
		
		return conn;
	}
	public ArrayList<EachprojectReviewVO> ratingOver(Connection conn, ArrayList<EachprojectReviewVO> listrtover, int page, int productNumber){
		
		try {
			String sql = "select r2.* from (select rownum rnum, r.* from (SELECT * FROM review where product_number = ? order by rating asc)r) r2 where rnum>=? and rnum<=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productNumber);
			pstmt.setInt(2, page*10-9);
			pstmt.setInt(3, page*10);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				if(listrtover==null)
					listrtover = new ArrayList<EachprojectReviewVO>();

				int rno = rs.getInt("rno");
				String writer_id = rs.getString("writer_id");
				String title = rs.getString("title");
				String content = rs.getString("content");
				int rating = rs.getInt("rating");
				int product_number = rs.getInt("product_number");
				String review_date = rs.getString("review_date");
				
				listrtover.add(new EachprojectReviewVO(rno,writer_id,title,content,rating,product_number,review_date));
				
				
				}
			return listrtover;
			
			} 	catch (SQLException e) { e.printStackTrace();}
		
			return listrtover;
	}
	
	public int reviewAmount(Connection conn, int productNumber){
	      try {
	         String sql = "select count(*) from review where product_number = ?";
	         PreparedStatement pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, productNumber);
	         ResultSet rs = pstmt.executeQuery();
	         
	         int count = 0;
	         
	         while(rs.next()){count = rs.getInt(1);}
	         if(count%10==0) return count/10;
	         else return count/10+1;
	      }catch (Exception e) {}
	      return 0;
	   }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		//파라미터 페이지변경
		int page = Integer.parseInt(request.getParameter("page")); 
		int productNumber = Integer.parseInt(request.getParameter("productNumber"));
		//리뷰를 어레이리스트에 담아서 JSONArray에 보낼꺼임
		ArrayList<EachprojectReviewVO> listrtover = null;
		listrtover = ratingOver(conn,listrtover,page,productNumber);
		//페이지 버튼 갯수 설정할꺼임
		int pageList = 0;
		pageList = reviewAmount(conn,productNumber);
		
		//JSON으로 던지기!
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		/////////////////////////////////////////////
		JSONArray jArray = new JSONArray();
		for(EachprojectReviewVO vo : listrtover) {
			Map<String,String> map1 = new HashMap<String,String>();
			map1.put("rno", vo.getRno()+"");
			map1.put("writer_id", vo.getWriter_id());
			map1.put("title", vo.getTitle());
			map1.put("content", vo.getContent());
			map1.put("rating", vo.getRating()+"");
			map1.put("product_number", vo.getProduct_number()+"");
			map1.put("review_date", vo.getReview_date());
			jArray.add(map1);
			System.out.print(" . ");
		}
		System.out.println("size : " + jArray.size());
		obj.put("list", jArray);
		obj.put("pageList", pageList);
		out.print(obj);
	}
				
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
}
