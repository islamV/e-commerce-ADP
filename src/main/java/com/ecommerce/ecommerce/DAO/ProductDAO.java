package com.ecommerce.ecommerce.DAO;


import com.ecommerce.ecommerce.model.Product;
import com.ecommerce.ecommerce.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// For all interaction with MySql and implement Logging for monitoring DB and errors
public class ProductDAO {


    // To fetch all products
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM product_cards";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(new Product(
                        rs.getInt("id"),
                        rs.getFloat("price"),
                        rs.getString("item"),
                        rs.getString("description"),
                        rs.getString("image_url")
                ));
            }
            System.out.println(" Fetched " + products.size() + " products successfully.");
        } catch (SQLException e) {
            System.err.println("Failed to fetch products: " + e.getMessage());
            throw new RuntimeException(" Unable to retrieve inventory.");
        }
        return products;
    }

    // To add new Product
    public void insertProduct(String name, float price, String description, String imageUrl) {
        String query = "INSERT INTO product_cards (item, price, description, image_url) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, name);
            ps.setFloat(2, price);
            ps.setString(3, description);
            ps.setString(4, imageUrl);
            ps.executeUpdate();
            System.out.println(" New product inserted: " + name);
        } catch (SQLException e) {
            System.err.println("Insert failed for product '" + name + "': " + e.getMessage());
            throw new RuntimeException("Could not save product.");
        }
    }
    // Find product by Id
    public Product getProductById(int id) {
        String query = "SELECT * FROM product_cards WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Product(
                            rs.getInt("id"),
                            rs.getFloat("price"),
                            rs.getString("item"),
                            rs.getString("description"),
                            rs.getString("image_url")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println(" Error fetching product ID " + id + ": " + e.getMessage());
        }
        return null;
    }


    // helper method for validate is product name exist
    public boolean isProductNameExists(String name) {
        String query = "SELECT COUNT(*) FROM product_cards WHERE item = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println(" Name check failed: " + e.getMessage());
        }
        return false;
    }

   // For Remove product
    public void removeProduct(int id) {
        String query = "DELETE FROM product_cards WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Product ID " + id + " deleted.");
        } catch (SQLException e) {
            System.err.println("Delete failed for ID " + id + ": " + e.getMessage());
            throw new RuntimeException("Could not delete product.");
        }
    }


}