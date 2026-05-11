<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up - E-Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { margin: 0; display: flex; justify-content: center; align-items: center; min-height: 100vh; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .login-card { background: white; padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 100%; max-width: 400px; text-align: center; }
        .input-group { position: relative; margin-bottom: 20px; }
        .input-group i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: #764ba2; }
        .input-group input { width: 100%; padding: 12px 12px 12px 45px; border: 1px solid #ddd; border-radius: 10px; outline: none; background: #f9f9f9; }
        .btn-reg { width: 100%; padding: 12px; background: linear-gradient(to right, #667eea, #764ba2); border: none; border-radius: 10px; color: white; font-weight: 600; cursor: pointer; transition: 0.3s; }
        .error-msg { color: #ff4757; background: #ffe0e3; padding: 10px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; }
    </style>
</head>
<body>
<div class="login-card">
    <i class="fas fa-user-plus" style="font-size: 50px; color: #764ba2; margin-bottom: 15px;"></i>
    <h2>Create Account</h2>

    <% if(request.getAttribute("errorMessage") != null) { %>
    <div class="error-msg"><i class="fas fa-exclamation-circle"></i> ${errorMessage}</div>
    <% } %>

    <form action="register" method="post">
        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" name="username" placeholder="Choose Username" required>
        </div>
        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Create Password" required>
        </div>
        <button type="submit" class="btn-reg">Register Now</button>
    </form>
    <div style="margin-top: 20px; font-size: 14px;">
        Already have an account? <a href="login.jsp" style="color: #764ba2; text-decoration: none; font-weight: 600;">Sign In</a>
    </div>
</div>
</body>
</html>