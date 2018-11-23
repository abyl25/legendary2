<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Legendary</title>
    
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">-->
    
    <!--<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">-->
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="css/profile_style.css">
    
    <!------ Include the above in your HEAD tag ---------->

</head>
<body>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="com.mysql.cj.jdbc.Driver" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="models.User" %>
<%@ page import="models.Profile" %>
<%@ page import="database.DbConnection" %>

<jsp:include page="header.jsp"/>

<%-- 
if(session.getAttribute("first_name") == null) {
	response.sendRedirect("index.jsp");	
}
--%>

<%-- 
Integer user_id_obj = (Integer)session.getAttribute("user_id");
int user_id = 0;
if (user_id_obj != null) {
	user_id = user_id_obj.intValue();
}
String first_name = (String)session.getAttribute("first_name");
String last_name = (String)session.getAttribute("last_name");
String email = (String)session.getAttribute("email");
--%>

<% 
if(session.getAttribute("user") == null) {
	response.sendRedirect("index.jsp");	
}
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setHeader("Expires", "0");

User user = (User)session.getAttribute("user");

int user_id = user.id;
String first_name = user.fname;
String last_name = user.lname;
String email = user.email;

Profile profile = new Profile();
Connection conn = null;
int flag = 0;

try {		 		
	Class.forName("com.mysql.jdbc.Driver");
   	conn = DbConnection.getConnection();
	
	if (conn == null) {
		out.println("CONNECTION IS NULL!!!");
	}
	
	String query = "SELECT * FROM profile WHERE user_id='"+ user_id +"'"; 
	PreparedStatement prepStatement = conn.prepareStatement(query);
	ResultSet rs = prepStatement.executeQuery(query);
	
	while (rs.next()) {	
		flag = 1;
		profile.first_name = rs.getString("first_name");
		profile.first_name = rs.getString("last_name");
		profile.age = rs.getInt("age");
		profile.education = rs.getString("education");
		profile.major = rs.getString("major");
		profile.profession = rs.getString("profession");
		profile.experience = rs.getString("experience");
		profile.skills = rs.getString("skills");
		profile.links = rs.getString("links");
		profile.bio = rs.getString("bio");				
	}
	
} catch(SQLException e) {
	System.out.println(e);
} catch(ClassNotFoundException e) {
	System.out.println(e);
}
%>
<div class="container emp-profile">
			 
			 <a href='editprofile.jsp' class="btn btn-primary float-right">Fill Profile</a>
			<!-- 
			<form action="editprofile" method="post" class="">
			      <input type="submit" value="Edit Profile" class="btn btn-primary float-right" id="edit-btn"> 
			</form>
			-->
            <form method="post">
                <div class="row">
                    <div class="col-md-4">
                        <div class="profile-img">
                            <!--
                            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS52y5aInsxSm31CvHOFHWujqUx_wWTS9iM6s7BAm21oEN_RiGoog" alt=""/>
                            <img src="https://support.plymouth.edu/kb_images/Yammer/default.jpeg">                          
                            -->
                            <img src="https://cdn2.vectorstock.com/i/1000x1000/23/81/default-avatar-profile-icon-vector-18942381.jpg">
                            
                            <div class="file btn btn-lg btn-primary">
                                Change Photo
                                <input type="file" name="file"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="profile-head">
                                    <h5>                                      
                                        <% out.println(first_name + " " + last_name); %>                                       
                                    </h5>
                                    <h6>
                                        <% 
                                        if (flag == 1) {
                                        	//String cap = profile.profession.substring(0, 1).toUpperCase() + profile.profession.substring(1);
                                        	//out.println(cap);
                                        	out.println(profile.profession);
                                       	}
                                        %>                                      
                                    </h6>
                            <ul class="nav nav-tabs" id="myTab" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="home-tab" data-toggle="tab" href="#" role="tab" aria-controls="home" aria-selected="true">About</a>
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
                            <a href="#">Website Link</a><br/>
                            <a href="#">Bootsnipp Profile</a><br/>
                            <a href="#">Bootply Profile</a>
                            -->
                            <p>SKILLS</p>        
                            <% 
                            if (flag == 1) {
                            	out.println("<p style='color: #0062cc;'>" + profile.skills + "</p>");
                            } 
                            %>                        
                            <!--  
                            <a href="#">Web Designer</a><br/>
                            <a href="#">Web Developer</a><br/>
                            <a href="#">WordPress</a><br/>
                            <a href="#">WooCommerce</a><br/>
                            <a href="#">PHP, .Net</a><br/>
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
                                                <p><% out.println(first_name+" "+ last_name); %></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Email</label> 
                                            </div>
                                            <div class="col-md-6">
                                                <p><% out.println(email); %></p>
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
                                                <label></label>
                                            </div>
                                            <div class="col-md-6">
                                                <p>Occupation</p>
                                            </div>
                                        </div>
                                        -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Education</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p><% 
                                                if (flag == 1) {
                                                	out.println(profile.education); 
                                                }
                                                %></p>                                               
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Major</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p><% 
                                                
                                                if (flag == 1) {
                                                	//String major1 = profile.major.substring(0, 1).toUpperCase() + profile.major.substring(1);                                                  
                                                	out.println(profile.major); 
                                                }
                                                %></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Profession</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p><% 
                                                if (flag == 1) {
                                                	//String prof1 = profile.profession.substring(0, 1).toUpperCase() + profile.profession.substring(1);
                                                	out.println(profile.profession); 
                                                }
                                                %></p>
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
		                                    <div class="col-md-6">
		                                        <label>Bio description</label>  
		                                     </div>
		                                     <div class="col-md-6">
                                             	<p><% 
                                                if (flag == 1) {
                                                	out.println(profile.bio); 
                                                }
                                                %></p>
                                           	 </div>     
                                		</div>
                            </div>
                            <br>
                            <!--  
                            <form action="upload" method="post" enctype="multipart/form-data">
                            	<div class="form-group">
									<p class='' style='#3a4049;'>Upload CV</p>
								    <input type="file" name="file">
								    <input type="submit" class="form-control btn btn-success w-25 mt-2" value="Upload">
							    </div>
							</form>
                            -->
                            
                            <!-- 
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Experience</label>
                                            </div>
                                            <div class="col-md-6">
                                                <p></p> 
                                            </div>
                                        </div>
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
                                <div class="row">
                                    <div class="col-md-12">
                                        <label>Your Bio</label><br/>
                                        <p>Your detail description</p>
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
        
<script>
	$(document).ready(function (){
		//$("#logout-btn").on('click', function() {
		//	
		//});
	});
</script>

<%-- session.invalidate();
response.sendRedirect(request.getContextPath() + "/");
--%>
</body>
</html>