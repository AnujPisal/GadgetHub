<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
<%@ page import="servletProject.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gadget Hub</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style1.css">
</head>
<body>
    <!-- Header Section -->
    <header>
        <div class="header-container">
         <a href="<%= request.getContextPath() %>/cart.jsp" class="cart-btn">🛒 Cart</a>
            <h1 class="site-title">Electronic Hub</h1>
            <a href="LogoutServlet" class="logout-btn">Logout</a>
            
        </div>
    </header>

    <!-- Product Section -->
    <main>
        <div class="product-container">
            <%
                List<Product> products = (List<Product>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
                    for (Product p : products) {
            %>
                <div class="product-card">
                    <img src="<%= request.getContextPath() %>/images/<%= p.getImage() %>" 
                         alt="<%= p.getName() %>">
                    <div class="product-details">
                        <h3><%= p.getName() %></h3>
                        <p class="desc"><%= p.getDescription() %></p>
                        <p class="price">₹ <b><%= p.getPrice() %></b></p>
                        <form action="<%= request.getContextPath() %>/cart" method="post">
                            <input type="hidden" name="id" value="<%= p.getId() %>">
                            <button type="submit" class="btn-add">🛒 Add to Cart</button>
                        </form>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <p class="no-products">No products available.</p>
            <%
                }
            %>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <p>© 2025 Electronic Hub | All Rights Reserved</p>
    </footer>
</body>
</html>