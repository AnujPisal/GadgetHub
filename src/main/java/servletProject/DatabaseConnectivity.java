package servletProject;


import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnectivity {

    private static final String URL = "jdbc:mysql://localhost:3306/anuj";
    private static final String USER = "root";
    private static final String PASSWORD = "mysql@123";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
