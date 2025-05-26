package com.toystore.admin.servlet;

import com.toystore.admin.model.Admin;
import com.toystore.admin.service.AdminService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/adminlogin.jsp");
            return;
        }
        request.getRequestDispatcher("/adminprofile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/adminlogin.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Update admin details
            admin.setFullName(fullName);
            admin.setEmail(email);
            
            // Update password if provided
            if (password != null && !password.trim().isEmpty()) {
                admin.setPassword(password);
            }

            // Update admin in the system
            adminService.updateAdmin(admin);

            // Update session
            session.setAttribute("admin", admin);

            request.setAttribute("success", "Profile updated successfully");
        } catch (Exception e) {
            request.setAttribute("error", "Failed to update profile: " + e.getMessage());
        }

        request.getRequestDispatcher("/adminprofile.jsp").forward(request, response);
    }
}
