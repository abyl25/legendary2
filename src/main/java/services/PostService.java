package services;

import database.DbConnection;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import models.Post;
import models.User;
import utils.AddPostRequest;
import utils.EditPostRequest;
import utils.LikePostRequest;

import com.google.gson.Gson;
import com.mysql.cj.api.jdbc.Statement;

@Path("/posts")
public class PostService {
	@Context
    private HttpServletRequest request;
	Connection conn = null;
	
	public PostService() {
    	conn = DbConnection.getConnection();
    }
	
	@POST
	@Path("/add")
	public Response addPost(String body) {
		System.out.println("add post req body: " + body);
		Gson gson = new Gson();
		String json = "";
		
		AddPostRequest addPostReq = gson.fromJson(body, AddPostRequest.class);
		//System.out.println("apr title: " + addPostReq.title);
		//System.out.println("apr body: " + addPostReq.body);
		
		Post post = new Post();
		
		User user = (User) request.getSession().getAttribute("user");
		int user_id = user.id;
		int post_id = 0;
		
		try {
			String query = "INSERT INTO posts (user_id, title, body, time) VALUES (?, ?, ?, NOW())"; 
			PreparedStatement prepStatement = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			prepStatement.setInt(1, user_id);
			prepStatement.setString(2, addPostReq.title);
			prepStatement.setString(3, addPostReq.body);
			
			int c = prepStatement.executeUpdate();
			try {
				ResultSet generatedKeys = prepStatement.getGeneratedKeys();
				if (generatedKeys.next()) {
					post_id = (int)generatedKeys.getLong(1);
					System.out.println("inserted post id: " + post_id);
	            }
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
			Date date = new Date();
			DateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			String dateStr = df.format(date);
			System.out.println("date str in service: " + dateStr);
			
			post.id = post_id;
			post.user_id = user_id;
			post.title = addPostReq.title;
			post.body = addPostReq.body;
			post.time = dateStr;
			
			json = gson.toJson(post);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
				
		return Response.ok(json).build();
	}
	
	@POST
	@Path("/delete")
	public Response deletePost(String id) {
		System.out.println("add post req body: " + id);
		Gson gson = new Gson();
		String json = "";
						
		//int post_id = Integer.parseInt(id);
		try {
			String query = "DELETE FROM posts WHERE id='" + id + "'";
			PreparedStatement prepStatement = conn.prepareStatement(query);
			prepStatement.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return Response.ok("deleted").build();
	}
	
	@POST
	@Path("/edit")
	public Response editPost(String body) {
		System.out.println("edit post req: " + body);
		Gson gson = new Gson();
		EditPostRequest editPostReq = gson.fromJson(body, EditPostRequest.class);
		System.out.print("edit post id: " + editPostReq.id + " | ");
		//System.out.println("id type: " + editPostReq.id instanceof String);
		System.out.println("edit post title: " + editPostReq.title);
		System.out.println("edit post body: " + editPostReq.body);
				
		
//		User user = (User) request.getSession().getAttribute("user");
//		int user_id = user.id;		
//		int post_id = Integer.parseInt(editPostReq.id);
		
		try {
			String query = "UPDATE posts SET title = '" + editPostReq.title + "', body = '" + editPostReq.body + 
					"' WHERE id = " + editPostReq.id + "";
			PreparedStatement prepStatement = conn.prepareStatement(query);
			prepStatement.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return Response.ok("edited").build();
	}
	
	@POST
	@Path("/like")
	public Response likePost(String body) {
		System.out.println("like post req: " + body);
		Gson gson = new Gson();
		
		LikePostRequest lpr = gson.fromJson(body, LikePostRequest.class);
		System.out.println("lpr.post_id: " + lpr.post_id);
		System.out.println("lpr.post_author_id: " + lpr.post_author_id);
		System.out.println("lpr.like_author_id: " + lpr.like_author_id);
		
		try {
//			"INSERT INTO posts (user_id, title, body, time) VALUES (?, ?, ?, NOW())"
			String query = "INSERT INTO post_likes (post_id, post_author_id, like_author_id) VALUES (?, ?, ?)";
			
			PreparedStatement prepStatement = conn.prepareStatement(query);
			prepStatement.setInt(1, lpr.post_id);
			prepStatement.setInt(2, lpr.post_author_id);	
			prepStatement.setInt(3, lpr.like_author_id);
			prepStatement.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return Response.ok("liked").build();
	}
	
}
