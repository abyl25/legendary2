<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Legendary</title>
	<!--<link rel="stylesheet" type="text/css" href="footer.css">  -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<style>
	</style>
</head>
<body>
<%@ page import="models.User" %>
	<%  String home = request.getContextPath() + "/";
		String fname = "";
		if (session.getAttribute("user") != null) {
			User user = (User)session.getAttribute("user");
			fname = user.fname;
		} 
		
	%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	 	<a href="<%=home%>" class="navbar-brand">Legendary</a>

	  	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  	</button>
		<div class="collapse navbar-collapse col-6" id="navbarNavAltMarkup">
			<div class="navbar-nav">				
			  	<a class="nav-item nav-link active mr-3" href="profile.jsp">My Profile <span class="sr-only">(current)</span></a>	
			  	<a class="nav-item nav-link text-light mr-2" href="feed.jsp">Feed</a>		  	
			  	<a class="nav-item nav-link text-light mr-2" href="<%=home + "searchjobs.jsp"%>">Jobs</a>
			  	<a class="nav-item nav-link text-white" href="<%=home + "searchpeople.jsp"%>">People</a>
			</div>			
		</div>
		
		<c:set var="fname" value="${fname}"/>	
		<c:if test = "${!fname.isEmpty()}">	
			<span class="text-white ml-auto mr-2"><%="Hi, " + fname %></span>	
			<form action="logout" method="post" class="">
			    <input type="submit" value="Log out" class="btn btn-light float-right" id="logout-btn">
			</form>		
		</c:if>
	</nav>
	
</body>
</html>