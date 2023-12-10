<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.incapp.modal.DAO"%>
<%
	String adminName=(String)session.getAttribute("adminName");
	if(adminName==null){
		session.setAttribute("msg", "Please Login!");
		response.sendRedirect("index.jsp");
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
        <a href="AdminHome.jsp" class="c-logo">
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
                <a class="nav-link" href="AdminHome.jsp">Home</a>
              </li>
              <li>
                <a class="nav-link" href="AdminTaxiOwner.jsp">TaxiOwner</a>
              </li>
          </ul>
          <div>
              <p> 
              	Welcome: <b><%= adminName %></b>
              	<a class="btn btn-sm btn-danger" href="Logout">Logout</a>
              </p>
          </div>
        </div>
    </nav>
  <section>
  	<h4 class="bg-dark text-white text-center p-3">TaxiOwner Details</h4>
  	<%
  		
  		DAO db=new DAO();
  		String email=request.getParameter("email");
  		HashMap<String,String> taxiOwner=db.getTaxiOwnerByEmail(email);
  		if(taxiOwner!=null){
  	%>
  		<div class="row">
  			<div class="col-sm">
  				<div class="bg-light m-2 p-4">
  					<img src="GetPhoto?id=<%= taxiOwner.get("email") %>&user_type=taxi_owner" height="50px" />
		  			<p>
		  			Name: <b><%= taxiOwner.get("name") %></b> &nbsp;&nbsp;&nbsp;
		  			Phone: <b><%= taxiOwner.get("phone") %></b>  &nbsp;&nbsp;&nbsp;
		  			Email: <b><%= taxiOwner.get("email") %></b> <br/>
		  			Status: <b><%= taxiOwner.get("status") %></b> 
		  			<%
		  				String status=taxiOwner.get("status");
		  				if(status.equalsIgnoreCase("Pending")){
		  			%>
		  				<a class="btn btn-sm btn-success" href="ChangeTaxiOwnerStatus?email=<%= taxiOwner.get("email") %>&status=Accepted">Accept</a>
		  				<a class="btn btn-sm btn-danger" href="ChangeTaxiOwnerStatus?email=<%= taxiOwner.get("email") %>&status=Rejected">Reject</a>
		  			<%		
		  				}else if(status.equalsIgnoreCase("Accepted")){
	  				%>
		  				<a class="btn btn-sm btn-danger" href="ChangeTaxiOwnerStatus?email=<%= taxiOwner.get("email") %>&status=Rejected">Reject</a>
		  			<%		
		  				}else{
	  				%>
		  				<a class="btn btn-sm btn-success" href="ChangeTaxiOwnerStatus?email=<%= taxiOwner.get("email") %>&status=Accepted">Accept</a>
		  			<%		
		  				}
		  			%>
		  			</p>
		  		</div>
  			</div>
  			<div class="col-sm">
  				<div class="bg-light m-2 p-4">
		  			<p>
		  			Company Name: <b><%= taxiOwner.get("company_name") %></b> &nbsp;&nbsp;&nbsp;
		  			Registration No.: <b><%= taxiOwner.get("company_reg_no") %></b>  <br/>
		  			Address: <b><%= taxiOwner.get("address") %></b> 
		  			</p>
		  		</div>
  			</div>
  		</div>
  		<div class=" bg-light p-3">
  				<%
  					ArrayList<HashMap> allTaxi=db.getAllTaxiByOwnerEmail(email);
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
			  			<% String taxiStatus=(String)taxi.get("status"); %>
			  			Status: <b><%= taxiStatus %></b> 
			  			</p>
			  			<p>
			  			<%
			  				if(taxiStatus.equalsIgnoreCase("activate")){
			  			%>
			  					<a class="btn btn-sm btn-secondary" href="ChangeTaxiStatus?taxi_no=<%=taxi.get("taxi_no")%>&status=Deactivate&request_page=AdminTaxiOwner">Deactivate</a>
			  				<% 
			  					}
			  					if(taxiStatus.equalsIgnoreCase("pending")){
						  	%>
			  					<a class="btn btn-sm btn-success" href="ChangeTaxiStatus?taxi_no=<%=taxi.get("taxi_no")%>&status=Activate&request_page=AdminTaxiOwner">Activate</a>
			  					<a class="btn btn-sm btn-danger" href="ChangeTaxiStatus?taxi_no=<%=taxi.get("taxi_no")%>&status=Reject&request_page=AdminTaxiOwner">Rejected</a>
			  				<% 
			  					}
			  				
			  				%>
			  			</p>
			  		</div>
			  	<%		
			  		}
			  	%>
  			</div>
  	<%		
  		}else{
  	%>
  		<div class="bg-light m-2 p-4">
  			<p>
  				Taxi Owner does not exist.
  			</p>
  		</div>
  	<%			
  		}
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