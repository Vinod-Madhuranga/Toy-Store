package com.toystore.inventory.servlet;

import com.toystore.inventory.dao.ToyDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.io.File;

@WebServlet("/products")
public class HomeServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(HomeServlet.class.getName());
    private ToyDAO toyDAO;

    private static final String LIST_TOYS_JSP = "/home.jsp";
    private static final String IMAGES_DIRECTORY = "/images";

    @Override
    public void init() throws ServletException {
        try {
            toyDAO = new ToyDAO();
            LOGGER.info("HomeServlet initialized successfully");

            // Create images directory if it doesn't exist
            String fullImagesPath = getServletContext().getRealPath(IMAGES_DIRECTORY);
            File imagesDir = new File(fullImagesPath);
            if (!imagesDir.exists()) {
                boolean created = imagesDir.mkdirs();
                if (created) {
                    LOGGER.info("Created images directory: " + fullImagesPath);
                } else {
                    LOGGER.warning("Failed to create images directory: " + fullImagesPath);
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Initialization failed", e);
            throw new ServletException("Servlet initialization failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            LOGGER.info("Processing products request");
            String searchQuery = request.getParameter("search");
            String ageGroup = request.getParameter("ageGroup");

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                LOGGER.info("Searching for toys with query: " + searchQuery);
                request.setAttribute("toys", toyDAO.searchToys(searchQuery));
            } else if (ageGroup != null && !ageGroup.trim().isEmpty()) {
                LOGGER.info("Filtering toys by age group: " + ageGroup);
                request.setAttribute("toys", toyDAO.getToysByAgeGroup(ageGroup));
            } else {
                LOGGER.info("Getting all toys");
                request.setAttribute("toys", toyDAO.getAllToys());
            }

            // Set default cart count (implement proper cart counting later)
            request.setAttribute("cartCount", 0);

            LOGGER.info("Forwarding to " + LIST_TOYS_JSP);
            request.getRequestDispatcher(LIST_TOYS_JSP).forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing request", e);
            throw new ServletException("Error processing request", e);
        }
    }

    @Override
    public void destroy() {
        LOGGER.info("HomeServlet destroyed");
    }
}