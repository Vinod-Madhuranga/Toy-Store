package com.toystore.user.dao;

import com.toystore.user.model.User;
import java.io.*;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.ServletContext;

public class UserManager {
    private static final String USER_FILE = "E:/Personal Projects/Online Toy Store/src/main/webapp/WEB-INF/users.txt";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
    private static UserManager instance;
    private List<User> users;

    private UserManager() {
        users = new LinkedList<>();
        loadUsers();
    }

    public static UserManager getInstance() {
        if (instance == null) {
            instance = new UserManager();
        }
        return instance;
    }

    public void setServletContext(ServletContext context) {
        // Not needed anymore since we're using absolute path
    }

    private void loadUsers() {
        File file = new File(USER_FILE);
        users.clear();
        if (!file.exists()) {
            System.err.println("Users file not found at: " + USER_FILE);
            return;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 6) {
                    User user = new User(
                        parts[0], // fullName
                        parts[1], // username
                        parts[2], // email
                        parts[3], // password
                        parts[4], // address
                        parts[5]  // phoneNumber
                    );
                    users.add(user);
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading users: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void saveUsers() {
        try {
            File file = new File(USER_FILE);
            if (!file.exists()) {
                File parentDir = file.getParentFile();
                if (parentDir != null && !parentDir.exists()) {
                    parentDir.mkdirs();
                }
                file.createNewFile();
            }
            try (PrintWriter writer = new PrintWriter(new FileWriter(file))) {
                for (User user : users) {
                    writer.println(user.toString());
                }
            }
        } catch (IOException e) {
            System.err.println("Error saving users: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public boolean registerUser(User user) {
        if (findUserByEmail(user.getEmail()) != null) {
            return false;
        }
        users.add(user);
        saveUsers();
        return true;
    }

    public User findUserByEmail(String email) {
        return users.stream()
                .filter(user -> user.getEmail().equalsIgnoreCase(email))
                .findFirst()
                .orElse(null);
    }

    public boolean updateUser(User updatedUser) {
        User existingUser = findUserByEmail(updatedUser.getEmail());
        if (existingUser == null) {
            return false;
        }
        users.remove(existingUser);
        users.add(updatedUser);
        saveUsers();
        return true;
    }

    public boolean deleteUser(String username) {
        User user = findUserByEmail(username);
        if (user == null) {
            return false;
        }

        users.remove(user);
        saveUsers();
        return true;
    }

    public List<User> getAllUsers() {
        return new LinkedList<>(users);
    }

    public boolean authenticateUser(String email, String password) {
        User user = findUserByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            return true;
        }
        return false;
    }
} 