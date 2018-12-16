package servlets;

import database.DbConnection;

import javax.servlet.RequestDispatcher;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.sql.*;

import com.mysql.cj.api.jdbc.Statement;
import com.mysql.cj.jdbc.Driver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.User;


@WebServlet(urlPatterns = { "/signup" })
public class SignUp extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Connection conn = null;
    String url = "jdbc:mysql://localhost:3306/se_project"+"?verifyServerCertificate=false"+ 
	 	     "&useSSL=false"+"&requireSSL=false"+ 
	 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC";
    
    public SignUp() {
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
        
        // grab user entered values
        String first_name = request.getParameter("signup-fname");
        String second_name = request.getParameter("signup-lname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("password_2");
        
        // Validate user entered data
        String message = "";
        if(first_name.isEmpty()||second_name.isEmpty()||email.isEmpty()||password.isEmpty()||confirm_password.isEmpty()) {
        	message = "<div class='alert alert-danger'>Please, Fill all fields!<a class='close font-weight-light' data-dismiss='alert' href='#'>x</a></div>"; 
        	request.getSession().setAttribute("message", message);
            response.sendRedirect("index.jsp");
            return;            
        }        
        if (!email.isEmpty()) {
//        	Pattern p = Pattern.compile("^[a-z].*?@nu\\.edu\\.kz$"); 
        	Pattern p2 = Pattern.compile("^\\S+@\\S+\\.\\S+$");
            Matcher m = p2.matcher(email);
            if (!m.find()) {
            	message = "<div class='alert alert-danger'>Invalid email. Try again!<a class='close font-weight-light' data-dismiss='alert' href='#'>x</a></div>"; 
            	request.getSession().setAttribute("message", message);
                response.sendRedirect("index.jsp");
                return;            
            } 
        }
        if (password.length() < 6) {
        	message = "<div class='alert alert-danger'>Password must be bigger than 5 chars.<a class='close font-weight-light' data-dismiss='alert' href='#'>x</a></div>"; 
        	request.getSession().setAttribute("message", message);
            response.sendRedirect("index.jsp");
            return; 
        }
        if (!password.equals(confirm_password)) {
        	message = "<div class='alert alert-danger'>Passwords don't match. Try again!<a class='close font-weight-light' data-dismiss='alert' href='#'>x</a></div>"; 
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
	       	 		
	       	 		// check if Email already exists
		       	 	String query2 = "SELECT * FROM users WHERE email='" + email + "'";
	       	 		ResultSet resultSet2 = statement.executeQuery(query2);
	       	 		if (resultSet2.next()) {
		       	 		message = "<div class='alert alert-danger'>This email already exists. Try again!<a class='close font-weight-light' data-dismiss='alert' href='#'>x</a></div>"; 
		            	request.getSession().setAttribute("message", message);
		                response.sendRedirect("index.jsp");
		                return; 
	       	 		}
	       	 		
	       	 		// Insert user data into DB
	       	 		String query = "INSERT INTO "+ users+ " (id, first_name, last_name, email, password) VALUES"
		   	       			+ "(NULL, "+ "'" + first_name +"', " + "'"+ second_name +"', " + "'"+email+"', "+ "'"+password+"'"+")";   	    
		   	       	int c = statement.executeUpdate(query);			   	       	
//		   	       	if (c > 0) {
//		   	       		out.append("Data inserted successfully\n");
//		   	       	} else {
//		   	       		out.append("Data insertion failed\n");
//		   	       	}
		   	       	
		   	       	User user = new User();
		   	       	int user_id = 0;
		   	       	String query3 = "SELECT id FROM users WHERE email='" + email + "'";
	       	 		ResultSet resultSet3 = statement.executeQuery(query3);
		       	 	if (resultSet3.next()) {		       	 		
		       	 		user_id = resultSet3.getInt("id");
		       	 		
		       	 		user.id = user_id;
			       	 	user.fname = first_name;
			   	       	user.lname = second_name;
			   	       	user.email = email;
		       	 	}
		       	 	
//		   	       	int user_id = 0;
//			   	    ResultSet rs = statement.getGeneratedKeys();
//			        if (rs.next()){
//			            user_id = rs.getInt(1);
//			        }
		   	       	
		   	       	// Store user data into Session
		   	       	HttpSession session = request.getSession(true);
		   	       	session.setAttribute("user", user);		   	       			   	       	
		   	     		   	       	
		   	       	response.sendRedirect("profile.jsp");
        		} else {
        			out.append("Table doesn't exist in DB: " + users + "\n");
        		}
        		
    		} catch(SQLException e) {
	   	   		 e.printStackTrace();
   	   	    }
        	
    	}
    }
}