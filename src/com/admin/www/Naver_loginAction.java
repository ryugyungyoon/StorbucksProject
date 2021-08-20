package com.admin.www;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Naver_loginAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("들어옴");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String token = request.getParameter("token");
		
		System.out.println(name);
		System.out.println(email);
		System.out.println(token);
		
		
		HttpSession session = request.getSession();
		session.setAttribute("login_id", email);
		
		request.getRequestDispatcher("Controller?command=mainpage").forward(request, response);
		
	}
}
