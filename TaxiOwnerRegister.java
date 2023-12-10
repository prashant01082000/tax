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
@WebServlet("/TaxiOwnerRegister")
public class TaxiOwnerRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String email=request.getParameter("email");
			String name=request.getParameter("name");
			String phone=request.getParameter("phone");
			String address=request.getParameter("address");
			String company_name=request.getParameter("company_name");
			String company_reg_no=request.getParameter("company_reg_no");
			String password=request.getParameter("password");
			Part part=request.getPart("photo");
			InputStream photo=part.getInputStream();
			
			HashMap<String, Object> taxiOwner=new HashMap<>(); 
			taxiOwner.put("email", email);
			taxiOwner.put("name", name);
			taxiOwner.put("phone", phone);
			taxiOwner.put("address", address);
			taxiOwner.put("company_name", company_name);
			taxiOwner.put("company_reg_no", company_reg_no);
			taxiOwner.put("password", password);
			taxiOwner.put("photo", photo);
			
			
			DAO db=new DAO();
			String result=db.registerTaxiOwner(taxiOwner);
			db.closeConnection();
			HttpSession session=request.getSession();
			session.setAttribute("msg", result);
			response.sendRedirect("TaxiOwner.jsp");
		}catch (Exception e) {
			response.sendRedirect("ExceptionPage.jsp");
			e.printStackTrace();
		}
	}

}
