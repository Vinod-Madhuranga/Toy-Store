package com.toystore.user.servlet;

import com.toystore.user.dao.UserManager;
import com.toystore.user.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/resetpassword")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserManager userManager;

    @Override
    public void init() throws ServletException {
        super.init();
        userManager = UserManager.getInstance();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("password");

        // Validate inputs
        if (email == null || email.isEmpty() || newPassword == null || newPassword.isEmpty()) {
            request.setAttribute("error", "Please fill in all fields");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            // Find user by email
            User user = userManager.findUserByEmail(email);

            if (user == null) {
                request.setAttribute("error", "Email address not found in our system");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // Update the password
            user.setPassword(newPassword);
            boolean updateSuccess = userManager.updateUser(user);

            if (updateSuccess) {
                request.setAttribute("success", "Password has been reset successfully. Please login with your new password.");
            } else {
                request.setAttribute("error", "Failed to update password. Please try again.");
            }

        } catch (Exception e) {
            request.setAttribute("error", "Error resetting password: " + e.getMessage());
        }

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}