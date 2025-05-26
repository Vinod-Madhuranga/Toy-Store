package com.toystore.review.util;

import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtil {
    private static final String REVIEWS_FILE = "E:Personal Projects/Online Toy Store/src/main/webapp/WEB-INF/reviews.txt";
    private static final String DELIMITER = "||";

    public static void saveReview(String reviewData) throws IOException {
        try {
            ensureFileExists();
            try (FileWriter fw = new FileWriter(REVIEWS_FILE, true);
                 BufferedWriter bw = new BufferedWriter(fw);
                 PrintWriter out = new PrintWriter(bw)) {
                out.println(reviewData);
            }
        } catch (IOException e) {
            System.err.println("Error saving review: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public static List<String> readAllReviews() throws IOException {
        try {
            ensureFileExists();
            List<String> reviews = new ArrayList<>();
            try (BufferedReader reader = new BufferedReader(new FileReader(REVIEWS_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.trim().isEmpty()) {
                        reviews.add(line);
                    }
                }
            }
            return reviews;
        } catch (IOException e) {
            System.err.println("Error reading reviews: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public static void updateReview(int id, String newReviewData) throws IOException {
        try {
            ensureFileExists();
            List<String> reviews = readAllReviews();
            List<String> updatedReviews = new ArrayList<>();

            for (String review : reviews) {
                String[] parts = parseReviewData(review);
                if (parts.length > 0 && Integer.parseInt(parts[0]) == id) {
                    updatedReviews.add(newReviewData);
                } else {
                    updatedReviews.add(review);
                }
            }

            try (PrintWriter out = new PrintWriter(new FileWriter(REVIEWS_FILE))) {
                for (String review : updatedReviews) {
                    out.println(review);
                }
            }
        } catch (IOException e) {
            System.err.println("Error updating review: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public static void deleteReview(int id) throws IOException {
        try {
            ensureFileExists();
            List<String> reviews = readAllReviews();
            List<String> remainingReviews = new ArrayList<>();

            for (String review : reviews) {
                String[] parts = parseReviewData(review);
                if (parts.length > 0 && Integer.parseInt(parts[0]) != id) {
                    remainingReviews.add(review);
                }
            }

            try (PrintWriter out = new PrintWriter(new FileWriter(REVIEWS_FILE))) {
                for (String review : remainingReviews) {
                    out.println(review);
                }
            }
        } catch (IOException e) {
            System.err.println("Error deleting review: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public static String formatReviewData(int id, String productId, String userId, int rating, 
                                        String comment, String createdAt, String updatedAt) {
        return String.join(DELIMITER, 
            String.valueOf(id),
            productId,
            userId,
            String.valueOf(rating),
            comment,
            createdAt,
            updatedAt
        );
    }

    public static String[] parseReviewData(String reviewData) {
        // First try with double pipe delimiter
        String[] parts = reviewData.split("\\|\\|");
        if (parts.length >= 7) {
            return parts;
        }
        
        // If that doesn't work, try with single pipe delimiter
        parts = reviewData.split("\\|");
        if (parts.length >= 7) {
            return parts;
        }
        
        // If neither works, return empty array
        return new String[0];
    }

    private static void ensureFileExists() throws IOException {
        try {
            File file = new File(REVIEWS_FILE);
            if (!file.exists()) {
                boolean created = file.createNewFile();
                if (!created) {
                    throw new IOException("Could not create reviews file");
                }
            }
            if (!file.canWrite()) {
                throw new IOException("Cannot write to reviews file");
            }
        } catch (IOException e) {
            System.err.println("Error ensuring file exists: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
} 