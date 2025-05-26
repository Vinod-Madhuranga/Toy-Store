package com.toystore.order.model;

import java.io.Serializable;

public class OrderItem implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String toyId;
    private String toyName;
    private double price;
    private int quantity;
    
    public OrderItem() {}
    
    public OrderItem(String toyId, String toyName, double price, int quantity) {
        this.toyId = toyId;
        this.toyName = toyName;
        this.price = price;
        this.quantity = quantity;
    }
    
    // Getters and Setters
    public String getToyId() {
        return toyId;
    }
    
    public void setToyId(String toyId) {
        this.toyId = toyId;
    }
    
    public String getToyName() {
        return toyName;
    }
    
    public void setToyName(String toyName) {
        this.toyName = toyName;
    }
    
    public double getPrice() {
        return price;
    }
    
    public void setPrice(double price) {
        this.price = price;
    }
    
    public int getQuantity() {
        return quantity;
    }
    
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public double getSubtotal() {
        return price * quantity;
    }
    
    @Override
    public String toString() {
        return String.format("%s:%s:%.2f:%d", toyId, toyName, price, quantity);
    }
} 