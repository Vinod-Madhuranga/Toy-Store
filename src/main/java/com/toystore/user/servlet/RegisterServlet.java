package com.toystore.user.servlet;

import com.toystore.user.dao.UserManager;
import com.toystore.user.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.regex.Pattern;

@WebServlet("/register")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class RegisterServlet extends HttpServlet {
    private UserManager userManager;
    private static final String UPLOAD_DIR = "E:Personal Projects/Online Toy Store/src/main/webapp/WEB-INF/uploads/avatars";
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w.-]+@([\\w-]+\\.)+[a-zA-Z]{2,6}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");

    @Override
    public void init() throws ServletException {
        userManager = UserManager.getInstance(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Get form parameters
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String bio = request.getParameter("bio");
        String birthDateStr = request.getParameter("birthDate");
        String gender = request.getParameter("gender");

        // Input validation
        if (fullName == null || username == null || email == null || password == null ||
                fullName.trim().isEmpty() || username.trim().isEmpty() ||
                email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All required fields (*) must be filled");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            request.setAttribute("error", "Invalid email format");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters long");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (phoneNumber != null && !phoneNumber.isEmpty() && !PHONE_PATTERN.matcher(phoneNumber).matches()) {
            request.setAttribute("error", "Phone number must be 10 digits");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (bio != null && bio.length() > 200) {
            request.setAttribute("error", "Bio must be 200 characters or less");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create new user
        User user = new User(fullName.trim(), username.trim(), email.trim(), password.trim(), address, phoneNumber);
        user.setBio(bio != null && !bio.isEmpty() ? bio.trim() : null);
        if (birthDateStr != null && !birthDateStr.isEmpty()) {
            try {
                user.setBirthDate(LocalDate.parse(birthDateStr));
            } catch (Exception e) {
                request.setAttribute("error", "Invalid date format");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
        }
        user.setGender(gender != null && !gender.isEmpty() ? gender : null);
        user.setTwoFactorEnabled(false);

        // Handle avatar upload
        Part filePart = request.getPart("avatarUpload");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = email + "_" + System.currentTimeMillis() + fileExtension;
            Path uploadPath = Paths.get(getServletContext().getRealPath("") + UPLOAD_DIR, newFileName);

            // Create upload directory if it doesn't exist
            Files.createDirectories(uploadPath.getParent());
            filePart.write(uploadPath.toString());
            user.setAvatarUrl(request.getContextPath() + "/" + UPLOAD_DIR + "/" + newFileName);
        }

        // Register user
        if (userManager.registerUser(user)) {
            session.setAttribute("user", user);
            response.sendRedirect("products");
        } else {
            request.setAttribute("error", "Email already exists");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Generate and set CSRF token
        String csrfToken = java.util.UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);
        request.setAttribute("csrfToken", csrfToken);
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}