package com.toystore.payment.dao;

import com.toystore.payment.model.Payment;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.LinkedList;
import java.util.List;
import java.util.Date;

public class PaymentDAO {
    private static final String FILE_PATH = "E:Personal Projects/Online Toy Store/src/main/webapp/WEB-INF/payments.txt";
    private List<Payment> payments;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public PaymentDAO() {
        payments = new LinkedList<>();
        loadPayments();
    }

    private void loadPayments() {
        payments.clear();
        File file = new File(FILE_PATH);
        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null && !line.trim().isEmpty()) {
                    String[] parts = line.split("\\|");
                    if (parts.length >= 7) { // Updated to handle 7 fields
                        Payment payment = new Payment();
                        payment.setId(parts[0].trim());
                        payment.setType(parts[1].trim());
                        payment.setCardNumber(parts[2].trim());
                        payment.setCardHolderName(parts[3].trim());
                        payment.setExpiryDate(parts[4].trim());
                        try {
                            payment.setCreatedAt(dateFormat.parse(parts[5].trim()));
                            payment.setUpdatedAt(dateFormat.parse(parts[6].trim()));
                        } catch (Exception e) {
                            payment.setCreatedAt(new Date());
                            payment.setUpdatedAt(new Date());
                        }
                        payments.add(payment);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void savePayments() {
        try (PrintWriter writer = new PrintWriter(new FileWriter(FILE_PATH))) {
            // Write data
            for (Payment payment : payments) {
                writer.println(String.format("%s|%s|%s|%s|%s|%s|%s",
                    payment.getId(),
                    payment.getType(),
                    payment.getCardNumber(),
                    payment.getCardHolderName(),
                    payment.getExpiryDate(),
                    dateFormat.format(payment.getCreatedAt()),
                    dateFormat.format(payment.getUpdatedAt())
                ));
            }
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void addPayment(Payment payment) {
        if (payment.getId() == null || payment.getId().trim().isEmpty()) {
            payment.setId("PAY" + System.currentTimeMillis());
        }
        if (payment.getCreatedAt() == null) {
            payment.setCreatedAt(new Date());
        }
        if (payment.getUpdatedAt() == null) {
            payment.setUpdatedAt(new Date());
        }
        
        payments.add(payment);
        savePayments();
        loadPayments();
    }

    public List<Payment> getAllPayments() {
        loadPayments();
        return new LinkedList<>(payments);
    }

    public Payment getPaymentById(String id) {
        if (id == null || id.trim().isEmpty()) {
            return null;
        }
        loadPayments();
        return payments.stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void updatePayment(Payment payment) {
        if (payment == null || payment.getId() == null) {
            return;
        }
        
        for (int i = 0; i < payments.size(); i++) {
            if (payments.get(i).getId().equals(payment.getId())) {
                payment.setUpdatedAt(new Date());
                payments.set(i, payment);
                savePayments();
                loadPayments();
                break;
            }
        }
    }

    public void deletePayment(String id) {
        if (id == null || id.trim().isEmpty()) {
            return;
        }
        
        payments.removeIf(p -> p.getId().equals(id));
        savePayments();
        loadPayments();
    }
} 