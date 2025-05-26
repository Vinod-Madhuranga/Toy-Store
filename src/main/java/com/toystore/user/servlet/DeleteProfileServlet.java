package com.toystore.user.servlet;

import com.toystore.user.dao.UserManager;
import com.toystore.user.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/delete-profile")
public class DeleteProfileServlet extends HttpServlet {
    private UserManager userManager;

    @Override
    public void init() throws ServletException {
        userManager = UserManager.getInstance(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Validate CSRF token
        String csrfToken = request.getParameter("csrfToken");
        String sessionCsrfToken = (String) session.getAttribute("csrfToken");
        if (csrfToken == null || !csrfToken.equals(sessionCsrfToken)) {
            request.setAttribute("error", "Invalid CSRF token");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // Verify password
        String password = request.getParameter("deletePassword");
        if (password == null || !userManager.authenticateUser(currentUser.getEmail(), password)) {
            request.setAttribute("error", "Incorrect password");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        try {
            // Delete user
            boolean deleted = userManager.deleteUser(currentUser.getEmail());
            if (deleted) {
                session.invalidate();
                response.sendRedirect("login.jsp?success=Your+profile+has+been+deleted+successfully");
            } else {
                request.setAttribute("error", "Failed to delete profile. Please try again.");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error deleting profile: " + e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}