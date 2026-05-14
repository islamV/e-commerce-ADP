package com.ecommerce.ecommerce.DAO;

import com.ecommerce.ecommerce.model.Review;
import com.ecommerce.ecommerce.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {


    // Retrieve review based on productId
    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews WHERE product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    reviews.add(new Review(
                            rs.getString("username"),
                            rs.getString("comment"),
                            rs.getInt("rating"),
                            rs.getInt("product_id")
                    ));
                }
            }
            System.out.println("Loaded " + reviews.size() + " reviews for Product ID: " + productId);
        } catch (SQLException e) {
            System.err.println("Failed to load reviews: " + e.getMessage());
        }
        return reviews;
    }

    // Retrieve all reviews for homePage
    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                reviews.add(new Review(
                        rs.getString("username"),
                        rs.getString("comment"),
                        rs.getInt("rating"),
                        rs.getInt("product_id")
                ));
            }
        } catch (SQLException e) {
            System.err.println("reviews fetch failed: " + e.getMessage());
        }
        return reviews;
    }



}




