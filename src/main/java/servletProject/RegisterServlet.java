package servletProject;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String city = request.getParameter("city");

        try (Connection con = DatabaseConnectivity.getConnection()) {

            String checkUser = "SELECT * FROM userss WHERE username=?";
            PreparedStatement psCheck = con.prepareStatement(checkUser);
            psCheck.setString(1, username);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                // User already exists → set message and forward back to register.jsp
                request.setAttribute("errorMessage", "Username already exists! Please choose another.");
                RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                rd.forward(request, response);

            } else {
                // Insert new user
                String sql = "INSERT INTO userss(username, password, name, mobile, city) VALUES(?,?,?,?,?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, name);
                ps.setString(4, mobile);
                ps.setString(5, city);
                ps.executeUpdate();

                // Redirect to login page after successful registration
                response.sendRedirect("login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Something went wrong. Try again.");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
        }
    }
}
