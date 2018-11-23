package database;
import java.util.Properties;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
	private static Connection conn = null;
			
    public static Connection getConnection() {
    	if (conn != null) {
    		return conn;
    	} 
    	else {
    		try {
    			Class.forName("com.mysql.jdbc.Driver");
//    			jdbc:mysql://10.10.3.14:3306/legendary
            	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/se_project"+"?verifyServerCertificate=false"+ 
           	 	     "&useSSL=false"+"&requireSSL=false"+ 
        	 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC", "root", "");

//            	  Properties prop = new Properties();
//                InputStream inputStream = DbConnection.class.getClassLoader().getResourceAsStream("/db.properties");
//                prop.load(inputStream);
//                String driver = prop.getProperty("driver");
//                String url = prop.getProperty("url");
//                String user = prop.getProperty("user");
//                String password = prop.getProperty("password");
//                Class.forName(driver);
    		} catch(SQLException e) {
    			e.printStackTrace();
    		} catch(ClassNotFoundException e) {
    			e.printStackTrace();
    		}
    		
    		return conn;
    	}
    }
}
