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

import MypageOrderListVO.OrderListVO;

public class MypageOrderListAction implements Action {

	public Connection connect(Connection conn) {
		try {
			Class.forName(Connect.driver);
			conn = DriverManager.getConnection(Connect.url,Connect.id,Connect.pw);
		}catch (Exception e) {}
		return conn;
	}
	
	public ArrayList<OrderListVO> extractOrderList(Connection conn,String member_id){
		// order_table.
		ArrayList<OrderListVO> listOrderListVO = null;
		
		try{
			String sql = "select member_id,product_number_amount,to_char(order_date, 'YY-MM-DD') as order_date,order_address,used_c_number,cost,requirements,order_number from order_table where member_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				
				if(listOrderListVO == null) {listOrderListVO = new ArrayList<OrderListVO>();}
				
				
				String productNumberAmount = rs.getString("product_number_amount");
				String[] arrProductNumberAmount = productNumberAmount.split("/");

				for(String strProductNumberAmount : arrProductNumberAmount) {
				
					OrderListVO orderListVO = new OrderListVO();
					
					orderListVO.setOrder_number(rs.getInt("order_number"));
					orderListVO.setOrder_date(rs.getString("order_date"));
					orderListVO.setCost(rs.getInt("cost"));
					
					
					int productNumber = Integer.parseInt(strProductNumberAmount.split("_")[0]);
					int amount = Integer.parseInt(strProductNumberAmount.split("_")[1]);
					
					String sql2 = "SELECT * FROM product WHERE product_number = ?";
					PreparedStatement pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setInt(1, productNumber);
					ResultSet rs2 = pstmt2.executeQuery();
					int category = -1;
					if(rs2.next()) {
						orderListVO.setProduct_name(rs2.getString("product_name"));
						orderListVO.setProduct_name_eng(rs2.getString("product_name_eng"));
						orderListVO.setPrice(rs2.getInt("price"));
						orderListVO.setRating(rs2.getFloat("rating"));
						orderListVO.setEach_amount(amount);
						orderListVO.setProduct_number(productNumber+"");
						category = rs2.getInt("category");
					}
					
					sql2 = "SELECT * FROM product_category WHERE category = ?";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setInt(1, category);
					rs2 = pstmt2.executeQuery();
					
					if(rs2.next()) {
						orderListVO.setCategory_name_eng(rs2.getString("name_eng"));
					}
					
					listOrderListVO.add(orderListVO);
				}
			}
		}catch (Exception e){ e.printStackTrace(); }
		return listOrderListVO;
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection conn = null;
		conn = connect(conn);
		System.out.println("여기까지들어옴");
		
		HttpSession session = request.getSession();
		String member_id = (String)(session.getAttribute("login_id"));
		
		
		ArrayList<OrderListVO> listOrderListVO = extractOrderList(conn,member_id);
		
		
		RequestDispatcher rd = request.getRequestDispatcher("Controller?command=mypageOrderListResult");
		request.setAttribute("listOrderListVO", listOrderListVO);
		rd.forward(request, response);
	}
}
