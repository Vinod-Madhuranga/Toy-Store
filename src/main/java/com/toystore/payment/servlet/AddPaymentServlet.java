package com.toystore.payment.servlet;

import com.toystore.payment.dao.PaymentDAO;
import com.toystore.payment.model.Payment;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/add-payment")
public class AddPaymentServlet extends HttpServlet {
    private PaymentDAO paymentDAO;

    @Override
    public void init() {
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Payment payment = new Payment();
        payment.setType(request.getParameter("type"));
        payment.setCardNumber(request.getParameter("cardNumber"));
        payment.setCardHolderName(request.getParameter("cardHolderName"));
        payment.setExpiryDate(request.getParameter("expiryDate"));
        payment.setCvv(request.getParameter("cvv"));

        paymentDAO.addPayment(payment);
        response.sendRedirect("payment-history");
    }
} 