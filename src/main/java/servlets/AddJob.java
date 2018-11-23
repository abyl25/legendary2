package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DbConnection;
import models.User;

@WebServlet("/addjob")
public class AddJob extends HttpServlet{
private static final long serialVersionUID = 1L;
	
	Connection conn = null;
  
    public AddJob() {
        super();     
        conn = DbConnection.getConnection();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String title = request.getParameter("title");
		String type = request.getParameter("type");
		String companyName = request.getParameter("company-name");
		String contacts = request.getParameter("contacts");
		String address = request.getParameter("address");
		String description = request.getParameter("description");
		
		if(conn == null) {
			out.append("Database connection error");
			return;
		}
		try {
			HttpSession session = request.getSession(true);
			User user = (User) session.getAttribute("user");
			
			String first_name = user.fname;
			String last_name = user.lname;
			int user_id = user.id;
			
			String query = "INSERT INTO vacancies (vacancy_type, title, description, company_name, address, contacts, created_date) "
					+ "VALUES (?, ?, ?, ?, ?, ?, NOW())";
			PreparedStatement prepStatement = conn.prepareStatement(query);
			prepStatement.setString(1, type);
			prepStatement.setString(2, title);
			prepStatement.setString(3, description);
			prepStatement.setString(4, companyName);
			prepStatement.setString(5, address);
			prepStatement.setString(6, contacts);
			
			prepStatement.execute();
				
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("searchjobs.jsp");
		
	}
}
