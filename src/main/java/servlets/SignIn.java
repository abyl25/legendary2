package servlets;

import models.User;
import database.DbConnection;

import javax.servlet.RequestDispatcher;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.api.jdbc.Statement;

@WebServlet(urlPatterns = { "/signin" })
public class SignIn extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Connection conn = null;
    
    public SignIn() {
        super();
        conn = DbConnection.getConnection();
    }

    /* protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    } */
    
    protected void doGet (HttpServletRequest request, HttpServletResponse response)
        throws ServletException , IOException {
//        response.setContentType("text/jsp");
//        response.sendRedirect("index.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/jsp");
        PrintWriter out = response.getWriter();
        
    	String entered_email = request.getParameter("login-email");
    	String entered_password = request.getParameter("login-password");
        
    	String message = "";   
        if(entered_email.isEmpty() || entered_password.isEmpty()) {
        	message = "<div class='alert alert-danger'>Email or password is empty. Try again!<a class='close font-weight-light' data-dismiss='alert' href='#'>x</a></div>"; 
        	
            request.getSession().setAttribute("message", message);
            response.sendRedirect("index.jsp");
            return;                      
        }       
               
        if (conn != null) {
//        	out.append("Database connection established\n");
        	
        	try {
        		String users = "users";
        		DatabaseMetaData dbm = conn.getMetaData();
        		ResultSet tables = dbm.getTables(null, null, users, null);
        		
        		if (tables.next()) {
//        			out.append("Table exists in DB: " + users + "\n");
        			
	       	 		Statement statement = (Statement) conn.createStatement();
//	       	 		String query = "SELECT * FROM users WHERE email='" + email + "' AND password='" + password + "'";
//	       	 		ResultSet resultSet = statement.executeQuery(query);
	       	 		
	       	 		String query2 = "SELECT * FROM users WHERE email='" + entered_email + "'";
	       	 		ResultSet resultSet2 = statement.executeQuery(query2);		
	       	 		
		       	 	int user_id = 0;	       	 		
		       	 	String fname="";
		       	 	String lname="";
		       	 	String user_email="";
		       	 	String user_password = "";
		       	 	
			       	if (!resultSet2.isBeforeFirst() ) {    		       		
			       		message = "<div class='alert alert-danger'>Such user does not exist. Try again!<a class='close font-weight-light' data-dismiss='alert' href='#'>x</a></div>";
			       		request.getSession().setAttribute("message", message);
			            response.sendRedirect("index.jsp");
			            return;			       		
			       	} 
			       	
			       	User user = new User();
	        		while (resultSet2.next()) {
	        			user_id = resultSet2.getInt("id");
	        			fname = resultSet2.getString("first_name");
	        			lname = resultSet2.getString("last_name"); 
	        			user_email = resultSet2.getString("email");
	        			user_password = resultSet2.getString("password");
	        			
	        			user.id = user_id;
			   	       	user.fname = fname;
			   	       	user.lname = lname;
			   	       	user.email = user_email;
	                }
	        		
	        		if (!entered_password.equals(user_password)) {
	        			message = "<div class='alert alert-danger'>Password is incorrect. Try again!<a class='close font-weight-light' data-dismiss='alert' href='#'>x</a></div>";
	        			request.getSession().setAttribute("message", message);
	                    response.sendRedirect("index.jsp");
	                    return;
	        		}
	        		
		   	       	HttpSession session = request.getSession(true);
		   	       	session.setAttribute("user", user);
		   	       	
//		   	       	session.setAttribute("user_id", user_id);
//		   	       	session.setAttribute("first_name", fname);
//		   	        session.setAttribute("last_name", lname);
//		   	       	session.setAttribute("email", user_email);
		   	       	
		   	       	response.sendRedirect("profile.jsp");
		   	       	
//			   	    RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
//		   	       	rd.forward(request, response);			       	
        		}
    		} catch(SQLException e) {
	   	   		 e.printStackTrace();
   	   	    }
		}
        
    }
}