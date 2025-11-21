package servletProject;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/placeOrder")
public class OrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("currentUser");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve form data
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String payment = request.getParameter("payment");

        // Get cart from session
        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        double totalAmount = cart.stream().mapToDouble(p -> p.getPrice()).sum();

        try (Connection con = DatabaseConnectivity.getConnection()) {

            // 1️⃣ Insert into orders table
            String orderSql = "INSERT INTO orders (username, fullname, address, payment_method, total_amount) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psOrder = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            psOrder.setString(1, username);
            psOrder.setString(2, fullname);
            psOrder.setString(3, address);
            psOrder.setString(4, payment);
            psOrder.setDouble(5, totalAmount);
            psOrder.executeUpdate();

            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // 2️⃣ Insert items into order_items table
            String itemSql = "INSERT INTO order_items (order_id, product_id, product_name, quantity, price) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psItem = con.prepareStatement(itemSql);

            for (Product p : cart) {
                psItem.setInt(1, orderId);
                psItem.setInt(2, p.getId());
                psItem.setString(3, p.getName());
                psItem.setInt(4, 1); // quantity = 1 (update if you track quantity separately)
                psItem.setDouble(5, p.getPrice());
                psItem.addBatch();
            }
            psItem.executeBatch();

            // 3️⃣ Clear cart session
            session.removeAttribute("cart");

            // 4️⃣ Redirect to order success page
            response.sendRedirect("orderSuccess.jsp?orderId=" + orderId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp");
        }
    }
}
