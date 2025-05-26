package com.toystore.review.servlet;

import com.toystore.review.dao.ReviewDAO;
import com.toystore.review.model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/review/*")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Show reviews list
            List<Review> reviews;
            String productId = request.getParameter("productId");
            if (productId != null && !productId.trim().isEmpty()) {
                reviews = reviewDAO.getReviewsByProduct(productId);
            } else {
                reviews = reviewDAO.getAllReviews();
            }
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/reviews.jsp").forward(request, response);
            return;
        }

        if (pathInfo.startsWith("/edit/")) {
            // Show edit form
            String[] splits = pathInfo.split("/");
            if (splits.length == 3) {
                int reviewId = Integer.parseInt(splits[2]);
                Review review = reviewDAO.getReview(reviewId);
                if (review != null) {
                    request.setAttribute("review", review);
                    request.getRequestDispatcher("/edit-review.jsp").forward(request, response);
                    return;
                }
            }
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Review not found");
            return;
        }

        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String methodOverride = request.getParameter("_method");
        
        if ("PUT".equalsIgnoreCase(methodOverride)) {
            handlePut(request, response);
            return;
        }
        
        if ("DELETE".equalsIgnoreCase(methodOverride)) {
            handleDelete(request, response);
            return;
        }

        // Handle new review creation
        try {
            Review review = new Review();
            review.setProductId(request.getParameter("productId"));
            review.setUserId(request.getParameter("userId"));
            review.setRating(Integer.parseInt(request.getParameter("rating")));
            review.setComment(request.getParameter("comment"));
            
            reviewDAO.createReview(review);
            response.sendRedirect(request.getContextPath() + "/review");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error creating review: " + e.getMessage());
        }
    }

    private void handlePut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Review ID is required");
            return;
        }

        try {
            String[] splits = pathInfo.split("/");
            if (splits.length != 2) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid review ID");
                return;
            }

            int reviewId = Integer.parseInt(splits[1]);
            Review review = new Review();
            review.setId(reviewId);
            review.setProductId(request.getParameter("productId"));
            review.setUserId(request.getParameter("userId"));
            review.setRating(Integer.parseInt(request.getParameter("rating")));
            review.setComment(request.getParameter("comment"));
            
            // Preserve original creation date
            Review oldReview = reviewDAO.getReview(reviewId);
            if (oldReview != null) {
                review.setCreatedAt(oldReview.getCreatedAt());
            }
            
            reviewDAO.updateReview(review);
            response.sendRedirect(request.getContextPath() + "/review");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating review");
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Review ID is required");
            return;
        }

        try {
            String[] splits = pathInfo.split("/");
            if (splits.length != 2) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid review ID");
                return;
            }

            int reviewId = Integer.parseInt(splits[1]);
            reviewDAO.deleteReview(reviewId);
            response.sendRedirect(request.getContextPath() + "/review");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting review");
        }
    }
} 