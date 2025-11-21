<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="login.css">
</head>
<body>
<nav>
    
    <a href="login.jsp">Login</a>
</nav>
<div class="form-container">
    <h2>Register</h2>
    
		    <% String error = (String) request.getAttribute("errorMessage"); %>
		<% if (error != null) { %>
		    <p style="color:red; text-align:center;"><%= error %></p>
		<% } %>
		    
    <form action="RegisterServlet" method="post">
        <label>Username:</label><br>
        <input type="text" name="username" required><br>
        <label>Password:</label><br>
        <input type="password" name="password" required><br>
        <label>Name:</label><br>
        <input type="text" name="name" required><br>
        <label>Mobile:</label><br>
        <input type="text" name="mobile"><br>
        <label>City:</label><br>
        <input type="text" name="city"><br>
        <input type="submit" value="Submit">
        <input type="reset" value="Clear">
    </form>
</div>
</body>
</html>