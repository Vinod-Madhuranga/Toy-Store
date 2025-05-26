package com.toystore.admin.util;

import com.toystore.admin.model.Admin;
import java.io.*;
import java.util.*;
import javax.servlet.ServletContext;

public class FileUtil {
    private static final String ADMIN_FILE = "E:Personal Projects/Online Toy Store/src/main/webapp/WEB-INF/admins.txt";

    public static void saveAdmin(Admin admin) throws IOException {
        List<Admin> admins = getAllAdmins();
        boolean found = false;
        
        for (int i = 0; i < admins.size(); i++) {
            if (admins.get(i).getUsername().equals(admin.getUsername())) {
                admins.set(i, admin);
                found = true;
                break;
            }
        }
        
        if (!found) {
            admins.add(admin);
        }
        
        saveAllAdmins(admins);
    }

    // Read all admins
    public static List<Admin> getAllAdmins() throws IOException {
        List<Admin> admins = new ArrayList<>();
        File file = new File(ADMIN_FILE);
        if (!file.exists()) return admins;

        try (BufferedReader reader = new BufferedReader(new FileReader(ADMIN_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 6) {
                    Admin admin = new Admin(
                        parts[0], // fullName
                        parts[1], // username
                        parts[2], // email
                        parts[3], // password
                        parts[4]  // role
                    );
                    admin.setActive(Boolean.parseBoolean(parts[5])); // active status
                    admins.add(admin);
                }
            }
        }
        return admins;
    }

    public static void saveAllAdmins(List<Admin> admins) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ADMIN_FILE))) {
            for (Admin admin : admins) {
                writer.write(String.format("%s,%s,%s,%s,%s,%s%n",
                    admin.getFullName(),
                    admin.getUsername(),
                    admin.getEmail(),
                    admin.getPassword(),
                    admin.getRole(),
                    admin.isActive()
                ));
            }
        }
    }

    public static boolean deleteAdmin(String username) throws IOException {
        List<Admin> admins = getAllAdmins();
        boolean removed = admins.removeIf(admin -> admin.getUsername().equals(username));
        if (removed) {
            saveAllAdmins(admins);
        }
        return removed;
    }

    public static Admin getAdminByUsername(String username) throws IOException {
        return getAllAdmins().stream()
                .filter(admin -> admin.getUsername().equals(username))
                .findFirst()
                .orElse(null);
    }

    public static String getAdminFilePath() {
        return ADMIN_FILE;
    }

    public static ServletContext getServletContext() {
        return null; 
    }
} 