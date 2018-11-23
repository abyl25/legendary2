<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Feed</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="com.mysql.cj.jdbc.Driver" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="models.User" %>
<%@ page import="models.Profile" %>
<%@ page import="models.Post" %>
<%@ page import="database.DbConnection" %>

<!--  
Date date = rs.getDate("time");
DateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
String dateStr = df.format(date);
p.time = dateStr;
--> 
<% 
if(session.getAttribute("user") == null) {
	response.sendRedirect("index.jsp");	
}

Connection conn = null;
ArrayList<Post> lst = null;

try {		 		
	Class.forName("com.mysql.jdbc.Driver");
   	conn = DbConnection.getConnection();
	
	if (conn == null) {
		out.println("CONNECTION IS NULL!!!");
	}
	
	String query = "SELECT posts.id, posts.user_id, posts.title, posts.body, posts.time, users.first_name, users.last_name "
			+ "FROM posts INNER JOIN users ON posts.user_id=users.id ORDER BY time DESC"; 
	//String query2 = "SELECT * FROM posts";
	
	PreparedStatement prepStatement = conn.prepareStatement(query);
	ResultSet rs = prepStatement.executeQuery(query);
	lst = new ArrayList<Post>();

	while (rs.next()) {
		Post p = new Post();
		p.id = rs.getInt("id");
		p.user_id = rs.getInt("user_id");
		p.title = rs.getString("title");
		p.body = rs.getString("body");
		p.fname = rs.getString("first_name");
		p.lname = rs.getString("last_name");
		
		// p.time = rs.getDate("time");
		Date date = rs.getTimestamp("time");
		DateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		String dateStr = df.format(date);
		p.time = dateStr;
		
		// out.println("title: " + rs.getString("title"));
		// out.println("author: " + rs.getString("first_name"));
		lst.add(p);
	}
	
	request.setAttribute("lst", lst);
	
}catch(SQLException e) {
	System.out.println(e);
} catch(ClassNotFoundException e) {
	System.out.println(e);
}

%>
<%--
<c:forEach items="${posts_lst}" var="item">
       <li>Title: ${item.title}</li>		
</c:forEach>
--%>
		
	<div class="container py-3">
		<h4>Post</h4>
		<div>
			<input class="form-control w-50" id="post-title" type="text" name="post-title" placeholder="Enter title">
			<textarea class="form-control w-75 mt-2" type="text" placeholder="Type here..." name="post-body" id="post-body"></textarea>
			<input class="btn btn-primary btn-md mt-3" id="post-btn" type="submit" value="Post">
		</div> 
	</div>
	<div id="search-result-container" class="container py-3">
		<ul id="search-result" class="list-group">
			<h3>Feed</h3>		
			<%for (Post p: lst){ %>
				<li class='list-group-item w-75'>
					<p><% out.println("<span class='text-dark'>" + p.title + "</span> by <a href='#' class='text-primary'>" + p.fname + " " + p.lname + "</a>" + 
					" at <span class='text-primary' style=''>" + p.time +"</span>"); %></p>
					<p><% out.println(p.body); %></p>
					
				</li>
			<%} %>	
			
		</ul>

	</div>
	
	
	<script type="text/javascript">
	$(document).ready(function (){
		
		$('#post-btn').on('click', function(e) {
			var postTitle = $('#post-title').val();
			var postBody = $('#post-body').val();
			console.log('post title(js): ' + postTitle);
			
			var post = {};
			post.title = postTitle;
			post.body = postBody;					
			console.log('post obj: ', post);
			
			$.ajax({
				type: 'POST',
				url: 'api/posts/add',
				dataType: 'json',
				data: JSON.stringify(post),
				success : function(res) {
					console.log('res:');
					console.log(res);
					location.reload();
				}
			});
		});
	});
	</script>
	
</body>
</html>