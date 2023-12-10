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
@WebServlet("/AddTaxi")
public class AddTaxi extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String taxi_no=request.getParameter("taxi_no");
			String taxi_name=request.getParameter("taxi_name");
			int seat=Integer.parseInt(request.getParameter("seat"));
			String taxi_type=request.getParameter("taxi_type");
			String fuel_type=request.getParameter("fuel_type");
			String driver_name=request.getParameter("driver_name");
			String gender=request.getParameter("gender");
			String phone=request.getParameter("phone");
			Part part=request.getPart("photo");
			String location=request.getParameter("location");
			InputStream photo=part.getInputStream();
			
			HttpSession session=request.getSession();
			String taxi_owner_email=(String)session.getAttribute("email");
			
			HashMap<String, Object> taxi=new HashMap<>(); 
			taxi.put("taxi_no", taxi_no);
			taxi.put("taxi_name", taxi_name);
			taxi.put("seat", seat);
			taxi.put("taxi_type", taxi_type);
			taxi.put("fuel_type", fuel_type);
			taxi.put("driver_name", driver_name);
			taxi.put("gender", gender);
			taxi.put("phone", phone);
			taxi.put("photo", photo);
			taxi.put("taxi_owner_email", taxi_owner_email);
			taxi.put("location", location);
			
			
			DAO db=new DAO();
			String result=db.addTaxi(taxi);
			db.closeConnection();
			
			session.setAttribute("msg", result);
			response.sendRedirect("TaxiOwnerHome.jsp");
		}catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("ExceptionPage.jsp");
		}
	}

}
