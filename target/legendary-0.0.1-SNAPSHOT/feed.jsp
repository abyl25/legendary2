<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Feed</title>
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.5.0/css/all.css' integrity='sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU' 
 crossorigin='anonymous'>
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
<%@ page import="models.PostLike" %>
<%@ page import="database.DbConnection" %>

<!--  
Date date = rs.getDate("time");
DateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
String dateStr = df.format(date);
p.time = dateStr;
--> 

<%-- 
if(session.getAttribute("user") == null) {
	response.sendRedirect("index.jsp");	
	return;
}

User user = (User) session.getAttribute("user");
Connection conn = null;
ArrayList<Post> lst = null;
ArrayList<PostLike> like_list = null;

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
		df.setTimeZone(TimeZone.getTimeZone("UTC")); // set time zone
		String dateStr = df.format(date);
		p.time = dateStr;
		
		// out.println("title: " + rs.getString("title"));
		// out.println("author: " + rs.getString("first_name"));
		lst.add(p);
	}
	
	String query2 = "SELECT * FROM post_likes";
	PreparedStatement prepStatement2 = conn.prepareStatement(query2);
	ResultSet rs2 = prepStatement.executeQuery(query2);
	like_list = new ArrayList<PostLike>();
	
	while (rs2.next()) {
		PostLike pl = new PostLike();
		pl.like_id = rs2.getInt("id");
		pl.post_id = rs2.getInt("post_id");
		pl.post_author_id = rs2.getInt("post_author_id");
		pl.like_author_id = rs2.getInt("like_author_id");		
		like_list.add(pl);
	}
	
	//request.setAttribute("lst", lst);
	
}catch(SQLException e) {
	System.out.println(e);
} catch(ClassNotFoundException e) {
	System.out.println(e);
}

--%>
<%--
<c:forEach items="${posts_lst}" var="item">
       <li>Title: ${item.title}</li>		
</c:forEach>
--%>
		
	<div class="container py-3">
		<h4 id="post-header">Post</h4>
		<div>
			<a href="#top"></a>
			<input class="form-control w-50" id="post-title" type="text" name="post-title" placeholder="Enter title" required>
			<textarea class="form-control w-75 mt-2" id="post-body" type="text" placeholder="Type here..." name="post-body"  required></textarea>
			<input class="btn btn-primary btn-md mt-3" id="post-btn" type="submit" value="Post">
			<input class="btn btn-primary btn-md mt-3 ml-2" id="post-edit-btn" type="button" value="Edit">
		</div> 
	</div>
	<div id="search-result-container" class="container py-3">
		<ul id="search-result" class="list-group">
			<h3>Feed</h3>		
							
		</ul>
	</div>
	
	
	<script type="text/javascript">
	$(document).ready(function (){
		$("#post-edit-btn").hide();		
		items = [];
		posts = [];
		getAllPosts();
		getAllComments();			
		
		function getAllPosts() {
			$.ajax({
				type: 'GET',
				url: 'api/posts/getAll',
				success : function(res) {
					posts = JSON.parse(res);
					console.log(posts);
					posts.forEach(function(p) {
						$("#search-result").append("<li class='list-group-item w-75 li-post' section-id='"+ p.id +"'>" +
							"<p post-title='" + p.id + "'>" + p.title + " by <a href='#' class='text-primary'>" + p.fname +" "+ p.lname + "</a>"+ 
							" at <span class='text-primary' style=''>" + p.time + "</span><hr></p>" +
							"<p post-body='" + p.id + "'>" + p.body + "</p><br>" +
							"<button type='button' class='btn btn-info like-post' post-id='" + p.id + "'" +
								"user-id='" + p.user_id + "' like-author-id='" + "'" +
								"<i class='fas fa-heart' style='font-size:15px'></i> " +
							"</button>" +
							"<span class='like-count' post-id='"+ p.id +"' user-id='"+ p.user_id +"'>" +
							"0</span>" +
							"<button type='button' class='btn btn-success ml-1 comment-post' id='comment-post'>comment</button>" +					
							
							"<input type='button' class='btn btn-danger mx-2 delete-post' value='delete' data-id='"+ p.id +"'>" +
							"<input type='button' class='btn btn-warning edit-post' value='edit' data-id='"+ p.id +"'>" +
							
							"<br><div class='comment mt-2'> <p>Comment post</p>" +
							"<input type='text' class='form-control comment-text' post-id='" + p.id + "' placeholder='Write a comment'>" +
							"<input type='button' class='btn mt-2 comment-btn' value='comment' post-id='" + p.id + "'>" +
							"</div><hr>" +
							
							"<ul id='show-comments-ul' class='list-group'></ul>" +					
						"</li><br>");
					});
				}
			});
		}
		
		function getAllComments() {
			$.ajax({
				type: 'GET',
				url: 'api/comments/getAll',
				success : function(res) {
					//console.log("all comments:", res);
					items = JSON.parse(res);
					console.log(items);
					//showAllComments();				
				}
			});
		}
		
		showAllComments();
		function showAllComments() {
			items.forEach(function(e) {
				//console.log(e);
				let post_id = e.post_id;
				console.log('post_id:', post_id);
				let w = $("li[section-id='" + post_id + "']").find("#show-comments-ul");
				console.log('ul el:', w);
				
				$("li[section-id='" + post_id + "']").find("#show-comments-ul").append("<li class='list-group-item'>AAA" + 						
				"</li>");
			});
		}
		
		// Add comment on post
		$('#search-result').on('click', 'input.comment-btn', function(event) {
			let target = event.target;			
			//console.log("clicked:", target);
			
			let post_id = $(target).attr('post-id');
			let commenter_id = $(target).attr('user-id');
			let comment_text = $(target).prev('input').val();
			
			console.log("target post id:", post_id);
			console.log("target commenter id:", commenter_id);
			console.log("target input text:", comment_text);
						
			if (comment_text.length == 0) {
				alert("Empty text!");
				return false;
			} 
			
			comment = {};			
			comment.post_id = post_id;
			comment.commenter_id = commenter_id;
			comment.comment = comment_text;
			
			$.ajax({
				type: 'POST',
				url: 'api/comments/add',
				dataType: 'json',
				data: JSON.stringify(comment),
				success : function(res) {
					//location.reload();
					console.log("res:", res);				
				}
			});
		});
		
		// Like Post
		$('.like-post').on('click', function(e) {
			let post_id = $(this).attr('post-id').trim();
			let post_author_id = $(this).attr('user-id').trim();
			let like_author_id = $(this).attr('like-author-id').trim();
			
			console.log("post id: ", post_id);
			console.log("post author id: ", post_author_id);
			console.log("like auhtor id: ", like_author_id);
			
			post_obj = {};
			post_obj.post_id = post_id;
			post_obj.post_author_id = post_author_id;
			post_obj.like_author_id = like_author_id;
			
			$.ajax({
				type: 'POST',
				url: 'api/posts/like',
				dataType: 'json',
				data: JSON.stringify(post_obj),
				success : function(res) {
					//location.reload();
					$("span[post-id='" + post_id + "']").text("1");
					
				}
			});
		});		
		
		// Edit Post
		$('#search-result').on('click', '.edit-post', function(e) {
			let post_id = $('.edit-post').attr('data-id');
			let full_title = $("p[post-title='" + post_id + "']").text();
			let title = full_title.split("by")[0].trim();			
			let body = $("p[post-body='" + post_id + "']").text().trim();
			
			console.log("title: ", title);
			console.log("body: ", body);
			
			// scroll to top
			window.scrollTo(0, 0);
			$("#post-title").val(title);
			$("#post-body").val(body);
			$("input:text:visible:first").focus();			
						
			$("#post-edit-btn").show();
			$("#post-btn").hide();
			$("#post-header").text("Edit Post");
			
			$("#post-edit-btn").attr('post-id', post_id);
			
		});
		
		// Submit edited post 
		$('#search-result').on('click', '#post-edit-btn', function(e) {
			var postTitle = $('#post-title').val();
			var postBody = $('#post-body').val();
			var postId = $(this).attr('post-id').trim();
			console.log("post id: ", postId);
			//console.log(typeof postId);			
			
			if (postTitle.length == 0) {
				alert("Enter title of post!");
				return false;
			}
			if (postBody.length == 0) {
				alert("Enter body of post!");
				return false;
			}
						
			var post_obj = {};
			post_obj.id = postId;
			post_obj.title = postTitle;
			post_obj.body = postBody;
					
			$("#post-title").val('');
			$("#post-body").val('');			
			$("#post-btn").show();
			$(this).hide();			
			$(this).removeAttr('post-id');
			$("#post-header").text("Post");
			
			$.ajax({
				type: 'POST',
				url: 'api/posts/edit',
				dataType: 'json',
				data: JSON.stringify(post_obj),
				success : function(res) {
					location.reload();
				}
			});
			
		});
						
		// DELETE POST
		$('#search-result').on('click', '.delete-post', function(e) {
			var postid = $(this).attr('data-id');
			console.log("id: ", postid);
			//console.log(typeof postid);
			
			$.ajax({
				type: 'POST',
				url: 'api/posts/delete',
				dataType: 'json',
				data: postid,
				success : function(res) {
					//location.reload();
					// window.location.reload(true);
					window.location.href = window.location.href;
					//history.go(0);
				}			
			});
			
		});
		
		// POST FEED
		$('#post-btn').on('click', function(e) {			
			var postTitle = $('#post-title').val();
			var postBody = $('#post-body').val();	
			
			if (postTitle.length == 0 && postBody.length == 0) {
				alert("Enter title and body of post!");
				return false;
			}
			if (postTitle.length == 0) {
				alert("Enter title of post!");
				return false;
			}
			if (postBody.length == 0) {
				alert("Enter body of post!");
				return false;
			}
			
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
					//location.reload();
					window.location.reload(true);
				}
			});
		});
				
	});
	</script>
	
</body>
</html>