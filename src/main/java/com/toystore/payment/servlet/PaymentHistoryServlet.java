package com.toystore.payment.servlet;

import com.toystore.payment.dao.PaymentDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/payment-history")
public class PaymentHistoryServlet extends HttpServlet {
    private PaymentDAO paymentDAO;

    @Override
    public void init() {
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setAttribute("payments", paymentDAO.getAllPayments());
        request.getRequestDispatcher("payment-history.jsp").forward(request, response);
    }
} 