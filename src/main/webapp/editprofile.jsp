<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Legendary</title>
	 
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">  
	<!--  
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	-->
</head>

<body>

<% 
String home = request.getContextPath() + "/";
String fname = "";
if(session.getAttribute("user") == null) {
	response.sendRedirect("index.jsp");	
} else {
	fname = (String)session.getAttribute("first_name");
}		
%>

<jsp:include page="header.jsp"/>

	<div class="container-fluid bg-light py-3">
		<div class="row pt-4">
			<div class="col-md-6 mx-auto">
				<div class="card card-body">	
					<h3 class="text-center my-3 pb-3">Edit profile</h3>
					<!--  <h3 class="card-title">Card title</h3> -->
					
					<form action="editprofile" method="post">
						<div class="form-group">	
							<input class="form-control" type="text" name="profile-age" placeholder="Age">			
						</div>						
						<div class="form-group"> 
							<input class="form-control" type="text" name="profile-education" placeholder="Education">			
						</div>
						<div class="form-group">
							<input class="form-control" type="text" name="profile-major" placeholder="Major">			
						</div>
						<div class="form-group">	
							<input class="form-control" type="text" name="profile-profession" placeholder="Profession">			
						</div>
						<div class="form-group">	
							<input class="form-control" type="text" name="profile-experience" placeholder="Experience">			
						</div>
						<div class="form-group">
							<input class="form-control" type="text" name="profile-skills" placeholder="Skills">			
						</div>
						
						<!-- 
						<div class="form-group">
							<input class="form-control" type="text" name="profile-experience" placeholder="Experience">			
						</div>
						<div class="form-group">
							<input class="form-control" type="text" name="profile-salary" placeholder="Salary">			
						</div>  
						<div class="form-group">
							<input class="form-control" type="text" name="profile-availability" placeholder="Availability">			
						</div> 
						<div class="form-group">
							<input class="form-control" type="text" name="profile-phone" placeholder="Phone">			
						</div> -->
						
						<div class="form-group">
							<input class="form-control" type="text" name="profile-links" placeholder="Links">			
						</div>
						<div class="form-group">
							<textarea class="form-control" name="profile-bio" placeholder="Bio Description"></textarea>			
						</div>
						
						<input class="btn btn btn-success btn-block" type="submit" name="profile-edit" value="Edit">
												
					</form>
				</div>
			</div>
		</div>
		<br><br><br><br><br><br><br>
	</div>
	<br>
	

</body>
</html>