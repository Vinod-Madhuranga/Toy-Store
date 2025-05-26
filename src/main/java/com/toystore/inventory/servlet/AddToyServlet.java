package com.toystore.inventory.servlet;

import com.toystore.inventory.dao.ToyDAO;
import com.toystore.inventory.model.Toy;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/add-toy")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 5,   // 5 MB
        maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class AddToyServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AddToyServlet.class.getName());
    private static final String ADD_TOY_JSP = "/add-toy.jsp";
    private ToyDAO toyDAO;
    private String imagesDirPath;

    @Override
    public void init() {
        toyDAO = new ToyDAO();
        imagesDirPath = getServletContext().getRealPath("/images");
        if (imagesDirPath == null) {
            throw new IllegalStateException("Could not resolve images directory path.");
        }
        File uploadDir = new File(imagesDirPath);
        if (!uploadDir.exists()) {
            if (uploadDir.mkdirs()) {
                LOGGER.info("Created upload directory: " + uploadDir.getAbsolutePath());
            } else {
                LOGGER.warning("Failed to create upload directory: " + uploadDir.getAbsolutePath());
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(ADD_TOY_JSP).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String toyId = UUID.randomUUID().toString();
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String ageGroup = request.getParameter("ageGroup");
            if (ageGroup == null || ageGroup.trim().isEmpty()) {
                throw new ServletException("Age group is required");
            }

            Part filePart = request.getPart("image");
            String fileName = getSubmittedFileName(filePart);

            if (fileName != null && !fileName.isEmpty()) {
                String fileExtension = "";
                int lastDot = fileName.lastIndexOf('.');
                if (lastDot > 0 && lastDot < fileName.length() - 1) {
                    fileExtension = fileName.substring(lastDot);
                }

                String imageName = System.currentTimeMillis() + fileExtension;

                String fullImagePath = new File(imagesDirPath, imageName).getAbsolutePath();
                filePart.write(fullImagePath);

                LOGGER.info("Image uploaded successfully: " + imageName);

                Toy toy = new Toy(toyId, imageName, name, description, price, ageGroup);
                toyDAO.addToy(toy);

                response.sendRedirect(request.getContextPath() + "/list-toys");
            } else {
                throw new ServletException("No image file was uploaded");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error adding toy", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error adding toy: " + e.getMessage());
        }
    }

    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            String[] tokens = contentDisp.split(";");
            for (String token : tokens) {
                if (token.trim().startsWith("filename")) {
                    String fileName = token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                    return fileName.substring(fileName.lastIndexOf(File.separator) + 1);
                }
            }
        }
        return null;
    }
}
