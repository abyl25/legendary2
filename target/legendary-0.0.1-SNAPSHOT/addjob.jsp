<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Legendary</title>


 

</head>
<body>
	
	<% 
	String home = request.getContextPath() + "/";
	String fname = "";
	if(session.getAttribute("user") == null) {
		response.sendRedirect("index.jsp");	
	} else {
		// User user = (User)session.getAttribute("user");
		fname = (String)session.getAttribute("first_name"); // => null
	}		
	%>
	<jsp:include page="header.jsp"/>
	
	<div class="container py-3">
		<div class="col-md-12">
			<h4>Add Vacancy</h4>
		</div>
		<div>
			<form action="addjob" method="post">
				
				<div class="col-md-12">
					<div class="form-group">
					<input class="form-control w-25" type="text" placeholder="Title" name="title" id="job-title">
					</div>
				</div>
				
				<br>
				
				<div class="col-md-3">
					<div class="form-group">
					<input class="form-control w-100" type="text" placeholder="Type" name="type" id="job-type">
					</div>
				</div>
				
				<div class="col-md-3">
					<div class="form-group">
					<input class="form-control w-100" type="text" placeholder="Company name" name="company-name" id="job-company">
					</div>
				</div>
				
				<div class="col-md-3">
					<div class="form-group">
					<input class="form-control w-100" type="text" placeholder="Contacts" name="contacts" id="job-contact">
					</div>
				</div>
				
				<div class="col-md-3">
					<div class="form-group">
					<input class="form-control w-100" type="text" placeholder="Address" name="address" id="job-address">
					</div>
				</div>
				<br>
				
				<div class="col-md-12">
					<div class="form-group">
    				<textarea class="form-control" type="text" placeholder="Description" name="description" id="search-text" rows="3"></textarea>
					<!--<input class="form-control w-75" type="text" placeholder="Description" name="description" id="search-text">-->
					</div>
				</div>
				<div class="col-md-12">
					<input class="btn btn btn-success btn-block w-25" type="submit" name="add-job" value="Add">
				</div>
			</form>
		</div> 	   	
		
	</div>
	
	
	
	
	<!--  -->		
</body>
</html>