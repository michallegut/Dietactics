package com.dietactics.data.dao;

import com.dietactics.data.DatabaseConnector;
import com.dietactics.presentation.model.entities.MealInclusionEntity;
import com.dietactics.presentation.model.entities.MealPlanEntity;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MealPlanDAO {
    public static List<MealPlanEntity> getAllForUser(String username) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<MealPlanEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM meal_plans WHERE username = ?");
        preparedStatement.setString(1, username);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new MealPlanEntity(resultSet.getInt("id"), resultSet.getString("name"), resultSet.getString("username"), MealInclusionDAO.getAllForMealPlan(resultSet.getInt("id"))));
        }
        return result;
    }

    public static MealPlanEntity getById(int id) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM meal_plans WHERE id = ?");
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            return new MealPlanEntity(resultSet.getInt("id"), resultSet.getString("name"), resultSet.getString("username"), MealInclusionDAO.getAllForMealPlan(resultSet.getInt("id")));
        } else {
            return null;
        }
    }

    public static void create(MealPlanEntity mealPlanEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("INSERT INTO meal_plans (name, username) VALUES (?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
        preparedStatement.setString(1, mealPlanEntity.getName());
        preparedStatement.setString(2, mealPlanEntity.getUsername());
        preparedStatement.executeUpdate();
        ResultSet resultSet = preparedStatement.getGeneratedKeys();
        resultSet.next();
        int mealPlanId = resultSet.getInt(1);
        for (MealInclusionEntity mealInclusionEntity : mealPlanEntity.getMealInclusionEntities()) {
            mealInclusionEntity.setMealPlanId(mealPlanId);
            MealInclusionDAO.create(mealInclusionEntity);
        }
    }

    public static void update(MealPlanEntity mealPlanEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        delete(mealPlanEntity.getId());
        create(mealPlanEntity);
    }

    public static void delete(int id) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("DELETE FROM meal_plans WHERE id = ?");
        preparedStatement.setInt(1, id);
        preparedStatement.executeUpdate();
    }
}