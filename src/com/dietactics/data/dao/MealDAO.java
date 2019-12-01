package com.dietactics.data.dao;

import com.dietactics.data.DatabaseConnector;
import com.dietactics.presentation.model.entities.MealEntity;
import com.dietactics.presentation.model.entities.ProductInclusionEntity;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MealDAO {
    public static List<MealEntity> getAllForUser(String username) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<MealEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM meals WHERE username = ?");
        preparedStatement.setString(1, username);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new MealEntity(resultSet.getInt("id"), resultSet.getString("name"), resultSet.getString("username"), ProductInclusionDAO.getAllForMeal(resultSet.getInt("id"))));
        }
        return result;
    }

    public static MealEntity getById(int id) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM meals WHERE id = ?");
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            return new MealEntity(resultSet.getInt("id"), resultSet.getString("name"), resultSet.getString("username"), ProductInclusionDAO.getAllForMeal(resultSet.getInt("id")));
        } else {
            return null;
        }
    }

    public static void create(MealEntity mealEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("INSERT INTO meals (name, username) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
        preparedStatement.setString(1, mealEntity.getName());
        preparedStatement.setString(2, mealEntity.getUsername());
        preparedStatement.executeUpdate();
        ResultSet resultSet = preparedStatement.getGeneratedKeys();
        resultSet.next();
        int mealId = resultSet.getInt(1);
        for (ProductInclusionEntity productInclusionEntity : mealEntity.getProductInclusionEntities()) {
            productInclusionEntity.setMealId(mealId);
            ProductInclusionDAO.create(productInclusionEntity);
        }
    }

    public static void update(MealEntity mealEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        ProductInclusionDAO.deleteAllForMeal(mealEntity.getId());
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("UPDATE meals SET name = ?, username = ? WHERE id = ?");
        preparedStatement.setString(1, mealEntity.getName());
        preparedStatement.setString(2, mealEntity.getUsername());
        preparedStatement.setInt(3, mealEntity.getId());
        preparedStatement.executeUpdate();
        for (ProductInclusionEntity productInclusionEntity : mealEntity.getProductInclusionEntities()) {
            productInclusionEntity.setMealId(mealEntity.getId());
            ProductInclusionDAO.create(productInclusionEntity);
        }
    }

    public static void delete(int id) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("DELETE FROM meals WHERE id = ?");
        preparedStatement.setInt(1, id);
        preparedStatement.executeUpdate();
    }
}