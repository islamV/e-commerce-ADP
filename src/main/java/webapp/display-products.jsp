<%@ page import="com.ecommerce.ecommerce.model.Product" %>
<%@ page import="com.ecommerce.ecommerce.model.Review" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>E-Store Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; margin: 0; background: #f0f2f5; color: #333; }
        .top-bar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }
        .card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); margin-bottom: 30px; }
        h3 { color: #764ba2; border-left: 5px solid #667eea; padding-left: 15px; margin-bottom: 20px; }

        .error-alert {
            color: #ff4757; background: #ffe0e3; padding: 15px; border-radius: 12px; margin-bottom: 20px;
            border-left: 6px solid #ff4757; display: flex; align-items: center; gap: 10px; animation: shake 0.5s ease-in-out;
        }
        @keyframes shake { 0%, 100% { transform: translateX(0); } 25% { transform: translateX(-5px); } 75% { transform: translateX(5px); } }

        .admin-form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .input-style { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; outline: none; transition: 0.3s; }
        .input-style:focus { border-color: #764ba2; box-shadow: 0 0 5px rgba(118,75,162,0.2); }
        .full-width { grid-column: span 2; }
        .btn-add { background: #764ba2; color: white; border: none; padding: 12px; border-radius: 8px; cursor: pointer; font-weight: bold; grid-column: span 2; transition: 0.3s; }
        .btn-add:hover { background: #667eea; transform: translateY(-2px); }

        table { width: 100%; border-collapse: collapse; border-radius: 10px; overflow: hidden; }
        th { background: #f8f9fa; padding: 15px; text-align: left; color: #764ba2; }
        td { padding: 15px; border-bottom: 1px solid #f0f0f0; }
        .product-link { color: #667eea; text-decoration: none; font-weight: bold; }
        .btn-delete { color: #ff4757; text-decoration: none; font-weight: 600; }
        .logout-btn { background: rgba(255,255,255,0.2); color: white; padding: 8px 15px; text-decoration: none; border-radius: 8px; font-weight: 600; }

        .review-card { background: #f9f9ff; padding: 15px; border-radius: 10px; margin-bottom: 15px; border: 1px solid #eee; border-left: 4px solid #764ba2; }
        .stars { color: #ffa502; }
    </style>
</head>
<body>

<div class="top-bar">
    <div><i class="fas fa-user-circle"></i> Welcome, <b>${user}</b> (${role})</div>
    <div>
        <a href="deleteAccount" onclick="return confirm('🚨 Are you sure you want to delete your account permanently?')" style="color: #ffcccc; text-decoration: none; margin-right: 20px; font-size: 0.9em;">Delete Account</a>
        <a href="logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Sign Out</a>
    </div>
</div>

<div class="container">
    <% String role = (String) request.getAttribute("role"); %>

    <% if(request.getAttribute("errorMessage") != null) { %>
    <div class="error-alert">
        <i class="fas fa-exclamation-triangle"></i>
        <span><b>Oops!</b> ${errorMessage}</span>
    </div>
    <% } %>

    <% if("ADMIN".equals(role)) { %>
    <div class="card" style="border: 1px dashed #764ba2; background: #fffbff;">
        <h3><i class="fas fa-plus-circle"></i> Add New Product</h3>
        <form action="manageProduct?action=add" method="post" class="admin-form-grid">
            <input type="text" name="name" class="input-style" placeholder="Item Name" required>
            <input type="number" step="0.01" name="price" class="input-style" placeholder="Price ($)" required>
            <input type="text" name="description" class="input-style full-width" placeholder="Detailed Description">
            <input type="text" name="imageUrl" class="input-style full-width" placeholder="Image URL">
            <button type="submit" class="btn-add">Save to Inventory</button>
        </form>
    </div>
    <% } %>

    <div class="card">
        <h3><i class="fas fa-boxes"></i> Available Products</h3>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Product> products = (List<Product>) request.getAttribute("data");
                if (products != null && !products.isEmpty()) {
                    for(Product p : products) {
            %>
            <tr>
                <td>#<%= p.getId() %></td>
                <td><a href="productDetail?id=<%= p.getId() %>" class="product-link"><%= p.getName() %></a></td>
                <td><b style="color: #2ed573;">$<%= String.format("%.2f", p.getPrice()) %></b></td>
                <td>
                    <% if("ADMIN".equals(role)) { %>
                    <a href="manageProduct?action=delete&id=<%= p.getId() %>" class="btn-delete" onclick="return confirm('Are you sure you want to remove this product?')"><i class="fas fa-trash"></i></a>
                    <% } else { %>
                    <span style="color: #ccc;"><i class="fas fa-lock"></i> View Only</span>
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="4" style="text-align: center; color: #999;">No products found in inventory.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <div class="card">
        <h3><i class="fas fa-comments"></i> Customer Reviews</h3>
        <div class="reviews-list">
            <%
                List<Review> allReviews = (List<Review>) request.getAttribute("reviews");
                if (allReviews != null && !allReviews.isEmpty()) {
                    for(Review r : allReviews) {
            %>
            <div class="review-card">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <b><i class="fas fa-user"></i> <%= r.getUsername() %></b>
                    <span class="stars">
                        <% for(int i=0; i<r.getRating(); i++) { %> ★ <% } %>
                    </span>
                </div>
                <p style="margin: 10px 0 5px; color: #555;"><%= r.getComment() %></p>
                <small style="color: #999; font-size: 0.8em;">For Product ID: #<%= r.getProductId() %></small>
            </div>
            <%
                }
            } else {
            %>
            <p style="text-align: center; color: #999; padding: 20px;">No reviews available at the moment.</p>
            <% } %>
        </div>
    </div>

</div>

</body>
</html>