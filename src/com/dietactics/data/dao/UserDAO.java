package com.dietactics.data.dao;

import com.dietactics.data.DatabaseConnector;
import com.dietactics.presentation.model.entities.UserEntity;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public static UserEntity getByUsername(String username) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("SELECT * FROM users WHERE username = ?");
        preparedStatement.setString(1, username);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            return new UserEntity(resultSet.getString("username"), resultSet.getString("password"), resultSet.getInt("kilocalories_demand"), resultSet.getInt("carbohydrates_demand"), resultSet.getInt("fats_demand"), resultSet.getInt("proteins_demand"));
        } else {
            return null;
        }
    }

    public static void create(UserEntity userEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("INSERT INTO users VALUES ( ?, ?, ?, ?, ?, ?)");
        preparedStatement.setString(1, userEntity.getUsername());
        preparedStatement.setString(2, userEntity.getPassword());
        preparedStatement.setInt(3, userEntity.getKilocaloriesDemand());
        preparedStatement.setInt(4, userEntity.getCarbohydratesDemand());
        preparedStatement.setInt(5, userEntity.getFatsDemand());
        preparedStatement.setInt(6, userEntity.getProteinsDemand());
        preparedStatement.executeUpdate();
    }

    public static void update(UserEntity userEntity) throws ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        PreparedStatement preparedStatement = DatabaseConnector.getConnection().prepareStatement("UPDATE users SET username = ?, password = ?, kilocalories_demand = ?, carbohydrates_demand = ?, fats_demand = ?, proteins_demand = ? WHERE username = ?");
        preparedStatement.setString(1, userEntity.getUsername());
        preparedStatement.setString(2, userEntity.getPassword());
        preparedStatement.setInt(3, userEntity.getKilocaloriesDemand());
        preparedStatement.setInt(4, userEntity.getCarbohydratesDemand());
        preparedStatement.setInt(5, userEntity.getFatsDemand());
        preparedStatement.setInt(6, userEntity.getProteinsDemand());
        preparedStatement.setString(7, userEntity.getUsername());
        preparedStatement.executeUpdate();
    }
}