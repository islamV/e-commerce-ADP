package com.ecommerce.ecommerce.controller;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.ecommerce.ecommerce.model.User;
import com.ecommerce.ecommerce.service.EcommerceService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import redis.clients.jedis.Jedis;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private EcommerceService ecommerceService = new EcommerceService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isBlank()
                || password == null || password.isBlank()) {
            request.setAttribute("errorMessage", "Username and password required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            User user = ecommerceService.authenticateUser(username, password);

            if (user != null) {
                // Create redis session
                String sessionId = UUID.randomUUID().toString();
                try (Jedis jedis = new Jedis("127.0.0.1", 6379)) {
                    jedis.setex("session:" + sessionId, 3600, user.getName());
                    jedis.setex("role:" + user.getName(), 3600, user.getRole().name());

                    // Cookies for session
                    Cookie sessionCookie = new Cookie("SESSION_ID", sessionId);
                    sessionCookie.setPath("/");
                    sessionCookie.setHttpOnly(true); // Protect against XSS
                    sessionCookie.setMaxAge(3600);
                    response.addCookie(sessionCookie);
                    System.out.println("Redis session created.");
                } catch (Exception e) {
                    System.err.println("Redis is down, skipping session creation: " + e.getMessage());
                }

                //  Create JWT
                String token = JWT.create()
                        .withClaim("user", user.getName())
                        .withClaim("role", user.getRole().name())
                        .withExpiresAt(new Date(System.currentTimeMillis() + 3600000))
                        .sign(Algorithm.HMAC256("secret"));
                System.out.println(" JWT token signed.");

                // Cookies
                Cookie jwtCookie = new Cookie("JWT_TOKEN", token);
                jwtCookie.setHttpOnly(true);
                jwtCookie.setPath("/");
                jwtCookie.setHttpOnly(true);
                jwtCookie.setMaxAge(3600);
                response.addCookie(jwtCookie);

                response.sendRedirect("ProductsMain");

            }
        } catch (Exception e) {
            System.err.println( e.getMessage());
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}