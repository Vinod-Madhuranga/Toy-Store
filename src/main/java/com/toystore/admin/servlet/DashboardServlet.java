package com.toystore.admin.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            // Not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/adminlogin");
            return;
        }

        // Forward to dashboard JSP
        request.getRequestDispatcher("/admindashboard.jsp").forward(request, response);
    }
}
