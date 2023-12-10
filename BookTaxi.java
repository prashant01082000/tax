package com.incapp.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.incapp.modal.DAO;

/**
 * Servlet implementation class Enquiry
 */
@MultipartConfig
@WebServlet("/BookTaxi")
public class BookTaxi extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String taxi_no=request.getParameter("taxi_no");
			String taxi_owner_email=request.getParameter("taxi_owner_email");
			HttpSession session=request.getSession();
			String user_email=(String)session.getAttribute("user_email");
			
			if(user_email!=null) {
				DAO db=new DAO();
				String result=db.bookTaxi(user_email,taxi_no,taxi_owner_email);
				db.closeConnection();
				session.setAttribute("msg", result);
				response.sendRedirect("UserHome.jsp");
			}else {
				session.setAttribute("msg", "Please login first!");
				response.sendRedirect("User.jsp");
			}
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
