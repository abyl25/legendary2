package servlets;

import database.DbConnection;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.*;

import com.mysql.cj.api.jdbc.Statement;
import com.mysql.cj.jdbc.Driver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn = null;
    String url = "jdbc:mysql://localhost:3306/se_project"+"?verifyServerCertificate=false"+ 
	 	     "&useSSL=false"+"&requireSSL=false"+ 
	 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC";
    
    public Search() {
        super();  
        conn = DbConnection.getConnection();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchText = request.getParameter("searchText");		
		if (conn == null) {
			return;
		}
		
		try {
//			List<Vacancy> vacancy_list = new ArrayList<Vacancy>();
			
			String query = "SELECT * FROM vacancies WHERE description LIKE '%"+ searchText + "%'";
			PreparedStatement prepStatement = conn.prepareStatement(query);
			ResultSet rs = prepStatement.executeQuery(query);
			
			while (rs.next()) {
				System.out.println(rs.getString("title"));
//				Vacancy vacancy = new Vacancy();
				
//				vacancy.id = rs.getInt("id");
//				vacancy.vacancy_type = rs.getString("vacancy_type");
//				vacancy.title = rs.getString("title");
//				vacancy.description = rs.getString("description");
//				vacancy.company_name = rs.getString("company_name");
//				vacancy.address = rs.getString("address");
//				vacancy.contacts = rs.getString("contacts");
////				vacancy.created_date = rs.getString("created_date");
				
				System.out.println("----------------------------");
//				vacancy_list.add(vacancy);
			}
			
//			for (Vacancy each : vacancy_list) {
//				System.out.println(each.title);
//			}
						
//			HttpSession vacancy_session = request.getSession();
//			vacancy_session.setAttribute("vacancy_list", vacancy_list);
//			request.setAttribute("vacancy_list", vacancy_list);
			
//			int v_size = vacancy_list.size();
//			vacancy_session.setAttribute("vacancy_list_size", v_size);
//			System.out.printf("vacancy_list_size: %d", v_size);
			
//			response.sendRedirect("search.jsp");
			request.getRequestDispatcher("search.jsp").forward(request, response);
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		
//		response.sendRedirect("search.jsp");
	}

}
