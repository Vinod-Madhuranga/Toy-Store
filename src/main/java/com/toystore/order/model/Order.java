package com.toystore.order.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class Order implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private String orderId;
    private String userId;
    private List<OrderItem> items;
    private double totalAmount;
    private String status; // PENDING, SHIPPED, DELIVERED, CANCELLED
    private Date orderDate;
    private String deliveryAddress;
    private String paymentMethod;
    
    public Order() {
        this.items = new ArrayList<>();
        this.orderDate = new Date();
        this.status = "PENDING";
    }
    
    // Getters and Setters
    public String getOrderId() {
        return orderId;
    }
    
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public List<OrderItem> getItems() {
        return items;
    }
    
    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
    
    public double getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Date getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    
    public String getDeliveryAddress() {
        return deliveryAddress;
    }
    
    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }
    
    public String getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    public void addItem(OrderItem item) {
        this.items.add(item);
        calculateTotal();
    }
    
    public void removeItem(OrderItem item) {
        this.items.remove(item);
        calculateTotal();
    }
    
    private void calculateTotal() {
        this.totalAmount = items.stream()
                .mapToDouble(item -> item.getPrice() * item.getQuantity())
                .sum();
    }

    @Override
    public String toString() {
        String itemsString = items.stream()
                .map(item -> String.format("%s:%s:%.2f:%d",
                        item.getToyId(),
                        item.getToyName(),
                        item.getPrice(),
                        item.getQuantity()))
                .collect(Collectors.joining(";"));

        return String.format("%s,%s,%s,%.2f,%s,%d,%s",
                orderId,
                userId,
                itemsString,
                totalAmount,
                status,
                orderDate.getTime(),
                deliveryAddress == null ? "" : deliveryAddress
        );
    }

} 