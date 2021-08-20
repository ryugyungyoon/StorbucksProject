package com.admin.www;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MypageDropResult implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			System.out.println("MypageDropResult까지 들어옴");
			request.getRequestDispatcher("MainpageServlet").forward(request, response);
	}

}
