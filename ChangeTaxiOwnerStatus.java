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
@WebServlet("/ChangeTaxiOwnerStatus")
public class ChangeTaxiOwnerStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String email=request.getParameter("email");
			String status=request.getParameter("status");
			DAO db=new DAO();
			String result=db.changeTaxiOwnerStatus(email, status);
			db.closeConnection();
			HttpSession session=request.getSession();
			session.setAttribute("msg", result);
			response.sendRedirect("AdminTaxiOwnerDetails.jsp?email="+email);
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
