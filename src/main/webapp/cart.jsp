<%@ page import="java.sql.*" %>
<%@ page import="servletProject.DatabaseConnectivity" %>
<%@ include file="userAuthentication.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="login.css">
    <style>
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #f9f9f9;
            box-shadow: 0px 4px 8px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background: #007bff;
            color: white;
        }
        img {
            border-radius: 5px;
        }
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-remove {
            background-color: #dc3545;
            color: white;
        }
        .btn-checkout {
            background-color: #28a745;
            color: white;
            font-size: 16px;
            padding: 10px 20px;
            display: inline-block;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<nav>
    <a href="products">Products</a>
    <a href="cart.jsp">Cart</a>
    <a href="checkout.jsp">Checkout</a>
    <a href="logout.jsp">Logout</a>
</nav>

<h2 style="text-align:center;">Your Shopping Cart</h2>

<%


if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

try (Connection con = DatabaseConnectivity.getConnection()) {
    String sql = "SELECT p.id, p.name, p.price, p.image, c.quantity " +
                 "FROM cart c JOIN products p ON c.product_id = p.id WHERE c.username=?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, user);
    ResultSet rs = ps.executeQuery();

    if(!rs.isBeforeFirst()) {
%>
    <p style="text-align:center; font-size:18px;">Your cart is empty! 
        <a href="product.jsp">Go Shopping</a>
    </p>
<%
    } else {
%>
<table>
    <tr>
        <th>Image</th>
        <th>Product</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Subtotal</th>
        <th>Action</th>
    </tr>
<%
    double total = 0;
    while(rs.next()) {
        double subtotal = rs.getDouble("price") * rs.getInt("quantity");
        total += subtotal;
%>
    <tr>
        <td><img src="images/<%= rs.getString("image") %>" width="80" height="80"></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td><%= rs.getInt("quantity") %></td>
        <td><%= subtotal %></td>
        <td>
            <form action="removeFromCart" method="post" style="display:inline;">
                <input type="hidden" name="productId" value="<%= rs.getInt("id") %>">
                <button type="submit" class="btn btn-remove">Remove</button>
            </form>
        </td>
    </tr>
<%
    } // while loop
%>
    <tr>
        <td colspan="4" style="text-align:right;"><b>Total</b></td>
        <td colspan="2"><b><%= total %></b></td>
    </tr>
</table>

<div style="text-align:center;">
    <a href="checkout.jsp" class="btn btn-checkout">Proceed to Checkout</a>
</div>

<%
    }
} catch(Exception e) { 
    e.printStackTrace(); 
}
%>

</body>
</html>
