package com.dietactics.data.dao;

import com.dietactics.data.DatabaseConnector;
import com.dietactics.presentation.model.entities.ProductInclusionEntity;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductInclusionDAO {

    static List<ProductInclusionEntity> getAllForMeal(int mealId) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<ProductInclusionEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM products_inclusions WHERE meal_id = ?");
        preparedStatement.setInt(1, mealId);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new ProductInclusionEntity(resultSet.getInt("id"), resultSet.getInt("grams"), resultSet.getInt("product_id"), resultSet.getInt("meal_id"), ProductDAO.getById(resultSet.getInt("product_id"))));
        }
        return result;
    }

    public static List<ProductInclusionEntity> getAllForProduct(int productId) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<ProductInclusionEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM products_inclusions WHERE product_id = ?");
        preparedStatement.setInt(1, productId);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new ProductInclusionEntity(resultSet.getInt("id"), resultSet.getInt("grams"), resultSet.getInt("product_id"), resultSet.getInt("meal_id"), ProductDAO.getById(resultSet.getInt("product_id"))));
        }
        return result;
    }

    public static void create(ProductInclusionEntity productInclusionEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("INSERT INTO products_inclusions (grams, product_id, meal_id) VALUES (?, ?, ?)");
        preparedStatement.setInt(1, productInclusionEntity.getGrams());
        preparedStatement.setInt(2, productInclusionEntity.getProductId());
        preparedStatement.setInt(3, productInclusionEntity.getMealId());
        preparedStatement.executeUpdate();
    }

    static void deleteAllForMeal(int mealId) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("DELETE FROM products_inclusions WHERE meal_id = ?");
        preparedStatement.setInt(1, mealId);
        preparedStatement.executeUpdate();
    }

}