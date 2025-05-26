package com.toystore.admin.servlet;

import com.toystore.admin.model.Admin;
import com.toystore.admin.service.AdminService;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/adminresetpassword")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        super.init();
        adminService = new AdminService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("password");

        // Validate inputs
        if (email == null || email.isEmpty() || newPassword == null || newPassword.isEmpty()) {
            request.setAttribute("error", "Please fill in all fields");
            request.getRequestDispatcher("adminlogin.jsp").forward(request, response);
            return;
        }

        try {
            // Find admin by email
            Admin admin = findAdminByEmail(email);

            if (admin == null) {
                request.setAttribute("error", "Email address not found in our system");
                request.getRequestDispatcher("adminlogin.jsp").forward(request, response);
                return;
            }

            // Update the password (in a real system, you would hash this password)
            admin.setPassword(newPassword);
            adminService.updateAdmin(admin);

            request.setAttribute("success", "Password has been reset successfully. Please login with your new password.");

        } catch (Exception e) {
            request.setAttribute("error", "Error resetting password: " + e.getMessage());
        }

        request.getRequestDispatcher("adminlogin.jsp").forward(request, response);
    }

    /**
     * Helper method to find admin by email
     */
    private Admin findAdminByEmail(String email) throws IOException {
        List<Admin> admins = adminService.getAllAdmins();
        for (Admin admin : admins) {
            if (email.equalsIgnoreCase(admin.getEmail())) {
                return admin;
            }
        }
        return null;
    }
}