<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.incapp.modal.DAO"%>
<%
	String name=(String)session.getAttribute("name");
	if(name==null){
		session.setAttribute("msg", "Please Login!");
		response.sendRedirect("TaxiOwner.jsp");
	}else{
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
        <a href="TaxiOwnerHome.jsp" class="c-logo">
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
                <a class="nav-link" href="TaxiOwnerHome.jsp">Home</a>
              </li>
              <li>
                <a class="nav-link" href="TaxiBooking.jsp">Bookings</a>
              </li>
          </ul>
          <div>
              <p> 
              	Welcome: <b><%= name %></b>
              	<a class="btn btn-sm btn-danger" href="Logout">Logout</a>
              </p>
          </div>
        </div>
    </nav>
  <section class="container-fluid text-center">
  	<div class="row bg-warning p-4">
  		<div class="col-sm">
  			<div class=" bg-light p-3">
  				<h5 class="text-center">Add New Taxi</h5>
  				<form action="AddTaxi" method="post" enctype="multipart/form-data">
		            <div class="row p-3">
		                <label class="ml-2">Taxi Number:</label>
		                <input name="taxi_no" class="m-2 form-control" type="text" placeholder="Taxi Number" required>
		                <label class="ml-2">Name:</label>
		                <input name="taxi_name" class="m-2 form-control" type="text" maxlength="50" placeholder="Vehicle Name" required>
		                <label class="ml-2">No of Seat:</label>
		                <input name="seat" value="3" class="m-2 form-control" type="number" max="10" min="1" placeholder="Seats" required>
		                <label class="ml-2">Select Vehicle Type:</label>
		                <select class="m-2 form-control" name="taxi_type">
	                		<option>Mini</option>
	                		<option>Sedan</option>
	                		<option>SUV</option>
		                </select>
		                <label class="ml-2">Select Fuel Type:</label>
		                <select class="m-2 form-control" name="fuel_type">
	                		<option>Petrol</option>
	                		<option>Diesel</option>
	                		<option>CNG</option>
	                		<option>Electric</option>
		                </select>
		                <label class="ml-2">Driver Name:</label>
		                <input name="driver_name" class="m-2 form-control" type="text" maxlength="50" placeholder="Driver Name" >
		                <label class="ml-2">Gender:</label>
		                <input type="radio" class="m-2" name="gender" value="Male" checked />Male
		                <input type="radio" class="m-2" name="gender" value="Female"/>Female
		                <input type="radio" class="m-2" name="gender" value="Other"/>Other
		                <input name="phone" class="m-2 form-control" type="tel" maxlength="10" minlength="10" pattern="[0-9]+"  placeholder="Phone" required>
		                <label class="ml-2">Upload Your Photo:</label>
		                <input name="photo" class="m-2 form-control" type="file" required>
		                <label class="ml-2">Location:</label>
		                <input name="location" class="m-2 form-control" type="text" required>
		                <br/>
		                <button class="col-md m-2 btn btn-dark form-control">Add</button>
		            </div>
	          	</form>
  			</div>
  		</div>
  		<div class="col-sm">
  			<div class=" bg-light p-3">
  				<%
			  		DAO db=new DAO();
  					String email=(String)session.getAttribute("email");
			  		ArrayList<HashMap> allTaxi=db.getAllTaxiByOwnerEmail(email);
			  		db.closeConnection();
			  		for(HashMap<String,Object> taxi:allTaxi){
			  	%>
			  		<div class="bg-info m-2 p-4 text-left">
			  			<img src="GetPhoto?id=<%= taxi.get("taxi_no") %>&user_type=driver" height="50px" />
			  			<p>
			  			Taxi No: <b><%= taxi.get("taxi_no") %></b> &nbsp;&nbsp;&nbsp;
			  			Taxi Name: <b><%= taxi.get("taxi_name") %></b> &nbsp;&nbsp;&nbsp;
			  			Seats: <b><%= taxi.get("seat") %></b> &nbsp;&nbsp;&nbsp;
			  			Taxi Type: <b><%= taxi.get("taxi_type") %></b> &nbsp;&nbsp;&nbsp;
			  			Location: <b><%= taxi.get("location") %></b> &nbsp;&nbsp;&nbsp;
			  			</p>
			  			<p>
			  			Fuel Type: <b><%= taxi.get("fuel_type") %></b> &nbsp;&nbsp;&nbsp;
			  			Name: <b><%= taxi.get("driver_name") %></b>  &nbsp;&nbsp;&nbsp;
			  			Phone: <b><%= taxi.get("phone") %></b>  &nbsp;&nbsp;&nbsp;
			  			Gender: <b><%= taxi.get("gender") %></b>  &nbsp;&nbsp;&nbsp;
			  			<% String status=(String)taxi.get("status"); %>
			  			Status: <b><%= status %></b> 
			  			</p>
			  			<p>
			  			<%
			  				if(!status.equalsIgnoreCase("pending") || !status.equalsIgnoreCase("rejected")){
			  					if(status.equalsIgnoreCase("activate")){
			  			%>
			  					<a class="btn btn-sm btn-secondary" href="ChangeTaxiStatus?taxi_no=<%=taxi.get("taxi_no")%>&status=Deactivate&request_page=TaxiOwnerHome">Deactivate</a>
			  				<% 
			  					}
			  					if(status.equalsIgnoreCase("deactivate")){
						  	%>
			  					<a class="btn btn-sm btn-success" href="ChangeTaxiStatus?taxi_no=<%=taxi.get("taxi_no")%>&status=Activate&request_page=TaxiOwnerHome">Activate</a>
			  				<% 
			  					}
			  				}
			  				%>
			  				<a class="btn btn-sm btn-danger" href="ChangeTaxiStatus?taxi_no=<%=taxi.get("taxi_no")%>&status=remove&request_page=TaxiOwnerHome">Remove</a>
			  			</p>
			  		</div>
			  	<%		
			  		}
			  	%>
  			</div>
  		</div>	
  	</div>
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