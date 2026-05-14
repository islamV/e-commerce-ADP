package com.ecommerce.ecommerce.controller;

import com.ecommerce.ecommerce.service.EcommerceService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private EcommerceService ecommerceService = new EcommerceService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {

            // Validation
            if (username == null || username.isBlank()
                    || password == null || password.isBlank()) {
                throw new RuntimeException("All fields required.");
            }
            ecommerceService.createAccount(username, password);
            // If success ,Redirect to login page
            request.setAttribute("successMessage", "Account created successfully! You can login now.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            //If failed ,show error message and stay in register page
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}