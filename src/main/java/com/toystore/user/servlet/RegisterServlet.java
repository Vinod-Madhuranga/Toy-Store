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

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserManager userManager;

    @Override
    public void init() throws ServletException {
        userManager = UserManager.getInstance();
        userManager.setServletContext(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");

        if (fullName == null || username == null || email == null || password == null ||
            fullName.trim().isEmpty() || username.trim().isEmpty() ||
            email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields marked * are required");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User user = new User(fullName, username, email, password, address, phoneNumber);
        if (userManager.registerUser(user)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("list-toys");
        } else {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
} 