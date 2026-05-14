<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.ecommerce.ecommerce.model.Product" %>
<%@ page import="com.ecommerce.ecommerce.model.Review" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <% Product p = (Product) request.getAttribute("product"); %>
  <title>Details - <%= p.getName() %></title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    body { font-family: 'Segoe UI', sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; margin: 0; display: flex; align-items: center; justify-content: center; padding: 20px; }
    .main-wrapper { background: white; padding: 40px; border-radius: 25px; box-shadow: 0 20px 50px rgba(0,0,0,0.3); max-width: 550px; width: 100%; text-align: center; }
    .product-img { width: 100%; max-width: 300px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.15); margin-bottom: 25px; }
    h1 { color: #2d3436; margin: 10px 0; font-size: 32px; }
    .price { color: #2ed573; font-size: 38px; font-weight: bold; margin: 15px 0; }
    .description { color: #636e72; line-height: 1.8; margin-bottom: 30px; font-size: 16px; text-align: justify; padding: 0 10px; }

    .reviews-section { text-align: left; margin-top: 30px; padding-top: 25px; border-top: 2px solid #f1f2f6; }
    .reviews-section h3 { color: #764ba2; margin-bottom: 15px; }
    .reviews-container { max-height: 250px; overflow-y: auto; padding-right: 8px; }
    .reviews-container::-webkit-scrollbar { width: 5px; }
    .reviews-container::-webkit-scrollbar-thumb { background: #764ba2; border-radius: 10px; }

    .review-card { background: #f9f9ff; padding: 15px; margin-bottom: 12px; border-radius: 15px; border-left: 5px solid #667eea; }
    .stars { color: #ffa502; margin-bottom: 5px; }
    .back-btn { background: #764ba2; color: white; text-decoration: none; padding: 14px 40px; border-radius: 15px; font-weight: 600; display: inline-block; margin-top: 25px; transition: 0.3s; }
    .back-btn:hover { background: #667eea; transform: scale(1.05); }
  </style>
</head>
<body>
<div class="main-wrapper">
  <img src="<%= (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) ? p.getImageUrl() : "https://via.placeholder.com/300x200?text=No+Image" %>" class="product-img">
  <h1><%= p.getName() %></h1>
  <div class="price">$<%= String.format("%.2f", p.getPrice()) %></div>
  <p class="description"><%= p.getDescription() %></p>

  <div class="reviews-section">
    <h3><i class="fas fa-star"></i> Item Feedback</h3>
    <div class="reviews-container">
      <%
        List<Review> reviews = (List<Review>) request.getAttribute("productReviews");
        if(reviews != null && !reviews.isEmpty()) {
          for(Review r : reviews) {
      %>
      <div class="review-card">
        <div style="display: flex; justify-content: space-between; align-items: center;">
          <small><b><i class="fas fa-user-circle"></i> <%= r.getUsername() %></b></small>
          <div class="stars"><% for(int i=0; i<r.getRating(); i++) { %>★<% } %></div>
        </div>
        <p style="font-size: 0.9em; margin: 8px 0 0; color: #444;"><%= r.getComment() %></p>
      </div>
      <% } } else { %>
      <p style="text-align: center; color: #bbb;">No one has reviewed this yet.</p>
      <% } %>
    </div>
  </div>
  <a href="ProductsMain" class="back-btn"><i class="fas fa-arrow-left"></i> Return to Inventory</a>
</div>
</body>
</html>