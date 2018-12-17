package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.mysql.cj.api.jdbc.Statement;

import models.PostComment;
import models.User;
import models.Vacancy;
import database.DbConnection;
import utils.AddCommentRequest;

@Path("/comments")
public class CommentService {
	@Context
    private HttpServletRequest request;
	
	Connection conn = null;
	public CommentService() {
    	conn = DbConnection.getConnection();
    }
	
	@GET
	@Path("/getAll")
	public Response getComment() {
		Gson gson = new Gson();  
        String json = "";
          
		try {		
			List<PostComment> comments_list = new ArrayList<PostComment>();
			String query = "SELECT * FROM post_comments"; 
			PreparedStatement prepStatement = conn.prepareStatement(query);
			ResultSet rs = prepStatement.executeQuery(query);
			while (rs.next()) {
				PostComment comment = new PostComment();
				comment.id = rs.getInt("id");
				comment.post_id = rs.getInt("post_id");
				comment.commenter_id = rs.getInt("commenter_id");
				comment.comment = rs.getString("comment");
				
				Date date = rs.getTimestamp("time_commented");
				DateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				df.setTimeZone(TimeZone.getTimeZone("UTC"));
				String dateStr = df.format(date);
				comment.time = dateStr;
				
				comments_list.add(comment);
			}	
			
			json = gson.toJson(comments_list);
			System.out.println("All comments json(CommentService): " + json);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return Response.ok(json).build();
	}
	
	@POST
	@Path("/add")
	public Response addComment(String body) {
		System.out.println("add comment req body: " + body);
		Gson gson = new Gson();
		String json = "";
		
		AddCommentRequest addCommentReq = gson.fromJson(body, AddCommentRequest.class);
		PostComment comment = new PostComment();
		User user = (User) request.getSession().getAttribute("user");
		
		try {
			String query = "INSERT INTO post_comments (post_id, commenter_id, comment, time_commented) VALUES (?, ?, ?, NOW())"; 
			PreparedStatement prepStatement = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			prepStatement.setInt(1, addCommentReq.post_id);
			prepStatement.setInt(2, addCommentReq.commenter_id);
			prepStatement.setString(3, addCommentReq.comment);						
			prepStatement.executeUpdate();
			
			int comment_id = 0;			
			try {
				ResultSet generatedKeys = prepStatement.getGeneratedKeys();
				if (generatedKeys.next()) {
					comment_id = (int)generatedKeys.getLong(1);
					System.out.println("inserted post id: " + comment_id);
	            }
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
			Date date = new Date();
			DateFormat df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			String dateStr = df.format(date);
			System.out.println("Commented date str in CommentService: " + dateStr);
						
			comment.id = comment_id;
			comment.post_id = addCommentReq.post_id;
			comment.commenter_id = addCommentReq.commenter_id;
			comment.comment = addCommentReq.comment;
			comment.time = dateStr;
			
			json = gson.toJson(comment);			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return Response.ok(json).build();
	}
}





