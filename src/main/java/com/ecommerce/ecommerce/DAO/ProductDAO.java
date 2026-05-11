package com.ecommerce.ecommerce.DAO;


import com.ecommerce.ecommerce.model.Product;
import com.ecommerce.ecommerce.model.Review;
import com.ecommerce.ecommerce.model.Role;
import com.ecommerce.ecommerce.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// For all interaction with MySql and implement Logging for monitoring DB and errors
public class ProductDAO {

    // Database Configuration
    private static final String url = "jdbc:mysql://localhost:3306/products?useSSL=false";
    private static final String dbUsername = "root";
    private static final String dbPassword = "root";

    // To load  mySQL Driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found: " + e.getMessage());
        }
    }

    // To fetch all products
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM product_cards";
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
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
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
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
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
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

    // Retrieve review based on productId
    public List<Review> getReviewsByProductId(int productId) {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM reviews WHERE product_id = ?";
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
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
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM reviews")) {
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

    // helper method for validate if product name exists
    public boolean isProductNameExists(String name) {
        String query = "SELECT COUNT(*) FROM product_cards WHERE item = ?";
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
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

    // To Remove product
    public void removeProduct(int id) {
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement ps = conn.prepareStatement("DELETE FROM product_cards WHERE id = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("Product ID " + id + " deleted.");
        } catch (SQLException e) {
            System.err.println("Delete failed for ID " + id + ": " + e.getMessage());
            throw new RuntimeException("Could not delete product.");
        }
    }



    // Authenticate user
    public User findUser(String username, String password) {
        String query = "SELECT * FROM users WHERE username=? AND password=?";
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println(" User found: " + username);
                    return new User(
                            rs.getInt("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            Role.valueOf(rs.getString("role").toUpperCase())
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("authentication query failed: " + e.getMessage());
        }
        return null;
    }

    // Register new user
    public void registerUser(String username, String password, String role) {
        String query = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role.toUpperCase());
            ps.executeUpdate();
            System.out.println(" New user registered: " + username);

        } catch (SQLException e) {
            if (e.getErrorCode() == 1062) { // MySQL Duplicate Entry Error Code
                throw new RuntimeException("This username is already taken. Please choose another one.");
            }
            System.err.println(" Registration failed: " + e.getMessage());
            throw new RuntimeException(" Could not create account.");
        }
    }

    // For remove user
    public void removeUser(String username) {
        try (Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
             PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE username = ?")) {
            ps.setString(1, username);
            ps.executeUpdate();
            System.out.println("User account deleted: " + username);
        } catch (SQLException e) {
            System.err.println("Failed to delete user '" + username + "': " + e.getMessage());
            throw new RuntimeException("Failed to delete account.");
        }
    }





}