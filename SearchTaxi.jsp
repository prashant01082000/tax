<!DOCTYPE html>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.incapp.modal.DAO"%>
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
    <%
    	String user_email=(String)session.getAttribute("user_email");
    	if(user_email==null){
    %>
    <nav class="navbar navbar-expand-sm">
        <a href="index.jsp" class="c-logo">
          <img src="resources/taxico.png" alt="" />
          <div>
              <h2>Taxi<span>co</span></h2>
              <p><small>Taxi Service</small></p>
          </div>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar"><i class="fa-solid fa-bars"></i></button>
        <div class="collapse navbar-collapse" id="my-navbar">
          <ul class="navbar-nav ml-auto">
          	  <li>
          	  	<form action="SearchTaxi.jsp" method="post" class="mt-1 mr-4">
	              	<label>Search Taxi:</label>
	              	<input type="search" name="location"placeholder="Enter your location" required />
	              	<button class="btn btn-primary btn-sm">Search</button>
	              </form>
              </li>
              <li>
                <a class="nav-link" href="index.jsp">Home</a>
              </li>
              <li>
                <a class="nav-link" href="TaxiOwner.jsp">Taxi-Owner</a>
              </li>
              <li>
                <a class="nav-link" href="" data-toggle="modal" data-target="#adminModal">Admin</a>
              </li>
              <li>
                <a class="nav-link" href="User.jsp">User</a>
              </li>
          </ul>
          <div class="mt-3 ml-4">
              
              <p id="call"><i class="fa-solid fa-phone"></i> <span>Call us:</span> <a href="tel:9811XXXXXX">9811XXXXXX</a></p>
          </div>
        </div>
    </nav>
    <%
    }else{ String name=(String)session.getAttribute("name"); 
    %>
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
              	<a class="btn btn-sm btn-danger" href="Logout">Logout</a>
              </p>
          </div>
        </div>
    </nav>
    <%} %>
  <section>
  		<div class=" bg-light p-3">
  				<%
			  		DAO db=new DAO();
  					String location=request.getParameter("location");
			  		ArrayList<HashMap> allTaxi=db.getAllTaxiByLocation(location);
			  		db.closeConnection();
			  		for(HashMap<String,Object> taxi:allTaxi){
			  	%>
			  		<div class="bg-warning m-2 p-4 text-left">
			  			<img src="GetPhoto?id=<%= taxi.get("taxi_no") %>&user_type=driver" height="50px" />
			  			<p>
			  			Taxi No: <b><%= taxi.get("taxi_no") %></b> &nbsp;&nbsp;&nbsp;
			  			Taxi Name: <b><%= taxi.get("taxi_name") %></b> &nbsp;&nbsp;&nbsp;
			  			Seats: <b><%= taxi.get("seat") %></b> &nbsp;&nbsp;&nbsp;
			  			Taxi Type: <b><%= taxi.get("taxi_type") %></b> &nbsp;&nbsp;&nbsp;
			  			</p>
			  			<p>
			  			Fuel Type: <b><%= taxi.get("fuel_type") %></b> &nbsp;&nbsp;&nbsp;
			  			Driver Name: <b><%= taxi.get("driver_name") %></b>  &nbsp;&nbsp;&nbsp;
			  			Driver Phone: <b><%= taxi.get("phone") %></b>  &nbsp;&nbsp;&nbsp;
			  			Driver Gender: <b><%= taxi.get("gender") %></b>  &nbsp;&nbsp;&nbsp;
			  			</p>
			  			<a class="btn btn-sm btn-success" href="BookTaxi?taxi_no=<%= taxi.get("taxi_no") %>&taxi_owner_email=<%=taxi.get("taxi_owner_email")%>">Confirm Taxi</a>
			  		</div>
			  	<%		
			  		}
			  	%>
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


  <!-- Admin login modal -->
  <div class="modal fade" id="adminModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Admin Login</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <form action="AdminLogin" method="post" >
            <div class="row">
                <input name="id" class="m-2 form-control" type="text" maxlength="20" placeholder="Admin ID" required>
                <input name="password" class="m-2 form-control" type="password" maxlength="20" placeholder="Admin Password" required>
                <br/>
                <button class="col-md m-2 btn btn-primary form-control">Login</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</body>
<script>
  AOS.init();
  //script for scroll to top
  $("#top-button").click(function () {
      $("html, body").animate({scrollTop: 0}, 1000);
  });
  

</script>
</html>