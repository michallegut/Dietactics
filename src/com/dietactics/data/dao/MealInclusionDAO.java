package com.dietactics.data.dao;

import com.dietactics.data.DatabaseConnector;
import com.dietactics.presentation.model.entities.MealInclusionEntity;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MealInclusionDAO {
    static List<MealInclusionEntity> getAllForMealPlan(int mealPlanId) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<MealInclusionEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM meals_inclusions WHERE meal_plan_id = ?");
        preparedStatement.setInt(1, mealPlanId);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new MealInclusionEntity(resultSet.getInt("id"), resultSet.getInt("grams"), resultSet.getInt("meal_id"), resultSet.getInt("meal_plan_id"), MealDAO.getById(resultSet.getInt("meal_id"))));
        }
        return result;
    }

    public static List<MealInclusionEntity> getAllForMeal(int meal) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<MealInclusionEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM meals_inclusions WHERE meal_id = ?");
        preparedStatement.setInt(1, meal);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new MealInclusionEntity(resultSet.getInt("id"), resultSet.getInt("grams"), resultSet.getInt("meal_id"), resultSet.getInt("meal_plan_id"), MealDAO.getById(resultSet.getInt("meal_id"))));
        }
        return result;
    }

    public static void create(MealInclusionEntity mealInclusionEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("INSERT INTO meals_inclusions (grams, meal_id, meal_plan_id) VALUES (?, ?, ?)");
        preparedStatement.setInt(1, mealInclusionEntity.getGrams());
        preparedStatement.setInt(2, mealInclusionEntity.getMealId());
        preparedStatement.setInt(3, mealInclusionEntity.getMealPlanId());
        preparedStatement.executeUpdate();
    }

}