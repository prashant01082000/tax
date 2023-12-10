<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.incapp.modal.DAO"%>
<%
	String name=(String)session.getAttribute("name");
	if(name==null){
		session.setAttribute("msg", "Please Login!");
		response.sendRedirect("index.jsp");
	}else{

  		String user_email=(String)session.getAttribute("user_email");
%>
<!DOCTYPE html>
<html>

<head>
  <title>Taxico</title>
  <link rel="icon" href="resources/taxico.png" />

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" />

  <!-- font-awesome  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/js/all.min.js"></script>
  
  <!-- Lightbox CSS & Script -->
  <script src="resources/lightbox/ekko-lightbox.js"></script>
  <link rel="stylesheet" href="resources/lightbox/ekko-lightbox.css"/>
  <!-- Lightbox END -->
  <!-- AOS css and JS -->
  <link rel="stylesheet" href="resources/aos/aos.css">
  <script src="resources/aos/aos.js"></script>
  <!-- AOS css and JS END-->

  <!-- custom css -->
  <link rel="stylesheet" href="resources/custom.css">

  <meta name="author" content="Rahul Chauhan" />
  <meta name="description" content="This is a website for Taxi Service." />
  <meta name="keywords" content="best Website designer" />
</head>

<body>
	
	<%
		String msg=(String)session.getAttribute("msg");
		if(msg!=null){
		 	if(msg.contains("success")){
	%>
				<p class="bg-success text-white text-center p-4"><%= msg %></p>
	<%	 		
		 	}else{
	%>
				<p class="bg-danger text-white text-center p-4"><%= msg %></p>
	<%		 		
		 	}
		 	session.setAttribute("msg", null);
		}
	%>

    <div id="chess-box"></div>
    <nav class="navbar navbar-expand-sm">
        <a href="UserHome.jsp" class="c-logo">
          <img src="resources/taxico.png" alt="" />
          <div>
              <h2>Taxi<span>co</span></h2>
              <p><small>Taxi Service</small></p>
          </div>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar"><i class="fa-solid fa-bars"></i></button>
        <div class="collapse navbar-collapse" id="my-navbar">
          <ul class="navbar-nav mx-auto">
          	  <li>
          	  	<form action="SearchTaxi.jsp" method="post" class="mt-1 mr-4">
	              	<label>Search Taxi:</label>
	              	<input type="search" name="location"placeholder="Enter your location" required />
	              	<button class="btn btn-primary btn-sm">Search</button>
	              </form>
              </li>
              <li>
                <a class="nav-link" href="UserHome.jsp">Bookings</a>
              </li>
          </ul>
          <div>
              <p> 
              	Welcome: <b><%= name %></b> 
              	<img src="GetPhoto?id=<%= user_email %>&user_type=user" height="50px" />
              	<a class="btn btn-sm btn-danger" href="Logout">Logout</a>
              </p>
          </div>
        </div>
    </nav>
  <section>
  	<h4 class="bg-dark text-white text-center p-3">All Bookings</h4>
  	<%
  		DAO db=new DAO();
  		ArrayList<HashMap> allTaxi_bookings=db.getAllTaxiBookingByUserEmail(user_email);
  		for(HashMap<String,String> taxi_booking:allTaxi_bookings){
  			String taxi_no=taxi_booking.get("taxi_no");
  			int booking_id=Integer.parseInt(taxi_booking.get("booking_id"));
  			String booking_date=taxi_booking.get("booking_date");
  			String taxi_booking_status=taxi_booking.get("status");
  			HashMap<String,Object> taxi=db.getTaxiByTaxiNo(taxi_no);
  	%>
  		<div class="bg-info m-2 p-4 text-left">
  			
			<img src="GetPhoto?id=<%= taxi.get("taxi_no") %>&user_type=driver" height="50px" />
  			<p>
  			Booking Date: <b><%= booking_date%></b>  &nbsp;&nbsp;&nbsp;
  			Booking Status: <b><%= taxi_booking_status%></b>  &nbsp;&nbsp;&nbsp;
  			<%
  				if(taxi_booking_status.equalsIgnoreCase("booked")){
  			%>
  				<a class="btn btn-sm btn-danger" href="ChangeTaxiBookingStatus?id=<%=booking_id%>&status=Cancel&user_type=user">Cancel</a>
  			<%		
  				}
  			%>
  			</p>
  			<p>
  			Taxi No: <b><%= taxi.get("taxi_no") %></b> &nbsp;&nbsp;&nbsp;
  			Taxi Name: <b><%= taxi.get("taxi_name") %></b> &nbsp;&nbsp;&nbsp;
  			Seats: <b><%= taxi.get("seat") %></b> &nbsp;&nbsp;&nbsp;
  			Taxi Type: <b><%= taxi.get("taxi_type") %></b> &nbsp;&nbsp;&nbsp;
  			Location: <b><%= taxi.get("location") %></b> &nbsp;&nbsp;&nbsp;
  			</p>
  			<p>
  			Fuel Type: <b><%= taxi.get("fuel_type") %></b> &nbsp;&nbsp;&nbsp;
  			Driver Name: <b><%= taxi.get("driver_name") %></b>  &nbsp;&nbsp;&nbsp;
  			Driver Phone: <b><%= taxi.get("phone") %></b>  &nbsp;&nbsp;&nbsp;
  			Driver Gender: <b><%= taxi.get("gender") %></b>  &nbsp;&nbsp;&nbsp;
  			</p>
  		</div>
  	<%		
  		}
  		db.closeConnection();
  	%>
  </section>  
  <footer class="container-fluid text-center bg-dark p-3" id="contact">
      <div class="row text-white">
          <div class="col-sm m-2">
            <a href="index.html" class="c-logo">
              <img src="resources/taxico.png" alt="" />
              <div>
                  <h2 class="text-white">Taxi<span>co</span></h2>
                  <p><small>Taxi Service</small></p>
              </div>
            </a>
          </div>
          <div class="col-sm m-2">
            <p class="text-white pt-2">
              <i class="fa-solid fa-phone"></i> Call us: <a class="text-danger" href="tel:9811XXXXXX">9811XXXXXX</a>
              <a class="mx-2 text-muted" target="_blank" href="https://www.facebook.com/incapp"><i class="fa-brands fa-facebook fa-2x"></i></a>
              <a class="mx-2 text-muted" target="_blank" href="https://www.instagram.com/incapp.in"><i class="fa-brands fa-instagram fa-2x"></i></a>
              <a class="mx-2 text-muted" target="_blank" href="https://www.youtube.com/incapp"><i class="fa-brands fa-youtube fa-2x"></i></a>
            </p>
          </div>
      </div>
  </footer>
  <div id="chess-box-gray"></div>
  <a  id="top-button"><i class="fa-solid fa-square-caret-up fa-2x"></i></a>


  
</body>
</html>
<%
}
%>