package services;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import database.DbConnection;


@Path("/admindel")
public class AdminDeleteUsers {
	@Context
    private HttpServletRequest request;
    @Context
    private ServletContext context;
    Connection conn = null; 
    
    public AdminDeleteUsers(){
    	System.out.println("XAXAXA");
    	
	    String url = "jdbc:mysql://localhost:3306/se_project"+"?verifyServerCertificate=false"+ 
		 	     "&useSSL=false"+"&requireSSL=false"+ 
		 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC";
	    
	    System.out.println("URL: " + url);
	    conn = DbConnection.getConnection();
    }
    
    @GET
    @Path("hello")
    public Response so() {
    	
    	System.out.println("aaaaaaaaaaaaaaaaaaa");
    	
    	return Response.ok().build();
    }
    
    @GET
    @Path("/hello")
    public Response so2() {
    	
    	System.out.println("bbbbbbbbbbbbbbbbbbbbbbb");
    	
    	return Response.ok().build();
    }
    
    
    @GET
    @Path("/delete")
    @Produces(MediaType.APPLICATION_JSON)
    public Response kick_admin_out(@PathParam("id") String id) {
    	System.out.println("kick_admin_out >>>> ");
    	try {
    	    if(conn != null){
    	    	System.out.println("Successfully CONNECTED deleted!!!");
        		try{
		    	    DatabaseMetaData meta = conn.getMetaData();
					
					ResultSet tables = meta.getTables(null, null, "admin", null);
					
					if(tables.next()){
						System.out.println("Table has been FOUND!!!");
	    				Statement statement = (Statement) conn.createStatement();
	    				String query = "DELETE FROM `admin` WHERE id=" + id;
	    				statement.executeQuery(query);
	    				
	    				System.out.println("Successfully deleted!!!");
					}
					
        		} catch(Exception ex){
        			System.out.println(ex.getMessage());
        		}
    	    }
			
        } catch (Exception e) {
            System.out.println("Failed to .... ");
        }
    	
    	return Response.ok().build();
    }
}
