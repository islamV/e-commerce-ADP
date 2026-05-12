package com.ecommerce.ecommerce.controller;

import com.ecommerce.ecommerce.service.EcommerceService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/manageProduct")
public class ProductManagementServlet extends HttpServlet {
    private EcommerceService ecommerceService = new EcommerceService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            // Check authority for admin
            String role = (String) request.getAttribute("role");
            if (!"ADMIN".equals(role)) {
                throw new Exception(" Only administrators can perform this action.");
            }
            String action = request.getParameter("action");
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String priceStr = request.getParameter("price");
                String desc = request.getParameter("description");
                String img = request.getParameter("imageUrl");
                // Validate price
                float price = (priceStr != null && !priceStr.isEmpty()) ? Float.parseFloat(priceStr) : 0.0f;
                ecommerceService.addProductAndClearCache(name, price, desc, img);

            } else if ("delete".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam != null) {
                    ecommerceService.deleteProductAndClearCache(Integer.parseInt(idParam));
                }
            }

            response.sendRedirect("ProductsMain");

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
}