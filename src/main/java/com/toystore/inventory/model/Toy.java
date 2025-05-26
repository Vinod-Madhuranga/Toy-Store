package com.toystore.inventory.model;

import java.io.Serializable;

public class Toy implements Serializable {
    private String toyId;
    private String imageName;
    private String name;
    private String description;
    private double price;
    private String ageGroup;

    public Toy() {}

    public Toy(String toyId, String imageName, String name, String description, double price, String ageGroup) {
        this.toyId = toyId;
        this.imageName = imageName;
        this.name = name;
        this.description = description;
        this.price = price;
        this.ageGroup = ageGroup;
    }

    public String getToyId() {
        return toyId;
    }
    public void setToyId(String toyId) {
        this.toyId = toyId;
    }

    public String getImageName() { return imageName; }
    public void setImageName(String imageName) { this.imageName = imageName; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getAgeGroup() {
        return ageGroup;
    }
    public void setAgeGroup(String ageGroup) {
        this.ageGroup = ageGroup;
    }

    @Override
    public String toString() {
        return String.join(",",toyId,  imageName, name, description, Double.toString(price) , ageGroup);
    }
}
