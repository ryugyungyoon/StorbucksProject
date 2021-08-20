package com.admin.www;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EachProductResult implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("여기까지도 들어옴");
		request.getRequestDispatcher("Eachproduct.jsp").forward(request, response);
	}

}
