package com.dietactics.data.dao;

import com.dietactics.data.DatabaseConnector;
import com.dietactics.presentation.model.entities.MealPlanAssignmentEntity;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MealPlanAssignmentDAO {

    public static List<MealPlanAssignmentEntity> getAllForMealPlan(int mealPlanId) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<MealPlanAssignmentEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM meal_plans_assignments WHERE meal_plan_id = ?");
        preparedStatement.setInt(1, mealPlanId);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new MealPlanAssignmentEntity(resultSet.getInt("id"), new Date(resultSet.getDate("date").getTime()), resultSet.getInt("meal_plan_id"), resultSet.getString("username")));
        }
        return result;
    }

    public static MealPlanAssignmentEntity getByDateAndUser(Date date, String username) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM meal_plans_assignments WHERE date = ? AND username = ?");
        preparedStatement.setDate(1, new Date(date.getTime()));
        preparedStatement.setString(2, username);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            return new MealPlanAssignmentEntity(resultSet.getInt("id"), new Date(resultSet.getDate("date").getTime()), resultSet.getInt("meal_plan_id"), resultSet.getString("username"));
        } else {
            return null;
        }
    }

    public static void create(MealPlanAssignmentEntity mealPlanAssignmentEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("INSERT INTO meal_plans_assignments (date, meal_plan_id, username) VALUES (?, ?, ?)");
        preparedStatement.setDate(1, new Date(mealPlanAssignmentEntity.getDate().getTime()));
        preparedStatement.setInt(2, mealPlanAssignmentEntity.getMealPlanId());
        preparedStatement.setString(3, mealPlanAssignmentEntity.getUsername());
        preparedStatement.executeUpdate();
    }

    public static void delete(int id) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("DELETE FROM meal_plans_assignments WHERE id = ?");
        preparedStatement.setInt(1, id);
        preparedStatement.executeUpdate();
    }

    public static void deleteAllBeforeDateByUser(Date date, String username) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("DELETE FROM meal_plans_assignments WHERE date < ? AND username = ?");
        preparedStatement.setDate(1, new Date(date.getTime()));
        preparedStatement.setString(2, username);
        preparedStatement.executeUpdate();
    }
}