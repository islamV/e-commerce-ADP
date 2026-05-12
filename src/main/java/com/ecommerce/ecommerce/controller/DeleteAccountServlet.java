package com.ecommerce.ecommerce.controller;


import com.ecommerce.ecommerce.service.EcommerceService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteAccount")
public class DeleteAccountServlet extends HttpServlet {
    private EcommerceService ecommerceService = new EcommerceService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String user = (String) request.getAttribute("user");
        try {
            ecommerceService.deleteUserAccount(user);
            response.sendRedirect("logout");
        } catch (Exception e) {
            response.sendRedirect("error.jsp");
        }
    }
}