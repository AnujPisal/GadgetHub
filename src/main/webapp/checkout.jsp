<%@ page import="java.sql.*" %>
<%@ page import="servletProject.DatabaseConnectivity" %>
<%@ include file="userAuthentication.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" type="text/css" href="checkout.css">
</head>
<body>
<nav>
    <div class="nav-left">
        <a href="products">Products</a>
    </div>
    <div class="nav-center">
        <a href="cart.jsp">Cart</a>
        <a href="checkout.jsp">Checkout</a>
    </div>
    <div class="nav-right">
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </div>
</nav>



<h2 style="text-align:center;">Checkout</h2>

<%=user %>
<%
//String user = (String) session.getAttribute("currentUser");


try (Connection con = DatabaseConnectivity.getConnection()) {

    String sql = "SELECT c.quantity, p.name, p.price FROM cart c JOIN products p ON c.product_id = p.id WHERE c.username=?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, user);
    ResultSet rs = ps.executeQuery();

    if(!rs.isBeforeFirst()){
%>
<p style="text-align:center;">Your cart is empty! <a href="products">Go Shopping</a></p>
<%
    } else {
%>
<table>
<tr>
    <th>Product</th>
    <th>Price</th>
    <th>Quantity</th>
    <th>Subtotal</th>
</tr>
<%
    double total = 0;
    while(rs.next()){
        String pname = rs.getString("name");
        double price = rs.getDouble("price");
        int qty = rs.getInt("quantity");
        double subtotal = price * qty;
        total += subtotal;
%>
<tr>
    <td><%= pname %></td>
    <td><%= price %></td>
    <td><%= qty %></td>
    <td><%= subtotal %></td>
</tr>
<%
    }
%>
<tr>
    <td colspan="3"><b>Total</b></td>
    <td><b><%= total %></b></td>
</tr>
</table>

<%
    // Clear the cart after checkout
    String deleteSql = "DELETE FROM cart WHERE username=?";
    PreparedStatement deletePs = con.prepareStatement(deleteSql);
    deletePs.setString(1, user);
    deletePs.executeUpdate();
%>
<p style="text-align:center; font-size:18px; margin-top:20px;">
    Thank you for your purchase, <b><%= user %></b>! Your order has been placed.
</p>
<div style="text-align:center; margin-top:20px;">
    <a href="products" style="padding:10px 20px; background-color:#007bff; color:white; border-radius:5px; text-decoration:none;">Continue Shopping</a>
</div>
<%
    }
} catch(Exception e){ e.printStackTrace(); }
%>
</body>
</html>
