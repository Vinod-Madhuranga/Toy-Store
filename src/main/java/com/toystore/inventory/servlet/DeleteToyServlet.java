package com.toystore.inventory.servlet;

import com.toystore.inventory.dao.ToyDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/delete-toy")
public class DeleteToyServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(DeleteToyServlet.class.getName());
    private ToyDAO toyDAO;

    @Override
    public void init() {
        toyDAO = new ToyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String imageName = request.getParameter("imageName");
        if (imageName != null && !imageName.isEmpty()) {
            toyDAO.deleteToy(imageName);
            LOGGER.info("Deleted toy with image name: " + imageName);
        }
        response.sendRedirect(request.getContextPath() + "/list-toys");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
} 