package com.toystore.inventory.servlet;

import com.toystore.inventory.dao.ToyDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/list-toys")
public class ListToysServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(ListToysServlet.class.getName());
    private ToyDAO toyDAO;
    private static final String LIST_TOYS_JSP = "/list-toys.jsp";
    private static final String IMAGES_DIR_RELATIVE = "/images";

    @Override
    public void init() {
        toyDAO = new ToyDAO();
        ensureImagesDirectoryExists();
    }

    private void ensureImagesDirectoryExists() {
        String imagesPath = getServletContext().getRealPath(IMAGES_DIR_RELATIVE);
        File imagesDir = new File(imagesPath);
        if (!imagesDir.exists()) {
            if (imagesDir.mkdirs()) {
                LOGGER.info("Created images directory: " + imagesPath);
            } else {
                LOGGER.warning("Failed to create images directory: " + imagesPath);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            LOGGER.info("Processing list-toys request");
            String searchQuery = request.getParameter("search");

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                LOGGER.info("Searching for toys with query: " + searchQuery);
                request.setAttribute("toys", toyDAO.searchToys(searchQuery));
            } else {
                LOGGER.info("Getting all toys");
                request.setAttribute("toys", toyDAO.getAllToys());
            }

            String imagesUrlPath = request.getContextPath() + IMAGES_DIR_RELATIVE + "/";
            request.setAttribute("imagesPath", imagesUrlPath);

            LOGGER.info("Forwarding to " + LIST_TOYS_JSP);
            request.getRequestDispatcher(LIST_TOYS_JSP).forward(request, response);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error in ListToysServlet", e);
            throw new ServletException("Error in ListToysServlet", e);
        }
    }
}
