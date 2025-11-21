package servletProject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/removeFromCart")
public class RemoveFromCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String currentUser = (String) session.getAttribute("currentUser");
        String productIdStr = request.getParameter("productId");

        if (productIdStr == null || productIdStr.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        int productId = Integer.parseInt(productIdStr);

        try (Connection con = DatabaseConnectivity.getConnection()) {

            // 🔹 Step 1: Get current quantity
            String checkSql = "SELECT quantity FROM cart WHERE username = ? AND product_id = ?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, currentUser);
            checkPs.setInt(2, productId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                int quantity = rs.getInt("quantity");

                if (quantity > 1) {
                    // 🔹 Step 2a: Reduce quantity by 1
                    String updateSql = "UPDATE cart SET quantity = quantity - 1 WHERE username = ? AND product_id = ?";
                    PreparedStatement updatePs = con.prepareStatement(updateSql);
                    updatePs.setString(1, currentUser);
                    updatePs.setInt(2, productId);
                    updatePs.executeUpdate();
                } else {
                    // 🔹 Step 2b: Remove product completely
                    String deleteSql = "DELETE FROM cart WHERE username = ? AND product_id = ?";
                    PreparedStatement deletePs = con.prepareStatement(deleteSql);
                    deletePs.setString(1, currentUser);
                    deletePs.setInt(2, productId);
                    deletePs.executeUpdate();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the cart page
        response.sendRedirect("cart.jsp");
    }
}
