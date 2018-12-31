package com.dietactics.data.dao;

import com.dietactics.data.DatabaseConnector;
import com.dietactics.presentation.model.entities.ProductEntity;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public static List<ProductEntity> getAllForUser(String username) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<ProductEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM products WHERE username = ?");
        preparedStatement.setString(1, username);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new ProductEntity(resultSet.getInt("id"), resultSet.getString("name"), resultSet.getDouble("kilocalories"), resultSet.getDouble("carbohydrates"), resultSet.getDouble("fats"), resultSet.getDouble("proteins"), resultSet.getString("username")));
        }
        return result;
    }

    public static ProductEntity getById(int id) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM products WHERE id = ?");
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            return new ProductEntity(resultSet.getInt("id"), resultSet.getString("name"), resultSet.getDouble("kilocalories"), resultSet.getDouble("carbohydrates"), resultSet.getDouble("fats"), resultSet.getDouble("proteins"), resultSet.getString("username"));
        } else {
            return null;
        }
    }

    public static void create(ProductEntity productEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("INSERT INTO products (name, kilocalories, carbohydrates, fats, proteins, username) VALUES (?, ?, ?, ?, ?, ?)");
        preparedStatement.setString(1, productEntity.getName());
        preparedStatement.setDouble(2, productEntity.getKilocalories());
        preparedStatement.setDouble(3, productEntity.getCarbohydrates());
        preparedStatement.setDouble(4, productEntity.getFats());
        preparedStatement.setDouble(5, productEntity.getProteins());
        preparedStatement.setString(6, productEntity.getUsername());
        preparedStatement.executeUpdate();
    }

    public static void update(ProductEntity productEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("UPDATE products SET name = ?, kilocalories = ?, carbohydrates = ?, fats = ?, proteins = ?, username = ? WHERE id = ?");
        preparedStatement.setString(1, productEntity.getName());
        preparedStatement.setDouble(2, productEntity.getKilocalories());
        preparedStatement.setDouble(3, productEntity.getCarbohydrates());
        preparedStatement.setDouble(4, productEntity.getFats());
        preparedStatement.setDouble(5, productEntity.getProteins());
        preparedStatement.setString(6, productEntity.getUsername());
        preparedStatement.setInt(7, productEntity.getId());
        preparedStatement.executeUpdate();
    }

    public static void delete(int id) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("DELETE FROM products WHERE id = ?");
        preparedStatement.setInt(1, id);
        preparedStatement.executeUpdate();
    }
}