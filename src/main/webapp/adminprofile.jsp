<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page import="java.util.List, java.util.Map, java.util.ArrayList" %>

<% 
	List<Map<String, String>> user_list = new ArrayList<Map<String, String>>();
%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Table V01</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->

<style>
	.centerit {
		text-align: center;
	}
	
	.down {
	    position: absolute;
	    top: 200px important!;
	    border: 3px solid green;
	}
	
	.text-white-important {
		color: white !important;
	}
	
</style>

</head>
<body>

	<%  
		String home = request.getContextPath() + "/";
		String fname = "";
		if (session.getAttribute("adname") != null) {
			fname = (String)session.getAttribute("adname");
		}
	%>
	
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	 	<a href="<%=home%>" class="navbar-brand">NU Legendary</a>

	  	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  	</button>
		<div class="collapse navbar-collapse col-6" id="navbarNavAltMarkup">
			<div class="navbar-nav">				
			  	<a class="nav-item nav-link active" href="<%=home%>">Home <span class="sr-only">(current)</span></a>			  	
			  <!-- <a class="nav-item nav-link" href="#">Features</a> -->
			  <!-- <a class="nav-item nav-link" href="#">Pricing</a> -->
			</div>			
		</div>
		<div class="text-white ml-auto">
			<%="Hi, " + fname %> &emsp;&emsp; 
			<a href="/jdbcexercise/adlout" class="text-white-important">Log Out</a>
		</div>

	</nav>
	
	<div class="limiter down">
		<div class="container-table100">
			<div class="wrap-table100">
				<div class="table100">
					<table id="users_table">
						<thead>
							<tr class="table100-head">
								<th class="column1 centerit">First Name</th>
								<th class="column2 centerit">Last Name</th>
								<th class="column3 centerit">Email</th>
								<th class="column4 centerit">User Id</th>
								<th class="column5 centerit" >Last Access</th>
								<th class="column5 centerit" >Delete</th>
							</tr>
						</thead>
						<tbody>
								<c:forEach items="${user_list}" var="element"> 
								  	<tr id="${element.user_id}_row">
								  		<td class="column1 centerit"> ${element.first_name} </td>
										<td class="column2 centerit"> ${element.last_name} </td>
										<td class="column3 centerit"> ${element.user_email} </td>
										<td class="column3 centerit"> ${element.last_access} </td>
										<th class="column4 centerit"> ${element.user_id} </th>
								   		<th class="column5 centerit"> 
								   			<button id="${element.user_id}" 
								   				onClick="deleteUsers(this.id)"> X delete </button>
								   		</th>
								   	</tr>
								</c:forEach>
						</tbody>
						
						<tbody>
						  	<tr id="lastb_row">
						  		<td class="column1 centerit"> AAA </td>
								<td class="column2 centerit"> BBB </td>
								<td class="column3 centerit"> CCC </td>
								<td class="column3 centerit"> DDD </td>
								<th class="column4 centerit"> EEE </th>
						   		<th class="column5 centerit"> 
						   			<button id="lastb" 
						   				onClick="deleteUsers(this.id)"> X delete </button>
						   		</th>
						   	</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script>
		function deleteUsers(id) {
			$("#"+id+"_row").remove();
			
			alert(id);
			
			$.ajax({
	            type: "GET",
	            url: "api/admin/delete?id="+ id,
	            contentType: 'application/json',
	            	
	            success : function (data, textStatus, error) {
		            alert("SUCCESS: " + textStatus);
		        },
		        error : function (data, textStatus, error) {
		            alert("ERROR: " + error	);
		        }
	        });
			
			alert("Done");
		}
	</script>
	

<!--===============================================================================================-->	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>