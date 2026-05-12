package com.ecommerce.ecommerce.controller;

import com.ecommerce.ecommerce.model.*;
import com.ecommerce.ecommerce.service.EcommerceService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ProductsMain")
public class ProductMain extends HttpServlet {
    private EcommerceService ecommerceService = new EcommerceService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String user = (String) request.getAttribute("user");
            List<Product> products = ecommerceService.getProductsWithCacheAndRateLimit(user);
            List<Review> reviews = ecommerceService.fetchAllGeneralReviews();
            request.setAttribute("data", products);
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("display-products.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}