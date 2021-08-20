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
import javax.servlet.http.HttpSession;

import LikedVO.LikedVO;


public class MypageLikedAction implements Action {
	public Connection connect(Connection conn) {
		
		try {
		Class.forName(Connect.driver);
		conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch(Exception e) { }
		
		return conn;
	}
	
	public ArrayList<LikedVO> getLiked(Connection conn, ArrayList<LikedVO> listlike,String member_id){
		
		try {
			String sql = "select pc.name_eng,l.* from (select * from product where product_number in (select product_number from liked where member_id = ?))l, product_category pc where pc.category = l.category";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String product_name = rs.getString("product_name");
				String product_name_eng = rs.getString("product_name_eng");
				String product_category_name = rs.getString("name_eng");
				int product_number = rs.getInt("product_number");
				int price = rs.getInt("price");
				float rating = rs.getFloat("rating");
				
				if(listlike==null) listlike = new ArrayList<>();
				listlike.add(new LikedVO(product_name,product_name_eng,product_category_name,product_number,price,rating));
			}
			rs.close();
			pstmt.close();
		}catch (Exception e) {System.out.println("디비에저장안됨");}
		
		return listlike;
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("여기까지들어옴");
		Connection conn = null;
		conn = connect(conn);
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));

		//좋아요메서드
		ArrayList<LikedVO> listlike = null;
		listlike = getLiked(conn, listlike,member_id);
		
		
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=mypageLikedResult");
		request.setAttribute("listlike", listlike);
		rd.forward(request, response);
	}
}	
	
	

