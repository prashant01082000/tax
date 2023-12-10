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
        <a href="index.jsp" class="c-logo">
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
                <a class="nav-link" href="index.jsp">Home</a>
              </li>
              <li>
                <a class="nav-link" href="TaxiOwner.jsp">Taxi-Owner</a>
              </li>
              <li>
                <a class="nav-link" href="" data-toggle="modal" data-target="#adminModal">Admin</a>
              </li>
          </ul>
          <div>
              <p id="call"><i class="fa-solid fa-phone"></i> <span>Call us:</span> <a href="tel:9811XXXXXX">9811XXXXXX</a></p>
          </div>
        </div>
    </nav>
  <section>
  	<div class="row">
  		<div class="col-sm">
  			<div class="bg-light p-3">
  				<h5 class="text-center">Taxi Owner Login</h5>
  				<form action="TaxiOwnerLogin" method="post" >
		            <div class="row p-5">
		                <input name="email" class="m-2 form-control" type="email" placeholder="Email ID" required>
		                <input name="password" class="m-2 form-control" type="password" maxlength="20" placeholder="Password" required>
		                <br/>
		                <button class="col-md m-2 btn btn-primary form-control">Login</button>
		            </div>
	          	</form>
  			</div>
  		</div>
  		<div class="col-sm">
  			<div class="bg-secondary p-3">
  				<h5 class="text-center text-white">Taxi Owner Registration</h5>
  				<form action="TaxiOwnerRegister" method="post" enctype="multipart/form-data">
		            <div class="row p-5">
		                <input name="email" class="m-2 form-control" type="email" placeholder="Email ID" required>
		                <input name="name" class="m-2 form-control" type="text" maxlength="50" pattern="[a-zA-Z ]+" placeholder="Name" required>
		                <input name="phone" class="m-2 form-control" type="tel" maxlength="10" minlength="10" pattern="[0-9]+"  placeholder="Phone" required>
		                <input name="company_name" class="m-2 form-control" type="text" maxlength="50" placeholder="Company Name(if any)" >
		                <input name="company_reg_no" class="m-2 form-control" type="text" maxlength="50" placeholder="Company Registration No.(if any)" >
		                <textarea rows="3" name="address" class="m-2 form-control" placeholder="Company Address or Your Address" required></textarea>
		                <label class="text-white ml-2">Upload Your Photo:</label>
		                <input name="photo" class="m-2 form-control" type="file" required>
		                <input name="password" class="m-2 form-control" type="password" maxlength="20" placeholder="Password" required>
		                <br/>
		                <button class="col-md m-2 btn btn-dark form-control">Registartion</button>
		            </div>
	          	</form>
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
  //script for light box
  $(document).on('click', '[data-toggle="lightbox"]', function(event) {
      event.preventDefault();
      $(this).ekkoLightbox();
  });

</script>
</html>