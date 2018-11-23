package servlets;

import database.DbConnection;
import models.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson;

@WebServlet("/searchPeople")
public class SearchPeople extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn = null;
    String url = "jdbc:mysql://localhost:3306/se_project"+"?verifyServerCertificate=false"+ 
	 	     "&useSSL=false"+"&requireSSL=false"+ 
	 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC";
    
    public SearchPeople() {
        super();
        conn = DbConnection.getConnection();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchText = request.getParameter("searchPeopleText");		
		Gson gson = new Gson();
		
		if (conn == null) {
			return;
		}
		
		try {
			Integer user_id_obj = (Integer)request.getSession().getAttribute("user_id");
			int user_id = 0;
			if (user_id_obj != null) {
				user_id = user_id_obj.intValue();
			}
			
			List<User> user_list = new ArrayList<User>();			 
			
			String query = "SELECT * FROM users WHERE id <>'"+ user_id + "'";
			PreparedStatement prepStatement = conn.prepareStatement(query);
			ResultSet rs = prepStatement.executeQuery(query);
			
			while (rs.next()) {
				User u = new User();
				u.fname = rs.getString("first_name");
				u.lname = rs.getString("last_name");
				u.email = rs.getString("email");
				user_list.add(u);
				
				System.out.print(rs.getString("first_name") + " ");
				System.out.print(rs.getString("last_name") + " ");
				System.out.println(rs.getString("email") + " ");
			}
			
			String json = gson.toJson(user_list);
			
			HttpSession session1 = request.getSession();
			session1.setAttribute("users_json", json);
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
