<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>Legendary</title>
	<link rel="stylesheet" type="text/css" href="footer.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<style>
	</style>
</head>
<body>
	
	<% String home = request.getContextPath() + "/"; %> 
	
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	 	<a href="<%=home%>" class="navbar-brand">Legendary</a>

	  	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  	</button>
		<div class="collapse navbar-collapse col-6" id="navbarNavAltMarkup">
			<div class="navbar-nav">				
			  	<a class="nav-item nav-link active" href="<%=home%>">Home <span class="sr-only">(current)</span></a>	
			  	<!--  <a class="nav-item nav-link text-white" href="<%=home + "search.jsp"%>">Search</a> -->
			  	  	
			</div>
		</div>
		<form class="form-inline my-2 my-lg-0" id="login-form" method="post" action="signin">
      		<input class="form-control mr-sm-2 pt-1 pb-1" type="text" placeholder="email" name="login-email">
      		<input class="form-control mr-sm-2 pt-1 pb-1" type="password" placeholder="password" name="login-password" autocomplete="off">
      		<button class="btn btn-outline-success my-2 my-sm-0 pt-1 pb-1" type="submit">Log in</button>
      		<!-- <a href="#" class="">Forgot password?</a> -->
    	</form>
	</nav>
	
	<% if(session.getAttribute("user") != null) response.sendRedirect("profile.jsp"); %>
	${message} 
	<c:remove var="message" scope="session" />
	
	<div class="container-fluid bg-light py-3">
	    <div class="row pt-4">
	        <div class="col-md-6 mx-auto">
                <div class="card card-body">
                    <h3 class="text-center mb-4 pb-4">Sign up form</h3>
                    <!-- <div class="alert alert-danger">
                        <a class="close font-weight-light" data-dismiss="alert" href="#">×</a>Password is too short.
                    </div> -->
                    <form id="signup-form" method="post" action="signup">                    	                    
                    <!-- <fieldset> -->
                    	<div class="form-group has-error">
                            <input class="form-control input-lg" placeholder="First Name" name="signup-fname" type="text">
                        </div>
                        <div class="form-group has-error">
                            <input class="form-control input-lg" placeholder="Last Name" name="signup-lname" type="text">
                        </div>
                        <div class="form-group has-error">
                            <input class="form-control input-lg" placeholder="E-mail" name="email" type="text">
                        </div>
                        <div class="form-group has-success">
                            <input class="form-control input-lg" placeholder="Password" name="password" value="" type="password">
                        </div>
                        <div class="form-group has-success">
                            <input class="form-control input-lg" placeholder="Confirm Password" name="password_2" value="" type="password">
                        </div>
                        <!-- <div class="form-group">
                            <select class="form-control input-lg">
                                <option selecterd="">Sequrity Question</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input class="form-control input-lg" placeholder="Sequrity Answer" name="answer" value="" type="text">
                        </div> -->
                        <div class="checkbox">
                            <label class="small">
                                <input name="terms" type="checkbox">I have read and agree to the terms of service
                            </label>
                        </div>
                        <input class="btn btn-lg btn-primary btn-block" value="Sign Up" type="submit">
                    <!-- </fieldset> -->
                    </form>
                </div>
	        </div>
	    </div>
	</div>
	<br><br><br><br>

   <!-- Footer -->

   <footer class="mainfooter" role="contentinfo">

  <div class="footer-middle">
  <div class="container">
    <div class="row">
      <div class="col-md-3 col-sm-6">
        <!--Column1-->
        <div class="footer-pad">
          <h4>Address</h4>
          <address>
			<ul class="list-unstyled">
				<li>
					Kabanbay Batyr 53<br>
					Astana<br>
					Kazakhstan<br>
				</li>
				<li>
					<!-- Phone: 0 -->
				</li>
			</ul>
		</address>
        </div>
      </div>
      <div class="col-md-3 col-sm-6">
        <!--Column1-->
        <div class="footer-pad">
          <h4>Popular Services</h4>
          <ul class="list-unstyled">
            <li><a href="#"></a></li>
            <li><a href="#">Payment Center</a></li>
            <li><a href="#">Contact Directory</a></li>
            <li><a href="#">Forms</a></li>
            <li><a href="#">News and Updates</a></li>
            <li><a href="#">FAQs</a></li>
          </ul>
        </div>
      </div>
      <div class="col-md-3 col-sm-6">
        <!--Column1-->
        <div class="footer-pad">
          <h4>Website Information</h4>
          <ul class="list-unstyled">
            <li><a href="#">Website Tutorial</a></li>
            <li><a href="#">Accessibility</a></li>
            <li><a href="#">Disclaimer</a></li>
            <li><a href="#">Privacy Policy</a></li>
            <li><a href="#">FAQs</a></li>
            <li><a href="#">Webmaster</a></li>
          </ul>
        </div>
      </div>
      <div class="col-md-3 col-sm-6">
        <!--Column1-->
        <div class="footer-pad">
          <h4>Popular Departments</h4>
          <ul class="list-unstyled">
            <li><a href="#">Parks and Recreation</a></li>
            <li><a href="#">Public Works</a></li>
            <li><a href="#">Police Department</a></li>
            <li><a href="#">Fire</a></li>
            <li><a href="#">Mayor and City Council</a></li>
            <li>
              <a href="#"></a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
  </div>
  <div class="footer-bottom">
    <div class="container">
      <div class="row">
        <div class="col-xs-12">
          <!--Footer Bottom-->
          <p class="text-xs-center">&copy; Linkedin. Copyright 2018.  All rights reserved.</p>
        </div>
      </div>
    </div>
  </div>
</footer>

</body>
</html>