<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="userAuthentication.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h2 style="text-align:center;">Thank you, <%= user %>!</h2>
    <p style="text-align:center;">Your order has been placed successfully.</p>
    <div style="text-align:center;">
        <a href="product.jsp" class="btn btn-checkout">Continue Shopping</a>
    </div>
</body>
</html>