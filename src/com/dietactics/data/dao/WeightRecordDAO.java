package com.dietactics.data.dao;

import com.dietactics.data.DatabaseConnector;
import com.dietactics.presentation.model.entities.WeightRecordEntity;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WeightRecordDAO {

    public static List<WeightRecordEntity> getAllForUser(String username) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<WeightRecordEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM weight_records WHERE username = ?");
        preparedStatement.setString(1, username);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new WeightRecordEntity(resultSet.getInt("id"), resultSet.getDouble("weight"), resultSet.getDate("date"), resultSet.getString("username")));
        }
        return result;
    }

    public static List<WeightRecordEntity> getAllForMonthYearAndUser(int month, int year, String username) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        List<WeightRecordEntity> result = new ArrayList<>();
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM weight_records WHERE MONTH(date) = ? AND YEAR(date) = ? AND username = ?");
        preparedStatement.setInt(1, month);
        preparedStatement.setInt(2, year);
        preparedStatement.setString(3, username);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            result.add(new WeightRecordEntity(resultSet.getInt("id"), resultSet.getDouble("weight"), resultSet.getDate("date"), resultSet.getString("username")));
        }
        return result;
    }

    public static WeightRecordEntity getByDateAndUser(Date date, String username) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM weight_records WHERE date = ? AND username = ?");
        preparedStatement.setDate(1, new Date(date.getTime()));
        preparedStatement.setString(2, username);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            return new WeightRecordEntity(resultSet.getInt("id"), resultSet.getDouble("weight"), resultSet.getDate("date"), resultSet.getString("username"));
        } else {
            return null;
        }
    }

    public static void create(WeightRecordEntity weightRecordEntity) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("INSERT INTO weight_records (weight, date, username) VALUES (?, ?, ?)");
        preparedStatement.setDouble(1, weightRecordEntity.getWeight());
        preparedStatement.setDate(2, new Date(weightRecordEntity.getDate().getTime()));
        preparedStatement.setString(3, weightRecordEntity.getUsername());
        preparedStatement.executeUpdate();
    }

    public static void update(WeightRecordEntity weightRecordEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("UPDATE weight_records SET weight = ?, date = ?, username = ? WHERE id = ?");
        preparedStatement.setDouble(1, weightRecordEntity.getWeight());
        preparedStatement.setDate(2, new Date(weightRecordEntity.getDate().getTime()));
        preparedStatement.setString(3, weightRecordEntity.getUsername());
        preparedStatement.setInt(4, weightRecordEntity.getId());
        preparedStatement.executeUpdate();
    }

    public static void delete(int id) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("DELETE FROM weight_records WHERE id = ?");
        preparedStatement.setInt(1, id);
        preparedStatement.executeUpdate();
    }
}