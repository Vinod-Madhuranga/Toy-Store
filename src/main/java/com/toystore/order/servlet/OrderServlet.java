package com.toystore.order.servlet;

import com.toystore.order.model.Order;
import com.toystore.order.model.OrderItem;
import com.toystore.order.util.FileHandler;
import com.toystore.user.model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/order/*")
public class OrderServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        
        switch (action) {
            case "/placement":
                showOrderPlacement(request, response);
                break;
            case "/place":
                placeOrder(request, response);
                break;
            case "/update":
                updateOrder(request, response);
                break;
            case "/cancel":
                cancelOrder(request, response);
                break;
            case "/history":
                viewOrderHistory(request, response);
                break;
            case "/details":
                viewOrderDetails(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();

        switch (action) {
            case "/history":
                viewOrderHistory(request, response);
                break;
            case "/details":
                viewOrderDetails(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void placeOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String[] toyIds = request.getParameterValues("toyId");
        String deliveryAddress = request.getParameter("deliveryAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        String[] quantities = request.getParameterValues("quantity");

        if (toyIds == null || deliveryAddress == null || paymentMethod == null || quantities == null) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/OrderPlacement.jsp").forward(request, response);
            return;
        }

        Order order = new Order();
        order.setOrderId(UUID.randomUUID().toString());
        order.setUserId(user.getUsername());
        order.setDeliveryAddress(deliveryAddress);
        order.setPaymentMethod(paymentMethod);

        for (int i = 0; i < toyIds.length; i++) {
            String toyId = toyIds[i];
            String toyName = request.getParameter("toyName_" + toyId);
            String priceStr = request.getParameter("price_" + toyId);
            String quantityStr = quantities[i];

            if (toyId == null || toyName == null || priceStr == null || quantityStr == null) continue;

            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);

            OrderItem item = new OrderItem(toyId, toyName, price, quantity);
            order.addItem(item);
        }

        FileHandler.saveOrder(order);
        response.sendRedirect(request.getContextPath() + "/order/history");
    }


    private void updateOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        List<Order> orders = FileHandler.loadOrders();
        
        Order order = orders.stream()
                .filter(o -> o.getOrderId().equals(orderId))
                .findFirst()
                .orElse(null);
        
        if (order != null && "PENDING".equals(order.getStatus())) {
            order.setDeliveryAddress(request.getParameter("deliveryAddress"));
            order.setPaymentMethod(request.getParameter("paymentMethod"));
            
            // Update items
            order.getItems().clear();
            String[] toyIds = request.getParameterValues("toyId");
            String[] quantities = request.getParameterValues("quantity");
            
            for (int i = 0; i < toyIds.length; i++) {
                OrderItem item = new OrderItem(
                    toyIds[i],
                    request.getParameter("toyName_" + toyIds[i]),
                    Double.parseDouble(request.getParameter("price_" + toyIds[i])),
                    Integer.parseInt(quantities[i])
                );
                order.addItem(item);
            }
            
            FileHandler.updateOrder(order);
        }

        response.sendRedirect(request.getContextPath() + "/order/history");
    }
    
    private void cancelOrder(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        List<Order> orders = FileHandler.loadOrders();
        
        Order order = orders.stream()
                .filter(o -> o.getOrderId().equals(orderId))
                .findFirst()
                .orElse(null);
        
        if (order != null && "PENDING".equals(order.getStatus())) {
            order.setStatus("CANCELLED");
            FileHandler.updateOrder(order);
        }

        response.sendRedirect(request.getContextPath() + "/order/history");
    }

    private void showOrderPlacement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String toyId = request.getParameter("toyId");
        String toyName = request.getParameter("toyName");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");

        OrderItem item = new OrderItem(toyId, toyName, Double.parseDouble(price), Integer.parseInt(quantity));
        List<OrderItem> cartItems = new ArrayList<>();
        cartItems.add(item);

        request.setAttribute("cartItems", cartItems);

        double subtotal = item.getPrice() * item.getQuantity();
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discount", 0);
        request.setAttribute("total", subtotal);

        request.getRequestDispatcher("/OrderPlacement.jsp").forward(request, response);}


    private void viewOrderHistory(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String userId = user.getUsername();

        List<Order> orders = FileHandler.getOrdersByUser(userId);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/OrderHistory.jsp")
                .forward(request, response);
    }
    
    private void viewOrderDetails(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
        List<Order> orders = FileHandler.loadOrders();
        
        Order order = orders.stream()
                .filter(o -> o.getOrderId().equals(orderId))
                .findFirst()
                .orElse(null);
        
        if (order != null) {
            request.setAttribute("order", order);
            request.getRequestDispatcher("/EditOrder.jsp")
                    .forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/order/history");
        }
    }
    private static Order parseOrder(String line) {
        try {
            String[] parts = line.split(",", -1); // Split all fields even if empty
            if (parts.length < 7) {
                System.err.println("Malformed order line: " + line);
                return null;
            }

            Order order = new Order();
            order.setOrderId(parts[0]);
            order.setUserId(parts[1]);

            // Parse items (handle empty items)
            if (!parts[2].isEmpty()) {
                String[] itemsStr = parts[2].split(";");
                for (String itemStr : itemsStr) {
                    String[] itemParts = itemStr.split(":", -1);
                    if (itemParts.length != 4) {
                        System.err.println("Invalid item format: " + itemStr);
                        continue;
                    }
                    OrderItem item = new OrderItem(
                            itemParts[0],
                            itemParts[1],
                            Double.parseDouble(itemParts[2]),
                            Integer.parseInt(itemParts[3])
                    );
                    order.addItem(item);
                }
            }

            order.setTotalAmount(Double.parseDouble(parts[3]));
            order.setStatus(parts[4]);
            order.setOrderDate(new java.util.Date(Long.parseLong(parts[5])));
            order.setDeliveryAddress(parts[6]);
            return order;
        } catch (Exception e) {
            System.err.println("Failed to parse line: " + line);
            e.printStackTrace();
            return null;
        }
    }

} 