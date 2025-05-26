package com.toystore.admin.servlet;

import com.toystore.admin.service.AdminService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/list")
public class ListServlet extends HttpServlet {
    private AdminService adminService;

    @Override
    public void init() throws ServletException {
        adminService = new AdminService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("admins", adminService.getAllAdmins());
        // Adjust the path below if your adminlist.jsp is in a different directory
        request.getRequestDispatcher("/adminlist.jsp").forward(request, response);
    }
}
