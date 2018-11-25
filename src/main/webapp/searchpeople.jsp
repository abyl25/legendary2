<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
	a {
		text-decoration: none;
		padding: 1px;
	}
</style>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<%@ page import="java.util.*" %>
	
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
		<h4>Search People</h4>	
		<div>
			<input class="form-control w-75" type="text" placeholder="Type here" name="searchPeopleText" id="searchPeopleText">
			<input class="btn btn-md mt-3" id="search-people-btn" type="submit" value="Search">
		</div>
				
	</div>
	
	<div id="search-result-container" class="container py-3">
		<ul id="search-result" class="list-group"></ul>		
	</div>
		
	<%  String home = request.getContextPath() + "/"; %>
		
	<script type="text/javascript">	
	
	$(document).ready(function (){
		items = [];
		
		$('#search-people-btn').on('click', function(e) {
			// e.preventDefault();
			updateList();
			var searchText = $('#searchPeopleText').val();
			console.log('entered name(js): ' + searchText);
			 
			$.ajax({
				type: 'GET',
				url: 'api/users/' + searchText,
				dataType: 'json',
				success : function(res) {
					console.log("Fetched data: ");
					console.log(res);
					
					items = res;
					//sessionStorage.setItem("users_list", JSON.stringify(res));
										
					//var users_arr = JSON.parse(sessionStorage.getItem("users_list"));
					items.forEach(function(e) {
						$("#search-result").append("<li class='list-group-item w-75 li-click'><a href='userprofile.jsp?id="+ e.id +
							"' class='a-click' data-id='" + e.id + "'>" + 
							e.fname + " " + e.lname + "</a>" + "<p class='pt-1 mt-1'>" + e.email + "</p></li>");
					});	
				}
			});
	
		});
		
		function updateList() {
	        $("#search-result").html("");	        	    		        
	    }
		
		items.forEach(function(e) {
			$("#search-result").append(
				"<li class='list-group-item w-75 li-click'><a href='userprofile.jsp?id=" + e.id +
					"' class='a-click' id='user-profile' data-id='" + e.id +"'>" + 
					e.fname +" "+ e.lname +"</a>"+ "<p class='pt-1 mt-1'>"+ e.email +"</p></li>"
			);
		});	
		
		/*
		if (sessionStorage.getItem("users_list")) {
			var users_arr = JSON.parse(sessionStorage.getItem("users_list"));
			users_arr.forEach(function(e) {
				$("#search-result").append(
					"<li class='list-group-item w-75 li-click'><a class='a-click' href='#' id='user-profile' data-id='"+ 
					e.id +"'>"+ e.fname+" "+e.lname +"</a>"+ "<p class='pt-1 mt-1'>"+ e.email+"</p></li>"
				);
			});		
		} */
		
		<%-- =home--%>
		// "api/users/" + e.id + "
		
		// $('.li-click').on // '#user-profile'
		
		/*
		$(".a-click").mouseover(function(){
			$("a").attr("href", "http://www.google.com/")
		});
		
		$('.a-click').on('click', function(e) {
			//e.preventDefault();
			//console.log(e.target.id);
			//console.log(e.target.attr('data-id'));
			//return false;
			
			var user_profile_id = $(this).attr('data-id');
			console.log('you clicked user with id: ');
			console.log(user_profile_id);
			//console.log('api/users/' + user_profile_id);
			
			var user_prof_json = '';
			$.ajax({
				type: 'GET',
				url: 'api/users/' + user_profile_id,
				dataType: 'json',
				success : function(res) {
					user_prof_json = JSON.stringify(res);
					console.log('user profile json data: ');
					console.log(user_prof_json);
					//console.log(typeof user_prof_json);
				}
			}); 
			
			
			
			//window.location.href = '' + 'userprofile.jsp?id=' + user_profile_id;
		    //return false;
			
			
		});  */ 
		/**/
		
		 <%-- =home""  '<%= home %>'  --%>
	}); // ready function
	</script>
	
</body>
</html>