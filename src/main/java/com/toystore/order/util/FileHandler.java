package com.toystore.order.util;

import com.toystore.order.model.Order;
import com.toystore.order.model.OrderItem;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class FileHandler {
    private static final String ORDERS_FILE = "E:Personal Projects/Online Toy Store/src/main/webapp/WEB-INF/orders.txt";
    
    public static void saveOrder(Order order) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ORDERS_FILE, true))) {
            writer.write(order.toString());
            writer.newLine();
        }
    }
    
    public static List<Order> loadOrders() throws IOException {
        List<Order> orders = new ArrayList<>();
        File file = new File(ORDERS_FILE);
        
        if (!file.exists()) {
            return orders;
        }
        
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Order order = parseOrder(line);
                if (order != null) {
                    orders.add(order);
                }
            }
        }
        return orders;
    }
    
    public static List<Order> getOrdersByUser(String userId) throws IOException {
        return loadOrders().stream()
                .filter(order -> order.getUserId().equals(userId))
                .collect(Collectors.toList());
    }
    
    public static void updateOrder(Order updatedOrder) throws IOException {
        List<Order> orders = loadOrders();
        for (int i = 0; i < orders.size(); i++) {
            if (orders.get(i).getOrderId().equals(updatedOrder.getOrderId())) {
                orders.set(i, updatedOrder);
                break;
            }
        }
        
        // Rewrite all orders to file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ORDERS_FILE))) {
            for (Order order : orders) {
                writer.write(order.toString());
                writer.newLine();
            }
        }
    }
    
    private static Order parseOrder(String line) {
        try {
            String[] parts = line.split(",");
            Order order = new Order();
            order.setOrderId(parts[0]);
            order.setUserId(parts[1]);
            // Parse items
            String[] itemsStr = parts[2].split(";");
            for (String itemStr : itemsStr) {
                String[] itemParts = itemStr.split(":");
                OrderItem item = new OrderItem(
                    itemParts[0],
                    itemParts[1],
                    Double.parseDouble(itemParts[2]),
                    Integer.parseInt(itemParts[3])
                );
                order.addItem(item);
            }
            order.setTotalAmount(Double.parseDouble(parts[3]));
            order.setStatus(parts[4]);
            order.setOrderDate(new java.util.Date(Long.parseLong(parts[5])));
            order.setDeliveryAddress(parts[6]);
            return order;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
} 