package com.toystore.inventory.servlet;

import com.toystore.inventory.dao.ToyDAO;
import com.toystore.inventory.model.Toy;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/edit-toy")
public class EditToyServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(EditToyServlet.class.getName());
    private static final String EDIT_TOY_JSP = "/edit-toy.jsp";
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
            Toy toy = toyDAO.getToyByImageName(imageName);
            if (toy != null) {
                request.setAttribute("toy", toy);
            }
        }
        request.getRequestDispatcher(EDIT_TOY_JSP).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String toyId = request.getParameter("toyId");
            String imageName = request.getParameter("imageName");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String ageGroup = request.getParameter("ageGroup");

            Toy toy = new Toy(toyId, imageName, name, description, price, ageGroup);
            toyDAO.updateToy(toy);

            response.sendRedirect(request.getContextPath() + "/list-toys");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating toy", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating toy");
        }
    }
} 