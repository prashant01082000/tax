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
@WebServlet("/ChangeTaxiBookingStatus")
public class ChangeTaxiBookingStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int id=Integer.parseInt(request.getParameter("id"));
			String status=request.getParameter("status");
			String user_type=request.getParameter("user_type");
			DAO db=new DAO();
			String result=db.changeTaxiBookingStatus(id, status);
			db.closeConnection();
			HttpSession session=request.getSession();
			session.setAttribute("msg", result);
			if(user_type.equalsIgnoreCase("user")) {
				response.sendRedirect("UserHome.jsp");
			}else {
				response.sendRedirect("TaxiBooking.jsp");
			}
			
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
