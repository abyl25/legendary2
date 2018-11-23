package services;

import database.DbConnection;
import models.User;
import models.Vacancy;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

//import RequestUtils.UsersRequest;

import com.google.gson.Gson;

@Path("/jobs")
public class Jobs_service {
	Connection conn = null;
	
	public Jobs_service() {
    	conn = DbConnection.getConnection();
    }
	
	
	@GET
    @Path("{searchText}")
    public Response getUsers(@PathParam("searchText") String searchText, @Context HttpServletRequest request) {
        Gson gson = new Gson();  
        String json = "";
        
        System.out.print("search_name: " + searchText + ", id: ");
        
        try {
			List<Vacancy> vac_list = new ArrayList<Vacancy>();			 
			
			String query = "SELECT * FROM vacancies WHERE title LIKE '%" + searchText + 
					"%' OR description LIKE '%" + searchText + "%'"; 
			PreparedStatement prepStatement = conn.prepareStatement(query);
			ResultSet rs = prepStatement.executeQuery(query);
			
			while (rs.next()) {
				Vacancy v = new Vacancy();
				v.id = rs.getInt("id");
				v.vacancy_type = rs.getString("vacancy_type");
				v.title = rs.getString("title");
				v.description = rs.getString("description");				
				v.company_name = rs.getString("company_name");
				v.address = rs.getString("address");
				v.contacts = rs.getString("contacts");
			
				vac_list.add(v);				
			}
			
			json = gson.toJson(vac_list);
			System.out.println("json: " + json);
			
        } catch(SQLException e) {
			e.printStackTrace();
		}
        
        return Response.ok(json).build();
	}
	
}
