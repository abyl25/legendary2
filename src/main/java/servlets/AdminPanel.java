package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import database.DbConnection;

@WebServlet(urlPatterns = { "/admin" })
public class AdminPanel extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Connection conn = null;
    String url = "jdbc:mysql://localhost:3306/se_project"+"?verifyServerCertificate=false"+ 
	 	     "&useSSL=false"+"&requireSSL=false"+ 
	 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC";
    
    public AdminPanel() {
        super();
        conn = DbConnection.getConnection();
    }

    protected void doGet (HttpServletRequest request, HttpServletResponse response)
        throws ServletException , IOException {
    	System.out.println("In doGet of AdminPanel");
    	response.setContentType("text/jsp"); 
    	response.sendRedirect("admin.jsp");
        return;
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	response.setContentType("text/jsp");
    	PrintWriter out = response.getWriter();
    	String entered_adname = request.getParameter("admail");
    	String entered_password = request.getParameter("adpass");
    	
    	System.out.println("entered_email: " + entered_adname);
    	System.out.println("entered_password: " + entered_password);
    	
    	if(entered_adname.isEmpty() || entered_password.isEmpty()) {
            response.sendRedirect("index.jsp");
            return;                      
        }
    	
    	if(conn != null){
    		out.append("Connected! \n");
    		
    		try{
    			String search_table = "admin";
    			DatabaseMetaData meta = conn.getMetaData();
    			
    			ResultSet tables = meta.getTables(null, null, "admin", null);
    			
    			if(tables.next()){
    				Statement statement = (Statement) conn.createStatement();
    				String query = "SELECT * FROM admin WHERE adname='" + entered_adname + "'";
    				ResultSet resultAdmins = statement.executeQuery(query);
    				
    				String adname="";
    	       	 	String password = "";
    	       	 	String id = "";
    	       	 			
    		       	if (!resultAdmins.isBeforeFirst() ) {    		       	
    		            response.sendRedirect("admin.jsp");
    		            return;			       		
    		       	} 
    		       	
    		       	while (resultAdmins.next()) {
	        			adname = resultAdmins.getString("adname");
	        			password = resultAdmins.getString("password"); 
	        			id = resultAdmins.getString("id");
	                }
    		       	
    		       	if (!entered_password.equals(password)) {
	                    response.sendRedirect("admin.jsp");
	                    return;
	        		}
    		       	
    		       	/* Getting users from DB to display
    		       	 * --------------------------------------------  
    		       	*/
    		       	
    		       	String querySelectAllUsers = "SELECT * FROM users";
	       	 		ResultSet resultUsers = statement.executeQuery(querySelectAllUsers);		
		       	 	
	       	 		List<Map<String, String>> user_list = new ArrayList<Map<String, String>>();
	       	 		
			       	if (!resultUsers.isBeforeFirst() ) { 
			            response.sendRedirect("index.jsp");
			            return;			       		
			       	} 
			       		
	        		while (resultUsers.next()) {
	        			Map<String, String> user_map = new HashMap<String, String>();
	        			user_map.put( "first_name", resultUsers.getString("first_name") );
	        			user_map.put( "last_name", resultUsers.getString("last_name") ); 
	        			user_map.put( "user_email", resultUsers.getString("email") );
	        			user_map.put( "user_password", resultUsers.getString("password") );
    					user_map.put( "user_id", resultUsers.getString("id") );
    					
    					user_map.put( "last_access", "21:22:34 17.10.18");
    					 
    					//System.out.println("user_map: " + user_map);
    					
    					user_list.add(user_map);
	                }
    		       	
	        		System.out.println(user_list);
	        		
    		       	/* ---------------------------------------------  */
    		       	
    		       	HttpSession session = request.getSession(true);
    		       	session.setAttribute("user_list", user_list);
    		       	session.setAttribute("adname", adname);
    		       	
    		       	response.sendRedirect("adminprofile.jsp");
        			return;
    				}
    			
    			response.sendRedirect("index.jsp");
    			
    		} catch(Exception excep){
    			out.append("ERROR: Could not connect! \n");
    			System.out.println("ERROR: Could not connect! \n");
    		}
    		
    	}
    }


}
