<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
	<title>User profile</title>
	
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/profile_style.css">
</head>
<body>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="com.mysql.cj.jdbc.Driver" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="database.DbConnection" %>
<%@ page import="models.Profile" %>
<jsp:include page="header.jsp"/>
<%-- --%>

<% 
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

if(session.getAttribute("user") == null) {
	response.sendRedirect("index.jsp");	
}
%>

<% 
int id = 0;
if (request.getParameter("id") != null) {
	id = Integer.parseInt(request.getParameter("id"));
}

Connection conn = null;
String fname =""; String lname= ""; String email="";
Profile profile = new Profile();
int flag = 0;

try {		 		
	Class.forName("com.mysql.jdbc.Driver");
   	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/se_project"+"?verifyServerCertificate=false"+ 
	 	     "&useSSL=false"+"&requireSSL=false"+ 
 	     "&useLegacyDatetimeCode=false"+ "&amp"+"&serverTimezone=UTC", "root", "");
	
	if (conn == null) {
		out.println("CONNECTION IS NULL!!!");
	}
	
	String query = "SELECT * FROM users WHERE id='"+ id +"'"; 
	PreparedStatement prepStatement = conn.prepareStatement(query);
	ResultSet rs = prepStatement.executeQuery(query);	
	
	while (rs.next()) {			
		fname = rs.getString("first_name");
		lname = rs.getString("last_name");
		email = rs.getString("email");
	}
	
	String query2 = "SELECT * FROM profile WHERE user_id='"+ id +"'"; 
	PreparedStatement prepStatement2 = conn.prepareStatement(query2);
	ResultSet rs2 = prepStatement2.executeQuery(query2);
	
	while (rs2.next()) {	
		flag = 1;
		profile.first_name = rs2.getString("first_name");
		profile.first_name = rs2.getString("last_name");
		profile.age = rs2.getInt("age");
		profile.education = rs2.getString("education");
		profile.major = rs2.getString("major");
		profile.profession = rs2.getString("profession");
		profile.experience = rs2.getString("experience");
		profile.skills = rs2.getString("skills");
		profile.links = rs2.getString("links");
		profile.bio = rs2.getString("bio");				
	}
	
} catch(SQLException e) {
	System.out.println(e);
} catch(ClassNotFoundException e) {
	System.out.println(e);
} 

%>


<div class="container emp-profile">						
            <form method="post">
                <div class="row">
                    <div class="col-md-4">
                        <div class="profile-img">
                            <!--
                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS52y5aInsxSm31CvHOFHWujqUx_wWTS9iM6s7BAm21oEN_RiGoog" alt=""/> 
                            <img src="https://support.plymouth.edu/kb_images/Yammer/default.jpeg">
                            -->
                            <img src="https://cdn2.vectorstock.com/i/1000x1000/23/81/default-avatar-profile-icon-vector-18942381.jpg">
                            
                            <!--   
                            <div class="file btn btn-lg btn-primary">
                                Change Photo
                                <input type="file" name="file"/>
                            </div>
                            -->
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="profile-head">
                                    <h5>                                      
                                        <% 
                                        //if (flag == 1) {
                                       	out.println(fname + " " + lname);                                        		
                                        //}
                                        %>                                       
                                    </h5>
                                    <h6>
                                        <% 
                                        if (flag == 1) {
                                        	out.println(profile.profession); 
                                       	}
                                        %>                                       
                                    </h6>
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">About</a>
                                </li>
                                <!--  
                                <li class="nav-item">
                                    <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Timeline</a>
                                </li>
                                -->
                            </ul>
                        </div>
                    </div>
                    <!-- 
                    <div class="col-md-2">                  
                   			<div class="form-group has-error">
                    			<input type="submit" class="profile-edit-btn" name="btnAddMore" value="Edit Profile"/>
                    		</div>                      
                    </div>
                     -->
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="profile-work">
                            <p>WORK LINK</p>
                            <% 
                            if (flag == 1) {
                            	out.println("<a style='color: #0062cc;' href='"+ profile.links +"'>" + profile.links + "</a>");                           	
                            }  
                            %>
                            
                            <!-- 
                            <a href="">Website Link</a><br/>
                            <a href="">Bootsnipp Profile</a><br/>
                            <a href="">Bootply Profile</a>
                            -->
                            <p>SKILLS</p>
                            <% 
                            if (flag == 1) {
                            	out.println("<p style='color: #0062cc;'>" + profile.skills + "</p>");                           	
                            }  
                            %>
                            <!-- 
                            <a href="">Web Designer</a><br/>
                            <a href="">Web Developer</a><br/>
                            <a href="">WordPress</a><br/>
                            <a href="">WooCommerce</a><br/>
                            <a href="">PHP, .Net</a><br/>
                            -->
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="tab-content profile-tab" id="myTabContent">
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Name</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p><% 
                                                //if (flag == 1) {
                                                	out.println(fname +" "+ lname); 
                                                //}
                                                %></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Email</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p><% 
                                                //if (flag == 1) {
                                                	out.println(email);
                                                //}
                                                 
                                                %></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Age</label>
                                            </div>
                                            <div class="col-md-6">                                            	
                                                <p><% 
                                                if (flag == 1) {
                                                	out.println(profile.age);
                                                }
                                                %></p>
                                            </div>
                                        </div>
                                        <!--  
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Current Occupation</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p></p>
                                            </div>
                                        </div>
                                        -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Education</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p> <% 
                                                if (flag == 1) {
                                                	out.println(profile.education);
                                                }
                                                %> </p>
                                            </div>
                                        </div>
                                         <div class="row">
                                            <div class="col-md-6">
                                                <label>Major</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p> <% 
                                                if (flag == 1) {
                                                	out.println(profile.major);
                                                }
                                                %> </p>
                                            </div>
                                        </div>
                                        <!--  -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Profession</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p><% 
                                                if (flag == 1) {
                                                	out.println(profile.profession);
                                                }
                                                %> </p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Experience</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p><% 
                                                if (flag == 1) {
                                                	out.println(profile.experience);
                                                }
                                                %></p>
                                            </div>
                                        </div>
                                        <div class="row">
		                                    <div class="col-md-12">
		                                        <label>Bio</label><br/>
		                                        <p> <% 
                                                if (flag == 1) {
                                                	out.println(profile.bio);
                                                }
                                                %> </p>
		                                    </div>
		                                </div>
                            </div>
                            <!-- 
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">  
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Hourly Rate</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Total Projects</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>English Level</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Availability</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p></p>
                                            </div>
                                        </div>                                      
                            </div>
                             -->
                             
                        </div>
                    </div>
                </div>
            </form>           
        </div>


</body>
</html>