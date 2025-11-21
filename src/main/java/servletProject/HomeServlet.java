package servletProject;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session != null && session.getAttribute("currentUser") != null) {
            response.sendRedirect("product.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
