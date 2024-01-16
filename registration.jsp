<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>

<%
    Connection conn = null;
    Statement stmt = null;

    try {
        <!-- Database configuration -->
        String url = "jdbc:mysql://cyfuse:3306/registration";
        String username = "username";
        String password = "password";
<!-- replace the username and password with your local mysql innfo and create a table users -->
        <!-- Load the JDBC driver -->
        Class.forName("com.mysql.cj.jdbc.Driver");

        <!-- Establish a connection -->
        conn = DriverManager.getConnection(url, username, password);
<!-- replace the username, url and password with your local mysql innfo and create a table users -->

        if (request.getMethod().equals("POST")) {
            String firstName = request.getParameter("first-name");
            String lastName = request.getParameter("last-name");
            String email = request.getParameter("email");
            String contactNo = request.getParameter("contact-no");
            response.sendRedirect("home.html");

            <!-- Insert data into the database -->
            String sql = "INSERT INTO users (first_name, last_name, email, contact_no) VALUES (?, ?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, firstName);
                pstmt.setString(2, lastName);
                pstmt.setString(3, email);
                pstmt.setString(4, contactNo);
                pstmt.executeUpdate();
            } catch (SQLException e) {
                out.println("Error: " + e.getMessage());
            }

            out.println("Registration successful!");
        }
    } catch (ClassNotFoundException | SQLException e) {
        out.println("Error: " + e.getMessage());
    } finally {
        <!-- Close the resources -->
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("Error: " + e.getMessage());
        }
    }
%>
