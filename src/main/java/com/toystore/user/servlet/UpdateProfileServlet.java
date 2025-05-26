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
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@WebServlet("/update-profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateProfileServlet extends HttpServlet {
    private UserManager userManager;
    private static final String UPLOAD_DIR = "uploads/avatars";

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

        // Get form parameters
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String bio = request.getParameter("bio");
        String birthDateStr = request.getParameter("birthDate");
        String gender = request.getParameter("gender");

        // Input validation
        if (fullName == null || fullName.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Full name and email are required");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }

        // Create updated user object
        User updatedUser = new User(
                fullName.trim(),
                currentUser.getUsername(),
                email.trim(),
                currentUser.getPassword(),
                address != null ? address.trim() : null,
                phoneNumber != null ? phoneNumber.trim() : null
        );
        updatedUser.setBio(bio != null && bio.length() <= 200 ? bio.trim() : null);
        if (birthDateStr != null && !birthDateStr.isEmpty()) {
            try {
                updatedUser.setBirthDate(LocalDate.parse(birthDateStr));
            } catch (Exception e) {
                request.setAttribute("error", "Invalid date format");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }
        }
        updatedUser.setGender(gender != null && !gender.isEmpty() ? gender : null);
        updatedUser.setTwoFactorEnabled(currentUser.isTwoFactorEnabled());
        updatedUser.setAvatarUrl(currentUser.getAvatarUrl());

        // Handle avatar upload
        Part filePart = request.getPart("avatarUpload");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = updatedUser.getEmail() + "_" + System.currentTimeMillis() + fileExtension;
            Path uploadPath = Paths.get(getServletContext().getRealPath("") + UPLOAD_DIR, newFileName);

            Files.createDirectories(uploadPath.getParent());
            filePart.write(uploadPath.toString());
            updatedUser.setAvatarUrl(request.getContextPath() + "/" + UPLOAD_DIR + "/" + newFileName);
        }

        // Update user
        if (userManager.updateUser(updatedUser)) {
            session.setAttribute("user", updatedUser);
            request.setAttribute("success", "Profile updated successfully");
        } else {
            request.setAttribute("error", "Failed to update profile");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Generate CSRF token
        String csrfToken = UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken);
        request.setAttribute("csrfToken", csrfToken);

        // Mock data for JSP (replace with actual data in production)
        List<Session> activeSessions = Arrays.asList(
                new Session("1", "DESKTOP", "Laptop", "New York", "2025-05-26 10:00:00", true),
                new Session("2", "MOBILE", "iPhone", "London", "2025-05-25 15:30:00", false)
        );
        request.setAttribute("activeSessions", activeSessions);

        List<Order> orders = Arrays.asList(
                new Order("1001", "2025-05-20", "COMPLETED", 59.99),
                new Order("1002", "2025-05-15", "PENDING", 29.99)
        );
        request.setAttribute("orders", orders);

        List<Activity> activities = Arrays.asList(
                new Activity("LOGIN", "Logged in from New York", "2025-05-26 10:00:00"),
                new Activity("PURCHASE", "Purchased a teddy bear", "2025-05-20 12:30:00")
        );
        request.setAttribute("activities", activities);

        request.setAttribute("wishlistCount", 3);
        request.setAttribute("cartCount", 2);

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    // Session model class with proper JavaBean conventions
    public static class Session {
        private String id;
        private String deviceType;
        private String deviceName;
        private String location;
        private String lastActive;
        private boolean current;

        public Session() {
            // Default constructor required for JavaBean
        }

        public Session(String id, String deviceType, String deviceName, String location, String lastActive, boolean current) {
            this.id = id;
            this.deviceType = deviceType;
            this.deviceName = deviceName;
            this.location = location;
            this.lastActive = lastActive;
            this.current = current;
        }

        // Getters and Setters
        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getDeviceType() {
            return deviceType;
        }

        public void setDeviceType(String deviceType) {
            this.deviceType = deviceType;
        }

        public String getDeviceName() {
            return deviceName;
        }

        public void setDeviceName(String deviceName) {
            this.deviceName = deviceName;
        }

        public String getLocation() {
            return location;
        }

        public void setLocation(String location) {
            this.location = location;
        }

        public String getLastActive() {
            return lastActive;
        }

        public void setLastActive(String lastActive) {
            this.lastActive = lastActive;
        }

        public boolean isCurrent() {
            return current;
        }

        public void setCurrent(boolean current) {
            this.current = current;
        }
    }

    // Order model class with proper JavaBean conventions
    public static class Order {
        private String orderId;
        private String orderDate;
        private String status;
        private double totalAmount;

        public Order() {
            // Default constructor required for JavaBean
        }

        public Order(String orderId, String orderDate, String status, double totalAmount) {
            this.orderId = orderId;
            this.orderDate = orderDate;
            this.status = status;
            this.totalAmount = totalAmount;
        }

        // Getters and Setters
        public String getOrderId() {
            return orderId;
        }

        public void setOrderId(String orderId) {
            this.orderId = orderId;
        }

        public String getOrderDate() {
            return orderDate;
        }

        public void setOrderDate(String orderDate) {
            this.orderDate = orderDate;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public double getTotalAmount() {
            return totalAmount;
        }

        public void setTotalAmount(double totalAmount) {
            this.totalAmount = totalAmount;
        }
    }

    // Activity model class with proper JavaBean conventions
    public static class Activity {
        private String type;
        private String description;
        private String timestamp;

        public Activity() {
            // Default constructor required for JavaBean
        }

        public Activity(String type, String description, String timestamp) {
            this.type = type;
            this.description = description;
            this.timestamp = timestamp;
        }

        // Getters and Setters
        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public String getTimestamp() {
            return timestamp;
        }

        public void setTimestamp(String timestamp) {
            this.timestamp = timestamp;
        }
    }
}
