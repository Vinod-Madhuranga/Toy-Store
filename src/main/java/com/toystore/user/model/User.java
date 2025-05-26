package com.toystore.user.model;

import java.io.Serializable;
import java.time.LocalDate;

public class User implements Serializable {
    private String fullName;
    private String username;
    private String email;
    private String password;
    private String address;
    private String phoneNumber;
    private String bio;
    private LocalDate birthDate;
    private String gender;
    private String avatarUrl;
    private boolean twoFactorEnabled;

    public User() {}

    public User(String fullName, String username, String email, String password, String address, String phoneNumber) {
        this.fullName = fullName;
        this.username = username;
        this.email = email;
        this.password = password;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.twoFactorEnabled = false;
    }

    // Getters and Setters
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }
    public LocalDate getBirthDate() { return birthDate; }
    public void setBirthDate(LocalDate birthDate) { this.birthDate = birthDate; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }
    public boolean isTwoFactorEnabled() { return twoFactorEnabled; }
    public void setTwoFactorEnabled(boolean twoFactorEnabled) { this.twoFactorEnabled = twoFactorEnabled; }

    @Override
    public String toString() {
        return String.join(",",
                fullName != null ? fullName : "",
                username != null ? username : "",
                email != null ? email : "",
                password != null ? password : "",
                address != null ? address : "",
                phoneNumber != null ? phoneNumber : "",
                bio != null ? bio : "",
                birthDate != null ? birthDate.toString() : "",
                gender != null ? gender : "",
                avatarUrl != null ? avatarUrl : "",
                String.valueOf(twoFactorEnabled));
    }
}