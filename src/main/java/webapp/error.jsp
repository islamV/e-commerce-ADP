<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
  <title>System Message - E-Store</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
    }
    .error-container {
      text-align: center;
      padding: 40px;
      border-radius: 20px;
      background: rgba(255, 255, 255, 0.95);
      box-shadow: 0 15px 35px rgba(0,0,0,0.2);
      max-width: 450px;
      width: 90%;
    }
    .icon-circle {
      width: 80px;
      height: 80px;
      background: #fff5f5;
      color: #ff4757;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 40px;
      margin: 0 auto 20px;
    }
    h1 { color: #2d3436; margin-bottom: 10px; font-size: 32px; }
    p { color: #636e72; font-size: 16px; line-height: 1.6; }
    .error-msg-box {
      font-family: 'Consolas', monospace;
      background: #f1f2f6;
      padding: 15px;
      border-radius: 10px;
      color: #ff4757;
      font-weight: bold;
      border-left: 4px solid #ff4757;
      margin: 20px 0;
      text-align: left;
      font-size: 14px;
    }
    .btn-home {
      display: inline-block;
      margin-top: 20px;
      padding: 12px 30px;
      background: #764ba2;
      color: white;
      text-decoration: none;
      border-radius: 10px;
      font-weight: 600;
      transition: 0.3s;
    }
    .btn-home:hover {
      background: #667eea;
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .footer-note { font-size: 12px; color: #a4b0be; margin-top: 20px; }
  </style>
</head>
<body>
<div class="error-container">
  <div class="icon-circle">
    <i class="fas fa-exclamation-triangle"></i>
  </div>
  <h1>System Alert</h1>
  <p>We couldn't complete your request at the moment due to the following reason:</p>

  <div class="error-msg-box">
    <i class="fas fa-bug"></i>
    <%= (request.getAttribute("errorMessage") != null) ? request.getAttribute("errorMessage") : "An unexpected internal error occurred." %>
  </div>

  <p style="font-size: 14px;">If this was a Rate Limit, please wait 5 seconds. For database issues, contact the system admin.</p>

  <a href="ProductsMain" class="btn-home"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>

  <div class="footer-note">
    Secure Backend Node | Error ID: <%= java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase() %>
  </div>
</div>
</body>
</html>