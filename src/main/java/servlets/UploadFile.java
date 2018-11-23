package servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import models.User;
import database.DbConnection;


@WebServlet("/upload")
public class UploadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn = null;
	
    public UploadFile() {
        super();
        conn = DbConnection.getConnection();
    }
    
    private static String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    Part filePart = request.getPart("file"); 
	    String fileName = getSubmittedFileName(filePart);	 
	    
//	    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.	    
//	    
	    
	    File uploads = new File("");
	    File file = new File(uploads, fileName);
	    
//	    try (InputStream input = filePart.getInputStream()) {
//	        Files.copy(input, file.toPath());
//	    }
	    InputStream fileContent = filePart.getInputStream();
	    
	    User user = (User)request.getSession().getAttribute("user");
	    int id = user.id;
	    
//	    String query = "INSERT INTO profile (file) VALUES (?) WHERE id='"+ id + "'"; 
//		PreparedStatement prepStatement = null;
//		try {
//			prepStatement = conn.prepareStatement(query);			
//			prepStatement.setBinaryStream(3, input);
//			ResultSet rs = prepStatement.executeQuery(query);
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
		
	}

}
