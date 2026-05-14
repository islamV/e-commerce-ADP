package com.ecommerce.ecommerce.DAO;

import com.ecommerce.ecommerce.model.Role;
import com.ecommerce.ecommerce.model.User;
import com.ecommerce.ecommerce.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;

public class UserDAO {


    // Authenticate user
    public User findUser(String username, String password) {

        String query = "SELECT * FROM users WHERE username=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");
                    if (BCrypt.checkpw(password, storedHash)) {
                        return new User(
                                rs.getInt("id"),
                                rs.getString("username"),
                                storedHash,
                                Role.valueOf(rs.getString("role").toUpperCase())
                        );
                    }
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
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            ps.setString(2, hashedPassword);
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
        String query = "DELETE FROM users WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query))  {
            ps.setString(1, username);
            ps.executeUpdate();
            System.out.println("User account deleted: " + username);
        } catch (SQLException e) {
            System.err.println("Failed to delete user '" + username + "': " + e.getMessage());
            throw new RuntimeException("Failed to delete account.");
        }
    }
}
