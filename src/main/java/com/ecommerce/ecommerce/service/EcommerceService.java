package com.ecommerce.ecommerce.service;


import com.ecommerce.ecommerce.DAO.ProductDAO;
import com.ecommerce.ecommerce.model.Product;
import com.ecommerce.ecommerce.model.Review;
import com.ecommerce.ecommerce.model.User;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import redis.clients.jedis.Jedis;

import java.util.ArrayList;
import java.util.List;

// Service layer inculde business logic ,caching and rate limiting
public class EcommerceService {
    private ProductDAO productDAO=new ProductDAO();
    private Gson gson=new Gson();


    public List<Product> getProductsWithCacheAndRateLimit(String user) throws Exception {
        //  Start tracking execution time
        long startTime = System.currentTimeMillis();
        try (Jedis jedis = new Jedis("127.0.0.1", 6379)) {
            String rateKey = "rate:" + (user != null ? user : "guest");

            // Rate limiting logic
            long count = jedis.incr(rateKey);
            if (count == 1) {
                // First request in window — set 10-second expiry
                jedis.expire(rateKey, 10);
            }
            if (count > 5) {
                // Request limit exceeded — reject with time remaining
                long timeLeft = jedis.ttl(rateKey);
                throw new Exception("Security Error: Too many Requests, please wait " + timeLeft + " seconds");
            }
            // Caching logic: check for cached product list in Redis
            String cachedData = jedis.get("products_cache");
            if (cachedData != null) {
                // Cache hit — return cached data without hitting the database
                long endTime = System.currentTimeMillis();
                System.out.println("(Cache hit)Fetching from Redis.");
                System.out.println(" Fetch Time: " + (endTime - startTime) + " ms");
                return gson.fromJson(cachedData, new TypeToken<ArrayList<Product>>(){}.getType());
            }
            // Cache miss — fetch from MySQL
            System.out.println("(Cache miss) Fetching from MySQL.");
            List<Product> products = productDAO.getAllProducts();
            // Store result in Redis with a 60 sec
            jedis.setex("products_cache", 60, gson.toJson(products));

            long endTime = System.currentTimeMillis();
            System.out.println("Fetch Time: " + (endTime - startTime) + " ms");

            return products;

        } catch (Exception e) {
            if (e.getMessage() != null && e.getMessage().contains("Security Error")) {
                throw e;
            }
            // fallback to  database query
            System.err.println("Redis error in Service: " + e.getMessage());
            List<Product> products = productDAO.getAllProducts();
            long endTime = System.currentTimeMillis();
            System.out.println("(Fallback) Fetch Time: " + (endTime - startTime) + " ms");
            return products;
        }
    }
    public void addProductAndClearCache(String name, float price, String desc, String img) throws Exception {
        // Validation Logic
        if (name == null || name.trim().length() < 2) throw new Exception("Invalid Input: Name too short,must be greater than 2 char.");
        if (price <= 0) throw new Exception("Invalid Input: Price must be positive.");

        if (productDAO.isProductNameExists(name.trim())) {
            throw new Exception("Product name already exists.");
        }
        productDAO.insertProduct(name.trim(), price, desc, img);
        System.out.println("Product added. Invalidating cache...");
        clearCache(); // clearing old cache
    }

    public User authenticateUser(String username, String password) throws Exception {
        System.out.println(" login for: " + username);
        User user = productDAO.findUser(username, password);
        if (user == null) throw new Exception(" Invalid credentials.");
        return user;
    }

    public void createAccount(String username, String password) throws Exception {
        if (username == null || username.trim().length() < 3) {
            throw new Exception(" Username must be at least 3 characters.");
        }
        // Password Complexity Validation
        if (password == null || password.length() < 8) {
            throw new Exception("Password must be at least 8 characters long.");
        }
        String passwordPattern = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=!]).*$";
        if (!password.matches(passwordPattern)) {
            throw new Exception(" Password must contain at least one uppercase letter, one digit, and one special character (@#$%^&+=!).");
        }
        System.out.println(" Registering new user: " + username);

        productDAO.registerUser(username.trim(), password, "USER");
    }

  
    private void clearCache() {
        try (Jedis jedis = new Jedis("127.0.0.1", 6379)) {
            jedis.del("products_cache");
            System.out.println(" Redis cache cleared successfully.");
        } catch (Exception e) {
            System.err.println("Failed to clear Redis cache: " + e.getMessage());
        }
    }
    // Helper methods
    public Product getProductDetails(int id) throws Exception
    { return productDAO.getProductById(id);
    }
    public List<Review> fetchReviewsForProduct(int productId) throws Exception {

        return productDAO.getReviewsByProductId(productId); }
    public List<Review> fetchAllGeneralReviews() throws Exception {
        return productDAO.getAllReviews(); }
    public void deleteProductAndClearCache(int id) throws Exception {
        productDAO.removeProduct(id); clearCache(); }
    public void deleteUserAccount(String username) throws Exception {
        productDAO.removeUser(username);
        try (Jedis jedis = new Jedis("localhost", 6379)) {
            jedis.del("rate:" + username);
            jedis.del("role:" + username);
        }
    }


}