package com.toystore.review.dao;

import com.toystore.review.model.Review;
import com.toystore.review.util.FileUtil;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ReviewDAO {
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
    
    public void createReview(Review review) throws IOException {
        String reviewData = FileUtil.formatReviewData(
            getNextId(),
            review.getProductId(),
            review.getUserId(),
            review.getRating(),
            review.getComment(),
            dateFormat.format(new Date()),
            dateFormat.format(new Date())
        );
        FileUtil.saveReview(reviewData);
    }
    
    public Review getReview(int id) throws IOException {
        List<String> reviews = FileUtil.readAllReviews();
        for (String reviewData : reviews) {
            String[] parts = FileUtil.parseReviewData(reviewData);
            if (parts.length > 0 && Integer.parseInt(parts[0]) == id) {
                return createReviewFromParts(parts);
            }
        }
        return null;
    }
    
    public List<Review> getReviewsByProduct(String productId) throws IOException {
        List<Review> reviews = new ArrayList<>();
        List<String> allReviews = FileUtil.readAllReviews();
        
        for (String reviewData : allReviews) {
            String[] parts = FileUtil.parseReviewData(reviewData);
            if (parts.length > 1 && parts[1].equals(productId)) {
                reviews.add(createReviewFromParts(parts));
            }
        }
        return reviews;
    }
    
    public void updateReview(Review review) throws IOException {
        String reviewData = FileUtil.formatReviewData(
            review.getId(),
            review.getProductId(),
            review.getUserId(),
            review.getRating(),
            review.getComment(),
            dateFormat.format(review.getCreatedAt()),
            dateFormat.format(new Date())
        );
        FileUtil.updateReview(review.getId(), reviewData);
    }
    
    public void deleteReview(int id) throws IOException {
        FileUtil.deleteReview(id);
    }
    
    public List<Review> getAllReviews() throws IOException {
        List<Review> reviews = new ArrayList<>();
        List<String> allReviews = FileUtil.readAllReviews();
        for (String reviewData : allReviews) {
            String[] parts = FileUtil.parseReviewData(reviewData);
            if (parts.length > 0) {
                reviews.add(createReviewFromParts(parts));
            }
        }
        return reviews;
    }
    
    private Review createReviewFromParts(String[] parts) {
        if (parts.length < 7) return null; // skip invalid lines
        Review review = new Review();
        try {
            review.setId(Integer.parseInt(parts[0]));
            review.setProductId(parts[1]);
            review.setUserId(parts[2]);
            review.setRating(Integer.parseInt(parts[3]));
            review.setComment(parts[4]);
            review.setCreatedAt(dateFormat.parse(parts[5]));
            review.setUpdatedAt(dateFormat.parse(parts[6]));
        } catch (Exception e) {
            // skip this review if any error occurs
            return null;
        }
        return review;
    }
    
    private int getNextId() throws IOException {
        List<String> reviews = FileUtil.readAllReviews();
        int maxId = 0;
        for (String reviewData : reviews) {
            String[] parts = FileUtil.parseReviewData(reviewData);
            if (parts.length > 0) {
                try {
                    int id = Integer.parseInt(parts[0]);
                    maxId = Math.max(maxId, id);
                } catch (NumberFormatException e) {
                    // Skip invalid IDs
                    continue;
                }
            }
        }
        return maxId + 1;
    }
} 