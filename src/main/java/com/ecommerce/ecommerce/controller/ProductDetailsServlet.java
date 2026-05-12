package com.ecommerce.ecommerce.controller;

import com.ecommerce.ecommerce.model.Product;
import com.ecommerce.ecommerce.model.Review;
import com.ecommerce.ecommerce.service.EcommerceService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/productDetail")
public class ProductDetailsServlet extends HttpServlet {
    private EcommerceService service = new EcommerceService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new Exception("Product ID is missing or invalid.");
            }
            int id = Integer.parseInt(idParam);

            Product product = service.getProductDetails(id);
            List<Review> productReviews = service.fetchReviewsForProduct(id);

            request.setAttribute("product", product);
            request.setAttribute("productReviews", productReviews);

            request.getRequestDispatcher("product-details.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println( e.getMessage());
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}