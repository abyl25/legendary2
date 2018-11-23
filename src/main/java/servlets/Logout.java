package servlets;

import database.DbConnection;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class Logout extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Logout() {
        super();
    }
    
    protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException , IOException {
        // response.setContentType("text/jsp");
        // response.sendRedirect("index.jsp");
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException , IOException {
    	HttpSession ss = request.getSession();
//    	ss.removeAttribute("fname");
    	ss.invalidate();
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}