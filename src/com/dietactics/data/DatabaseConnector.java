package com.dietactics.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {
    private static final String url = "jdbc:mysql://192.168.99.100:3306/dietactics";
    private static final String username = "user";
    private static final String password = "user";
    private static Connection connection;

    private DatabaseConnector() {
    }

    public static Connection getConnection() throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException {
        if (connection == null || !connection.isValid(5)) {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            connection = DriverManager.getConnection(url + "?serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8", username, password);
        }
        return connection;
    }
}