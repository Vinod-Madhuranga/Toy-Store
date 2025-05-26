package com.toystore.admin.servlet;

import com.toystore.admin.model.Admin;
import com.toystore.admin.service.AdminService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/adminregister")
public class AdminRegisterServlet extends HttpServlet {
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role");

        try {
            // Validate passwords match
            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match");
                request.getRequestDispatcher("/adminregister.jsp")
                       .forward(request, response);
                return;
            }

            // Check if username already exists
            if (adminService.isUsernameTaken(username)) {
                request.setAttribute("error", "Username already exists");
                request.getRequestDispatcher("/adminregister.jsp")
                       .forward(request, response);
                return;
            }

            // Create new admin
            Admin admin = new Admin(
                fullName,
                username,
                email,
                password,
                role
            );
            admin.setActive(true);

            adminService.createAdmin(admin);

            // Redirect to login page with success message
            response.sendRedirect(request.getContextPath() + "/adminlogin.jsp?registered=true");
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during registration");
            request.getRequestDispatcher("/adminregister.jsp")
                   .forward(request, response);
        }
    }
} 