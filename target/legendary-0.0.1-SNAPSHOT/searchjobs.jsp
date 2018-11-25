<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Legendary</title>

<!--
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script> 
 <script src="js/jquery-3.3.1.min"></script>  -->
<!-- 
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> 
 -->
 
<!-- 
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
-->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.js"></script>	
<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.js.map"></script>
-->
</head>
<body>
	<jsp:include page="header.jsp"/>
	<%@ page import="java.util.*" %>
	<%-- 
	<%@ page import="Vacancy"%> 
	<%@	page import="Search" %>
	--%>
	
<% 
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

if(session.getAttribute("user") == null) {
	response.sendRedirect("index.jsp");	
	return;
}
%>

	<div class="container py-3">
		<h4>Search jobs</h4>
		<div>
			<input class="form-control w-75" type="text" placeholder="Type here" name="searchText" id="search-text">
			<input class="btn btn-md mt-3" id="search-job-btn" type="submit" value="Search">
			<a class="btn btn-md mt-3" href="addjob.jsp">Add Vacancy</a>
		</div> 
		
		<!--
		<div id="search-job">
			<h4>Search jobs</h4>
			<input class="form-control w-75" type="text" placeholder="Type here" name="search-text" id="search-text">
			<input class="btn btn-md mt-3" id="search-job-btn" type="submit" value="Search">
		</div>	
		-->
		
		<%-- 
		<c:set var="vacancies" value="${vacancy_list}"/>
		<c:out value = "${salary}"/>
				
		<c:set var="vlist" value="${vacancy_list}"/>
		<c:set var="vlist_size" value="${v_size}"/>	
		<c:if test = "${vlist_size > 0}">
			<c:out value="dsadasdasd"/>
			<c:forEach var="vacancy" items="${vacancy_list}">
	         	<p>Item: ${vacancy.title}/></p>
	      	</c:forEach>
		</c:if>
      	--%>
      	
      	<%--
      	      		if (request.getAttribute("vacancy_list") != null) {
      	      		    	out.println("Hello");
      	      	      		List<Vacancy> ls = (List<Vacancy>)request.getAttribute("vacancy_list");
      	      	      	    for (Vacancy v: ls) {
      	      	--%>
      			<!-- <h4>Title: </h4>  -->
      		<%-- <%= v.title %>}
      	}
      	--%>      	
		
	</div>
	
	<div id="search-result-container" class="container py-3">
		<ul id="search-result" class="list-group"></ul>
	</div>
	
	<script type="text/javascript">
	$(document).ready(function (){
		
		function updateList() {
	        $("#search-result").html("");	        	    		        
	    }
		
		items = [];
		$('#search-job-btn').on('click', function(e) {
			updateList();
			var searchText = $('#search-text').val();
			console.log('entered job name(js): ' + searchText);
			 
			$.ajax({
				type: 'GET',
				url: 'api/jobs/' + searchText,
				dataType: 'json',
				success : function(res) {
					console.log("Fetched data: ");
					console.log(res);
					items = res;
					sessionStorage.setItem("jobs_list", JSON.stringify(res));
										
					//var users_arr = JSON.parse(sessionStorage.getItem("jobs_list"));
					items.forEach(function(e) {
						$("#search-result").append("<li class='list-group-item w-75 li-click'>Title: <a href='#' class='a-click'>"+ 
								e.title+"</a>&nbsp;&nbsp;&nbsp; Category: <a href='#' class=''>" + 
								e.vacancy_type +"</a> &nbsp;&nbsp;&nbsp; Company: <a href='#'>"+ e.company_name + "</a>"+
							"<hr><p>Description</p>"+
							"<p class='pt-1 mt-1'>"+ e.description+"</p> Address: " + e.address + "</li>");
					});	
				}
			});
	
		});
		
		items.forEach(function(e) {
			$("#search-result").append("<li class='list-group-item w-75 li-click'>Title: <a href='#' class='a-click'>"+ 
					e.title+"</a>&nbsp;&nbsp;&nbsp; Category: <a href='#' class=''>" + 
					e.vacancy_type +"</a> &nbsp;&nbsp;&nbsp; Company: <a href='#'>"+ e.company_name + "</a>"+
				"<hr><p>Description</p>"+
				"<p class='pt-1 mt-1'>"+ e.description+"</p> Address: " + e.address + "</li>");
		});	
		
		/*
		if (sessionStorage.getItem("jobs_list")) {
			var users_arr = JSON.parse(sessionStorage.getItem("jobs_list"));
			users_arr.forEach(function(e) {
				$("#search-result").append(
					"<li class='list-group-item w-75 li-click'>Title: <a class='a-click' href='#' id='user-profile' data-id='"+ 
					e.id +"'>"+ e.title + "</a>&nbsp;&nbsp;&nbsp; Category: <a href='#' class=''>" + 
					e.vacancy_type +"</a> &nbsp;&nbsp;&nbsp; Company: <a href='#'>"+ e.company_name + "</a>"+
					"<hr><p>Description</p><p class='pt-1 mt-1'>"+ 
					e.description +"</p> Address: " + e.address + "</li>"
				);
			});		
		}
		*/
	});
	</script>
	<!--  -->		
</body>
</html>