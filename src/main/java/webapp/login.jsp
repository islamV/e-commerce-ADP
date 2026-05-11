<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - Modern E-Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        .login-card h2 {
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 700;
        }
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #764ba2;
        }
        .input-group input {
            width: 100%;
            padding: 12px 12px 12px 45px;
            border: 1px solid #ddd;
            border-radius: 10px;
            outline: none;
            transition: 0.3s;
            background: #f9f9f9;
        }
        .input-group input:focus {
            border-color: #764ba2;
            box-shadow: 0 0 8px rgba(118, 75, 162, 0.2);
            background: #fff;
        }
        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(to right, #667eea, #764ba2);
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(118, 75, 162, 0.4);
        }
        .footer-links {
            margin-top: 20px;
            font-size: 14px;
            color: #666;
        }
        .footer-links a {
            color: #764ba2;
            text-decoration: none;
            font-weight: 600;
        }
        .error-msg {
            color: #ff4757;
            background: #ffe0e3;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .success-msg {
            color: #2ed573;
            background: #e3fdf0;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="login-card">
    <i class="fas fa-shopping-cart" style="font-size: 50px; color: #764ba2; margin-bottom: 15px;"></i>
    <h2>E-Store Login</h2>


    <% if(request.getAttribute("successMessage") != null) { %>
    <div class="success-msg">
        <i class="fas fa-check-circle"></i> ${successMessage}
    </div>
    <% } %>

    <% if(request.getAttribute("errorMessage") != null) { %>
    <div class="error-msg">
        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
    </div>
    <% } %>

    <form action="login" method="post">
        <div class="input-group">
            <i class="fas fa-user"></i>
            <input type="text" name="username" placeholder="Username" required>
        </div>

        <div class="input-group">
            <i class="fas fa-lock"></i>
            <input type="password" name="password" placeholder="Password" required>
        </div>

        <button type="submit" class="btn-login">Sign In</button>
    </form>

    <div class="footer-links">
        Don't have an account? <a href="register.jsp">Create one</a>
        <br><br>
    </div>
</div>
</body>
</html>