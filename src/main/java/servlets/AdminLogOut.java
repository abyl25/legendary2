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

import javax.servlet.http.HttpSession;


@WebServlet(urlPatterns = { "/adlout" })
public class AdminLogOut extends HttpServlet {
    private static final long serialVersionUID = 1L;
    String url = "jdbc:mysql://localhost:3306/se_project"+"?verifyServerCertificate=false"+ 
	 	     "&useSSL=false"+"&requireSSL=false"+ 
	 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC";
    
    public AdminLogOut() {
        super();
    }

    protected void doGet (HttpServletRequest request, HttpServletResponse response)
        throws ServletException , IOException {
    	response.setContentType("text/jsp");
    	
    	HttpSession session = (HttpSession)request.getSession();
    	session.invalidate();
    	
    	System.out.println("The session has been closed ");
    	
    	response.sendRedirect("index.jsp");
    	
        return;
    }
    
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	response.setContentType("text/jsp");
    	
    	HttpSession session = (HttpSession)request.getSession();
    	session.invalidate();
    	
    	response.sendRedirect("index.jsp");
    	
        return;
    	
    }
}