package servlets;

import database.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.sql.DataSource;

//import javax.ws.rs.core.Context;
//import com.mysql.cj.api.jdbc.Statement;

import java.sql.*;
import javax.sql.*;
import com.mysql.cj.api.jdbc.Statement;

@WebServlet("/MyServlet")
public class MyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public MyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		Connection conn = null;
        try {
//   			String databaseName = "se_project";
//       		String instanceConnectionName = "testproject-189116:us-central1:se2018";
//            String url = "jdbc:mysql://10.10.3.14:3306/testdatabase361";
//       		String jdbcUrl = String.format("jdbc:mysql://google/%s?cloudSqlInstance=%s"+"&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false",
//       		    databaseName, instanceConnectionName);
//       		String jdbcUrl = String.format("jdbc:mysql://google/%s?cloudSqlInstance=%s&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false",
//       				databaseName, instanceConnectionName);
        	 String url = "jdbc:mysql://localhost:3306/temp"+"?verifyServerCertificate=false"+ 
        	 	     "&useSSL=false"+"&requireSSL=false"+ 
        	 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC";
            Class.forName ("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, "root", "");
//            conn = DriverManager.getConnection(jdbcUrl, "mysql.sys", "abylay25");
//            conn = DriverManager.getConnection(jdbcUrl, "root", "");
            
        }
        catch (Exception e) {
       	 	System.out.println ("!!!Database connection error!!! ");
            e.printStackTrace();
        }
        
        String table = "";
        String add_data = "";
        String add_table = "";
        
        // if connected to DB
        if (conn != null) {
        	out.append("Database connection established\n");
        	
        	// Create Table in DB
	        if (request.getParameterMap().containsKey("table")) {
	        	table = request.getParameter("table").trim();
	        	out.append("You entered table name: " + table + "\n");
	        	
	        	try {
	        		DatabaseMetaData dbm = conn.getMetaData();
	        		ResultSet tables = dbm.getTables(null, null, table, null);
	        		if (tables.next()) {
	        			out.append("Table already exists in DB: " + table + "\n");
	        		} else {
	        			Statement statement = (Statement) conn.createStatement();
		        		String query =  "CREATE TABLE " + table + " (id int NOT NUll AUTO_INCREMENT, name VARCHAR(30), PRIMARY KEY (id));";
		        		int count = statement.executeUpdate(query);
		        		if (count > 0) {
		        			out.append("Created table successfully: " + table + "\n");
		        		} 
	        		}	       		
	        		
//	        		conn.close();
	    		} catch ( SQLException e) {
	    			e. printStackTrace ();
	    		}
	        }
	        
	        // Insert data to DB
	        if (request.getParameterMap().containsKey("add_table") && request.getParameterMap().containsKey("add_data")) {
	        	add_table = request.getParameter("add_table").trim();
	        	add_data = request.getParameter("add_data").trim();
	        		        	
	        	try {
	        		DatabaseMetaData dbm = conn.getMetaData();
	        		ResultSet tables = dbm.getTables(null, null, add_table, null);
	        		if (tables.next()) {
	        			out.append("Table exists in DB: " + add_table + "\n");
	        			
		       	 		Statement statement = (Statement) conn.createStatement();
			   	       	String query = "INSERT INTO " + add_table +" (name) VALUES ('"+ add_data +"')";
			   	       	int c = statement.executeUpdate(query);			   	       	
			   	       	if (c > 0) {
			   	       		out.append("Data inserted successfully: "+ add_data + "\n");
			   	       	} else {
			   	       		out.append("Data insertion failed\n");
			   	       	}
			   	       	
//			   	       	System.out.println("Data inserted succesfully"); 
//			   	       	out.append("Data inserted succesfully");
	        		} else {
	        			out.append("Table doesn't exist in DB: " + add_table + "\n");
	        		}
	        		
	//	   	       	conn.close();
		   	   	 } catch(SQLException e) {
		   	   		 e.printStackTrace();
		   	   	 }
	        }
	        
	        // get data
	        if (request.getParameterMap().containsKey("get_table")) {
	        	String get_table = request.getParameter("get_table");
	        	out.append("You entered table: " + get_table + "\n");
	        	
	        	try {
	        		DatabaseMetaData dbm = conn.getMetaData();
	        		ResultSet tables = dbm.getTables(null, null, add_table, null);
	        		
	        		if (tables.next()) {
	        			out.append("Table exists in DB: " + get_table + "\n");
	        			
		        		Statement statement = (Statement) conn.createStatement();
		        		String query =  "SELECT * FROM " + get_table;
		        		ResultSet resultSet = statement.executeQuery(query);
		        		
		        		String res = "SELECTED DATA: \n";
		        		int i=0;
		        		while (resultSet.next()) {
		        			if (i == 0) {
		        				out.append("DATA SELECT was successful\n\n");
		        			}
		        			res = res + "ID: " + resultSet.getInt("id") + " Name: " + resultSet.getString("name") + "\n"; 
		        			i++;
		                }
		        		
		        		out.append(res);
	        		} else {
	        			out.append("Table doesn't exist in DB: " + get_table + "\n");
	        		}
	        		
	        	} catch (SQLException e) {
	        		e.printStackTrace();
	        	}
	        	
	        	
	        	
	        }
	        
        } // conn != null
        else {
        	out.append("Connection not established");
        }
    	
//    	out.append("Created table successfully");
	}

}
