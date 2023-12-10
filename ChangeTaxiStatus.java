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
@WebServlet("/ChangeTaxiStatus")
public class ChangeTaxiStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String taxi_no=request.getParameter("taxi_no");
			String request_page=request.getParameter("request_page");
			String status=request.getParameter("status");
			DAO db=new DAO();
			String result=db.changeTaxiStatus(taxi_no, status);
			db.closeConnection();
			HttpSession session=request.getSession();
			session.setAttribute("msg", result);
			response.sendRedirect(request_page+".jsp");
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
			e.printStackTrace();
		}
	}

}
