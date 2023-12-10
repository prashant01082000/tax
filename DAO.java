package com.incapp.modal;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
public class DAO {
	Connection c;
	public DAO() throws ClassNotFoundException,SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		c=DriverManager.getConnection("jdbc:mysql://localhost:3306/taxico","root","Prashant@123");
	}
	public void closeConnection()throws SQLException {
		c.close();
	}
	
	public String setEnquiry(String name,String phone) throws SQLException{
		PreparedStatement p=c.prepareStatement("insert into enquiry (name,phone,status) values (?,?,'Pending')");
		p.setString(1, name);
		p.setString(2, phone);
		p.executeUpdate();
		return "Enquiry Send success!";
	}
	public String checkAdminLogin(String id,String password) throws SQLException{
		PreparedStatement p=c.prepareStatement("select * from admin where id=? and password=?");
		p.setString(1, id);
		p.setString(2, password);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			return rs.getString("name");
		}else {
			return null;
		}
	}

	public String checkUserLogin(String email,String password) throws SQLException{
		PreparedStatement p=c.prepareStatement("select * from users where email=? and password=?");
		p.setString(1, email);
		p.setString(2, password);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			return rs.getString("name");
		}else {
			return null;
		}
	}
	public String checkTaxiOwnerLogin(String email,String password) throws SQLException{
		PreparedStatement p=c.prepareStatement("select * from taxi_owner where email=? and password=?");
		p.setString(1, email);
		p.setString(2, password);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			String status=rs.getString("status");
			if(status.equalsIgnoreCase("pending")) {
				return "Verification Status is Pending";
			}else if(status.equalsIgnoreCase("rejected")) {
				return "Registration Rejected. Contact our support team.";
			}else {
				return rs.getString("name");
			}
		}else {
			return null;
		}
	}
	public ArrayList<HashMap> getAllEnquiry() throws SQLException{
		ArrayList<HashMap> allEnquiry=new ArrayList();
		PreparedStatement p=c.prepareStatement("select * from enquiry");
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap<String,String> enquiry=new HashMap();
			enquiry.put("name", rs.getString("name"));
			enquiry.put("phone", rs.getString("phone"));
			enquiry.put("status", rs.getString("status"));
			enquiry.put("id", rs.getString("id"));
			allEnquiry.add(enquiry);
		}
		return allEnquiry;
	}
	public ArrayList<HashMap> getAllTaxiOwner(String status) throws SQLException{
		ArrayList<HashMap> allTaxiOwner=new ArrayList();
		PreparedStatement p;
		if(status==null) {
			p=c.prepareStatement("select * from taxi_owner order by name");
		}else {
			p=c.prepareStatement("select * from taxi_owner where status=? order by name");
			p.setString(1, status);
		}
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap<String, String> taxiOwner=new HashMap<>(); 
			taxiOwner.put("email", rs.getString("email"));
			taxiOwner.put("name", rs.getString("name"));
			taxiOwner.put("phone", rs.getString("phone"));
			taxiOwner.put("address", rs.getString("address"));
			taxiOwner.put("company_name", rs.getString("company_name"));
			taxiOwner.put("company_reg_no", rs.getString("company_reg_no"));
			taxiOwner.put("status", rs.getString("status"));
			allTaxiOwner.add(taxiOwner);
		}
		return allTaxiOwner;
	}
	public ArrayList<HashMap> getAllTaxiByOwnerEmail(String email) throws SQLException{
		ArrayList<HashMap> allTaxi=new ArrayList();
		PreparedStatement p=c.prepareStatement("select * from taxi where taxi_owner_email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> taxi=new HashMap<>(); 
			taxi.put("taxi_no", rs.getString("taxi_no"));
			taxi.put("taxi_name", rs.getString("taxi_name"));
			taxi.put("seat", rs.getInt("seat"));
			taxi.put("taxi_type", rs.getString("taxi_type"));
			taxi.put("fuel_type", rs.getString("fuel_type"));
			taxi.put("driver_name", rs.getString("driver_name"));
			taxi.put("phone", rs.getString("phone"));
			taxi.put("gender", rs.getString("gender"));
			taxi.put("status", rs.getString("status"));
			taxi.put("location", rs.getString("location"));
			allTaxi.add(taxi);
		}
		return allTaxi;
	}
	public ArrayList<HashMap> getAllTaxiBookingByUserEmail(String user_email) throws SQLException{
		ArrayList<HashMap> allTaxi_bookings=new ArrayList();
		PreparedStatement p=c.prepareStatement("select * from taxi_bookings where user_email=?");
		p.setString(1, user_email);
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap<String, String> taxi_booking=new HashMap<>(); 
			taxi_booking.put("booking_id",rs.getString("id"));
			taxi_booking.put("taxi_no",rs.getString("taxi_no"));
			taxi_booking.put("booking_date",rs.getString("booking_date"));
			taxi_booking.put("status",rs.getString("status"));
			allTaxi_bookings.add(taxi_booking);
		}
		return allTaxi_bookings;
	}

	public ArrayList<HashMap> getAllTaxiBookingByTaxiOwnerEmail(String email) throws SQLException{
		ArrayList<HashMap> allTaxi_bookings=new ArrayList();
		PreparedStatement p=c.prepareStatement("select * from taxi_bookings where taxi_owner_email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap<String, String> taxi_booking=new HashMap<>(); 
			taxi_booking.put("booking_id",rs.getString("id"));
			taxi_booking.put("user_email",rs.getString("user_email"));
			taxi_booking.put("taxi_no",rs.getString("taxi_no"));
			taxi_booking.put("booking_date",rs.getString("booking_date"));
			taxi_booking.put("status",rs.getString("status"));
			allTaxi_bookings.add(taxi_booking);
		}
		return allTaxi_bookings;
	}
	public ArrayList<HashMap> getAllTaxiByLocation(String location) throws SQLException{
		ArrayList<HashMap> allTaxi=new ArrayList();
		PreparedStatement p=c.prepareStatement("select * from taxi where location=? and status='Activate'");
		p.setString(1, location);
		ResultSet rs=p.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> taxi=new HashMap<>(); 
			taxi.put("taxi_no", rs.getString("taxi_no"));
			taxi.put("taxi_name", rs.getString("taxi_name"));
			taxi.put("seat", rs.getInt("seat"));
			taxi.put("taxi_type", rs.getString("taxi_type"));
			taxi.put("fuel_type", rs.getString("fuel_type"));
			taxi.put("driver_name", rs.getString("driver_name"));
			taxi.put("phone", rs.getString("phone"));
			taxi.put("gender", rs.getString("gender"));
			taxi.put("taxi_owner_email", rs.getString("taxi_owner_email"));
			allTaxi.add(taxi);
		}
		return allTaxi;
	}
	public HashMap<String, Object> getTaxiByTaxiNo(String taxi_no) throws SQLException{
		PreparedStatement p=c.prepareStatement("select * from taxi where taxi_no=?");
		p.setString(1, taxi_no);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			HashMap<String, Object> taxi=new HashMap<>(); 
			taxi.put("taxi_no", rs.getString("taxi_no"));
			taxi.put("taxi_name", rs.getString("taxi_name"));
			taxi.put("seat", rs.getInt("seat"));
			taxi.put("taxi_type", rs.getString("taxi_type"));
			taxi.put("fuel_type", rs.getString("fuel_type"));
			taxi.put("driver_name", rs.getString("driver_name"));
			taxi.put("phone", rs.getString("phone"));
			taxi.put("gender", rs.getString("gender"));
			taxi.put("location", rs.getString("location"));
			return taxi;
		}else {
			return null;
		}
	}
	public HashMap<String, String> getTaxiOwnerByEmail(String email) throws SQLException{
		PreparedStatement p=c.prepareStatement("select * from taxi_owner where email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			HashMap<String, String> taxiOwner=new HashMap<>(); 
			taxiOwner.put("email", rs.getString("email"));
			taxiOwner.put("name", rs.getString("name"));
			taxiOwner.put("phone", rs.getString("phone"));
			taxiOwner.put("address", rs.getString("address"));
			taxiOwner.put("company_name", rs.getString("company_name"));
			taxiOwner.put("company_reg_no", rs.getString("company_reg_no"));
			taxiOwner.put("status", rs.getString("status"));
			return taxiOwner;
		}else {
			return null;
		}
	}

	public HashMap<String, String> getUserByEmail(String email) throws SQLException{
		PreparedStatement p=c.prepareStatement("select * from users where email=?");
		p.setString(1, email);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			HashMap<String, String> user=new HashMap<>(); 
			user.put("email", rs.getString("email"));
			user.put("name", rs.getString("name"));
			user.put("phone", rs.getString("phone"));
			user.put("address", rs.getString("address"));
			return user;
		}else {
			return null;
		}
	}
	public String changeEnquiryStatus(int id,String status) throws SQLException{
		PreparedStatement p=c.prepareStatement("update enquiry set status=? where id=?");
		p.setString(1, status);
		p.setInt(2, id);
		p.executeUpdate();
		return "Enquiry Status Updation success!";
	}
	public String changeTaxiBookingStatus(int id,String status) throws SQLException{
		PreparedStatement p=c.prepareStatement("update taxi_bookings set status=? where id=?");
		p.setString(1, status);
		p.setInt(2, id);
		p.executeUpdate();
		return "Taxi Booking Status Updation success!";
	}
	public String changeTaxiOwnerStatus(String email,String status) throws SQLException{
		PreparedStatement p=c.prepareStatement("update taxi_owner set status=? where email=?");
		p.setString(1, status);
		p.setString(2, email);
		p.executeUpdate();
		return "Status Updation success!";
	}
	public String changeTaxiStatus(String taxi_no,String status) throws SQLException{
		if(status.equalsIgnoreCase("remove")) {
			PreparedStatement p=c.prepareStatement("delete from taxi where taxi_no=?");
			p.setString(1, taxi_no);
			p.executeUpdate();
			return "Taxi Removed success!";
		}else {
			PreparedStatement p=c.prepareStatement("update taxi set status=? where taxi_no=?");
			p.setString(1, status);
			p.setString(2, taxi_no);
			p.executeUpdate();
			return "Status Updation success!";
		}
		
	}
	public String registerTaxiOwner(HashMap<String, Object> taxiOwner) throws SQLException{
		PreparedStatement p=c.prepareStatement("insert into taxi_owner (email,password,name,phone,address,company_name,company_reg_no,photo,status) values (?,?,?,?,?,?,?,?,'Pending')");
		p.setString(1, (String)taxiOwner.get("email"));
		p.setString(2, (String)taxiOwner.get("password"));
		p.setString(3, (String)taxiOwner.get("name"));
		p.setString(4, (String)taxiOwner.get("phone"));
		p.setString(5, (String)taxiOwner.get("address"));
		p.setString(6, (String)taxiOwner.get("company_name"));
		p.setString(7, (String)taxiOwner.get("company_reg_no"));
		p.setBinaryStream(8, (InputStream)taxiOwner.get("photo"));
		try {
			p.executeUpdate();
			return "Registration success!";
		}catch (SQLIntegrityConstraintViolationException e) {
			return "Registration failed (Email id already exist)!";
		}
	}
	public String registerUser(HashMap<String, Object> user) throws SQLException{
		PreparedStatement p=c.prepareStatement("insert into users (email,password,name,phone,address,photo) values (?,?,?,?,?,?)");
		p.setString(1, (String)user.get("email"));
		p.setString(2, (String)user.get("password"));
		p.setString(3, (String)user.get("name"));
		p.setString(4, (String)user.get("phone"));
		p.setString(5, (String)user.get("address"));
		p.setBinaryStream(6, (InputStream)user.get("photo"));
		try {
			p.executeUpdate();
			return "Registration success!";
		}catch (SQLIntegrityConstraintViolationException e) {
			return "Registration failed (Email id already exist)!";
		}
	}
	public String addTaxi(HashMap<String, Object> taxi) throws SQLException{
		PreparedStatement p=c.prepareStatement("insert into taxi (taxi_no,taxi_name,seat,taxi_type,fuel_type,driver_name,phone,photo,gender,taxi_owner_email,location,status) values (?,?,?,?,?,?,?,?,?,?,?,'Pending')");
		p.setString(1, (String)taxi.get("taxi_no"));
		p.setString(2, (String)taxi.get("taxi_name"));
		p.setInt(3, (int)taxi.get("seat"));
		p.setString(4, (String)taxi.get("taxi_type"));
		p.setString(5, (String)taxi.get("fuel_type"));
		p.setString(6, (String)taxi.get("driver_name"));
		p.setString(7, (String)taxi.get("phone"));
		p.setBinaryStream(8, (InputStream)taxi.get("photo"));
		p.setString(9, (String)taxi.get("gender"));
		p.setString(10, (String)taxi.get("taxi_owner_email"));
		p.setString(11, (String)taxi.get("location"));
		try {
			p.executeUpdate();
			return "Taxi Added success!";
		}catch (SQLIntegrityConstraintViolationException e) {
			return "Add Taxi failed (Taxi number already exist)!";
		}
	}
	public String bookTaxi(String user_email,String taxi_no,String taxi_owner_email) throws SQLException{
		PreparedStatement p=c.prepareStatement("insert into taxi_bookings (user_email,taxi_owner_email,taxi_no,booking_date,status) values (?,?,?,CURRENT_DATE,'Booked')");
		p.setString(1, user_email);
		p.setString(2, taxi_owner_email);
		p.setString(3, taxi_no);
		p.executeUpdate();
		return "Taxi Booking success!";
	}
	public byte[] getPhoto(String id,String user_type) throws SQLException{
		PreparedStatement p;
		if(user_type.equalsIgnoreCase("taxi_owner")) {
			p=c.prepareStatement("select photo from taxi_owner where email=?");
		}else if(user_type.equalsIgnoreCase("driver")) {
			p=c.prepareStatement("select photo from taxi where taxi_no=?");
		}else {
			p=c.prepareStatement("select photo from users where email=?");
		}
		p.setString(1, id);
		ResultSet rs=p.executeQuery();
		if(rs.next()) {
			return rs.getBytes("photo");
		}else {
			return null;
		}
	}
}
