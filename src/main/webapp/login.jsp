<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="login.css">
</head>
<body>
<nav>
   
    <a href="register.jsp">Register</a>
</nav>
<div class="form-container">
    <h2>Login</h2>
    
		    <% String error = (String) request.getAttribute("errorMessage"); %>
		<% if (error != null) { %>
		    <p style="color:red; text-align:center;"><%= error %></p>
		<% } %>
    
    <form action="LoginServlet" method="post">
        <label>Username:</label><br>
        <input type="text" name="username" required><br>
        <label>Password:</label><br>
        <input type="password" name="password" required><br>
        <input type="submit" value="Login">
        <input type="reset" value="Clear">
    </form>
     
     
     <p class="register-link">
            New user? <a href="register.jsp">Register here</a>
        </p>
</div>
</body>
</html>