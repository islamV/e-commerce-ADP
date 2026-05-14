package com.ecommerce.ecommerce.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import redis.clients.jedis.Jedis;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String sessionId = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("SESSION_ID".equals(c.getName())) {
                    sessionId = c.getValue();
                }
            }
        }
        if (sessionId != null) {
            try (Jedis jedis = new Jedis("127.0.0.1", 6379)) {
                jedis.del("session:" + sessionId);
                System.out.println("Delete session from redis");
            } catch (Exception e) {
                System.err.println( e.getMessage());
                request.setAttribute("errorMessage", e.getMessage());
                try {
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                } catch (Exception ex) {
                    response.sendRedirect("error.jsp");
                }
            }
        }

        Cookie sessionCookie = new Cookie("SESSION_ID", "");
        sessionCookie.setMaxAge(0);
        sessionCookie.setPath("/");
        response.addCookie(sessionCookie);

        Cookie jwtCookie = new Cookie("JWT_TOKEN", "");
        jwtCookie.setMaxAge(0);
        jwtCookie.setPath("/");
        response.addCookie(jwtCookie);
        response.sendRedirect("login.jsp");
    }
}