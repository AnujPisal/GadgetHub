<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="servletProject.DatabaseConnectivity" %>
<%@ include file="userAuthentication.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Success</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<nav>
    <a href="product.jsp">Products</a>
    <a href="cart.jsp">Cart</a>
    <a href="logout.jsp">Logout</a>
</nav>

<h2 style="text-align:center;">Thank You for Your Order!</h2>

<%
String orderId = request.getParameter("orderId");
if (orderId != null) {
%>
<p style="text-align:center;">Your order <b>#<%= orderId %></b> has been placed successfully.</p>
<p style="text-align:center;"><a href="product.jsp">Continue Shopping</a></p>
<%
} else {
%>
<p style="text-align:center;">Something went wrong. Please try again.</p>
<%
}
%>
</body>
</html>
