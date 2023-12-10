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
@WebServlet("/TaxiOwnerLogin")
public class TaxiOwnerLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String email=request.getParameter("email");
			String password=request.getParameter("password");
			DAO db=new DAO();
			String result=db.checkTaxiOwnerLogin(email, password);
			db.closeConnection();
			HttpSession session=request.getSession();
			if(result==null) {
				session.setAttribute("msg", "ID or Password wrong!");
				response.sendRedirect("TaxiOwner.jsp");
			}else if(result.contains("Pending") || result.contains("Rejected")){
				session.setAttribute("msg",result );
				response.sendRedirect("TaxiOwner.jsp");
			}else {
				session.setAttribute("name",result );
				session.setAttribute("email",email );
				response.sendRedirect("TaxiOwnerHome.jsp");
			}
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
			e.printStackTrace();
		}
	}

}
