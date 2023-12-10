package com.incapp.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.incapp.modal.DAO;

/**
 * Servlet implementation class Enquiry
 */
@WebServlet("/GetPhoto")
public class GetPhoto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String email=request.getParameter("email");
			String person_type=request.getParameter("user_type");
			DAO db=new DAO();
			byte photo[]=db.getPhoto(email, person_type);
			db.closeConnection();
			response.getOutputStream().write(photo);
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
