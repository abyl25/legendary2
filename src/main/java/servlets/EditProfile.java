package servlets;

import database.DbConnection;
import models.Profile;
import models.User;

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

import com.mysql.cj.api.jdbc.Statement;

@WebServlet("/editprofile")
public class EditProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection conn = null;
    String url = "jdbc:mysql://localhost:3306/se_project"+"?verifyServerCertificate=false"+ 
	 	     "&useSSL=false"+"&requireSSL=false"+ 
	 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC";
    
    public EditProfile() {
        super();     
        conn = DbConnection.getConnection();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String age = request.getParameter("profile-age");		
		String education = request.getParameter("profile-education");
		String major = request.getParameter("profile-major");
		String profession = request.getParameter("profile-profession");
		String experience = request.getParameter("profile-experience");
		String skills = request.getParameter("profile-skills");
		String links = request.getParameter("profile-links");
		String bio = request.getParameter("profile-bio");
			
//		String salary = request.getParameter("profile-salary");
//		String availability = request.getParameter("profile-availability");
//		String phone = request.getParameter("profile-phone");
		
		String message = "";
		
		if (conn == null) {
			out.append("Database connection error");
			return;
		}
		
		try {
			HttpSession session = request.getSession(true);
			User user = (User) session.getAttribute("user");
			
			String first_name = user.fname;
			String last_name = user.lname;
			int user_id = user.id;
			
//			Integer user_id_obj = (Integer) session.getAttribute("user_id");
//			if (user_id_obj != null) {
//				user_id = user_id_obj.intValue();
//			} else {
//				return;
//			}
			
			String query = "INSERT INTO profile (user_id, first_name, last_name, age, education, major, profession, experience, skills, links, bio, photo) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement prepStatement = conn.prepareStatement(query);
			int id = 1;

//			prepStatement.setInt(1, id);
			prepStatement.setInt(1, user_id);
			prepStatement.setString(2, first_name);
			prepStatement.setString(3, last_name);
			prepStatement.setString(4, age);
			prepStatement.setString(5, education);
			prepStatement.setString(6, major);
			prepStatement.setString(7, profession);
			prepStatement.setString(8, experience);
			prepStatement.setString(9, skills);
			prepStatement.setString(10, links);
			prepStatement.setString(11, bio);
			prepStatement.setString(12, "NULL");
			
//			prepStatement.setString(6, salary);
//			prepStatement.setString(7, availability);
			
			prepStatement.execute();
			
			Profile profile = new Profile();
			profile.user_id = user_id;
			profile.first_name = first_name;
			profile.last_name = last_name;
			profile.age = Integer.parseInt(age);
			profile.education = education;
			profile.major = major;			
			profile.profession = profession;
			profile.experience = experience;
			profile.skills = skills;
			profile.links = links;
			profile.bio = bio;
//			profile.photo = photo;
			
			request.getSession().setAttribute("profile", profile);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("profile.jsp");
	}

}
