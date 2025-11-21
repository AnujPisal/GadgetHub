package servletProject;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String user = (String) session.getAttribute("currentUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get product ID from form
        String productId = request.getParameter("id");
        if (productId != null && !productId.isEmpty()) {

            try (Connection con = DatabaseConnectivity.getConnection()) {

                // ✅ Check if product already exists in user's cart
                String checkSql = "SELECT quantity FROM cart WHERE username=? AND product_id=?";
                PreparedStatement checkPs = con.prepareStatement(checkSql);
                checkPs.setString(1, user);
                checkPs.setInt(2, Integer.parseInt(productId));
                ResultSet rs = checkPs.executeQuery();

                if (rs.next()) {
                    // Already exists → update quantity
                    int newQty = rs.getInt("quantity") + 1;
                    String updateSql = "UPDATE cart SET quantity=? WHERE username=? AND product_id=?";
                    PreparedStatement updatePs = con.prepareStatement(updateSql);
                    updatePs.setInt(1, newQty);
                    updatePs.setString(2, user);
                    updatePs.setInt(3, Integer.parseInt(productId));
                    updatePs.executeUpdate();
                } else {
                    // New entry → insert into DB
                    String insertSql = "INSERT INTO cart(username, product_id, quantity) VALUES (?, ?, ?)";
                    PreparedStatement insertPs = con.prepareStatement(insertSql);
                    insertPs.setString(1, user);
                    insertPs.setInt(2, Integer.parseInt(productId));
                    insertPs.setInt(3, 1);
                    insertPs.executeUpdate();
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Redirect to cart.jsp (always fetch from DB now)
        response.sendRedirect("cart.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }
}
