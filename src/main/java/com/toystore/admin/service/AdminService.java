package com.toystore.admin.service;

import com.toystore.admin.model.Admin;
import com.toystore.admin.util.FileUtil;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class AdminService {
    
    /**
     * Get all admins
     */
    public List<Admin> getAllAdmins() throws IOException {
        return FileUtil.getAllAdmins();
    }

    /**
     * Get all active admins only
     */
    public List<Admin> getActiveAdmins() throws IOException {
        return FileUtil.getAllAdmins().stream()
                .filter(Admin::isActive)
                .collect(Collectors.toList());
    }

    /**
     * Get admin by username
     */
    public Admin getAdminByUsername(String username) throws IOException {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        return FileUtil.getAdminByUsername(username);
    }

    /**
     * Create new admin
     */
    public void createAdmin(Admin admin) throws IOException {
        if (admin == null) {
            throw new IllegalArgumentException("Admin cannot be null");
        }

        // Validate required fields
        validateAdminFields(admin);

        // Check if username already exists
        if (isUsernameTaken(admin.getUsername())) {
            throw new IllegalArgumentException("Username already exists");
        }

        // Set default active status
        admin.setActive(true);

        FileUtil.saveAdmin(admin);
    }

    /**
     * Update existing admin
     */
    public void updateAdmin(Admin admin) throws IOException {
        if (admin == null) {
            throw new IllegalArgumentException("Admin cannot be null");
        }

        // Validate required fields
        validateAdminFields(admin);

        // Check if admin exists
        Admin existingAdmin = getAdminByUsername(admin.getUsername());
        if (existingAdmin == null) {
            throw new IllegalArgumentException("Admin not found");
        }

        FileUtil.saveAdmin(admin);
    }

    /**
     * Delete admin by username
     */
    public boolean deleteAdmin(String username) throws IOException {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }

        // Check if it's the last super admin
        Admin adminToDelete = getAdminByUsername(username);
        if (adminToDelete != null && "SUPER_ADMIN".equals(adminToDelete.getRole())) {
            long superAdminCount = FileUtil.getAllAdmins().stream()
                    .filter(a -> "SUPER_ADMIN".equals(a.getRole()))
                    .count();
            if (superAdminCount <= 1) {
                throw new IllegalStateException("Cannot delete the last super admin");
            }
        }

        return FileUtil.deleteAdmin(username);
    }

    /**
     * Toggle admin active status
     */
    public void toggleAdminStatus(String username) throws IOException {
        Admin admin = getAdminByUsername(username);
        if (admin != null) {
            // Prevent deactivating the last super admin
            if ("SUPER_ADMIN".equals(admin.getRole()) && admin.isActive()) {
                long activeSuperAdminCount = FileUtil.getAllAdmins().stream()
                        .filter(a -> "SUPER_ADMIN".equals(a.getRole()) && a.isActive())
                        .count();
                if (activeSuperAdminCount <= 1) {
                    throw new IllegalStateException("Cannot deactivate the last active super admin");
                }
            }
            admin.setActive(!admin.isActive());
            updateAdmin(admin);
        }
    }

    /**
     * Validate admin credentials
     */
    public boolean validateCredentials(String username, String password) throws IOException {
        if (username == null || password == null) {
            return false;
        }
        Admin admin = getAdminByUsername(username);
        return admin != null 
            && admin.getPassword().equals(password) 
            && admin.isActive();
    }

    /**
     * Check if username is already taken
     */
    public boolean isUsernameTaken(String username) throws IOException {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        return FileUtil.getAllAdmins().stream()
                .anyMatch(admin -> admin.getUsername().equalsIgnoreCase(username));
    }

    /**
     * Change admin password
     */
    public void changePassword(String username, String currentPassword, String newPassword) throws IOException {
        if (username == null || currentPassword == null || newPassword == null) {
            throw new IllegalArgumentException("All parameters are required");
        }

        Admin admin = getAdminByUsername(username);
        if (admin == null) {
            throw new IllegalArgumentException("Admin not found");
        }

        if (!admin.getPassword().equals(currentPassword)) {
            throw new IllegalArgumentException("Current password is incorrect");
        }

        admin.setPassword(newPassword);
        updateAdmin(admin);
    }

    /**
     * Get admin statistics
     */
    public Map<String, Long> getAdminStats() throws IOException {
        List<Admin> admins = FileUtil.getAllAdmins();
        Map<String, Long> stats = new HashMap<>();
        
        stats.put("totalAdmins", (long) admins.size());
        stats.put("activeAdmins", admins.stream().filter(Admin::isActive).count());
        stats.put("superAdmins", admins.stream().filter(a -> "SUPER_ADMIN".equals(a.getRole())).count());
        stats.put("regularAdmins", admins.stream().filter(a -> "ADMIN".equals(a.getRole())).count());
        
        return stats;
    }

    /**
     * Validate admin fields
     */
    private void validateAdminFields(Admin admin) {
        if (admin.getFullName() == null || admin.getFullName().trim().isEmpty()) {
            throw new IllegalArgumentException("Full name is required");
        }
        if (admin.getUsername() == null || admin.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username is required");
        }
        if (admin.getPassword() == null || admin.getPassword().trim().isEmpty()) {
            throw new IllegalArgumentException("Password is required");
        }
        if (admin.getEmail() == null || admin.getEmail().trim().isEmpty()) {
            throw new IllegalArgumentException("Email is required");
        }
        if (admin.getRole() == null || admin.getRole().trim().isEmpty()) {
            throw new IllegalArgumentException("Role is required");
        }
        if (!admin.getRole().equals("SUPER_ADMIN") && !admin.getRole().equals("ADMIN")) {
            throw new IllegalArgumentException("Invalid role. Must be either SUPER_ADMIN or ADMIN");
        }
    }
} 