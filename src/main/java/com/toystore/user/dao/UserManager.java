package com.toystore.user.dao;

import com.toystore.user.model.User;

import javax.servlet.ServletContext;
import java.io.*;
import java.time.LocalDate;
import java.util.LinkedList;
import java.util.List;

public class UserManager {
    private static UserManager instance;
    private List<User> users;
    private String userFilePath;

    private UserManager(ServletContext context) {
        users = new LinkedList<>();
        userFilePath = "E:Personal Projects/Online Toy Store/src/main/webapp/WEB-INF/users.txt";
        loadUsers();
    }

    public static UserManager getInstance(ServletContext context) {
        if (instance == null) {
            instance = new UserManager(context);
        }
        return instance;
    }

    private void loadUsers() {
        File file = new File(userFilePath);
        users.clear();
        if (!file.exists()) {
            System.err.println("Users file not found at: " + userFilePath);
            return;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1); // -1 to include empty trailing fields
                if (parts.length >= 11) {
                    User user = new User(
                            parts[0], // fullName
                            parts[1], // username
                            parts[2], // email
                            parts[3], // password
                            parts[4], // address
                            parts[5]  // phoneNumber
                    );
                    user.setBio(parts[6].isEmpty() ? null : parts[6]);
                    user.setBirthDate(parts[7].isEmpty() ? null : LocalDate.parse(parts[7]));
                    user.setGender(parts[8].isEmpty() ? null : parts[8]);
                    user.setAvatarUrl(parts[9].isEmpty() ? null : parts[9]);
                    user.setTwoFactorEnabled(Boolean.parseBoolean(parts[10]));
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
            File file = new File(userFilePath);
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

    public boolean deleteUser(String email) {
        User user = findUserByEmail(email);
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
        return user != null && user.getPassword().equals(password);
    }
}