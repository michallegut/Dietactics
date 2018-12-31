package com.dietactics.presentation.model.entities;

public class UserEntity {
    private final String username;
    private String password;
    private int kilocaloriesDemand;
    private int carbohydratesDemand;
    private int fatsDemand;
    private int proteinsDemand;

    public UserEntity(String username, String password, int kilocaloriesDemand, int carbohydratesDemand, int fatsDemand, int proteinsDemand) {
        this.username = username;
        this.password = password;
        this.kilocaloriesDemand = kilocaloriesDemand;
        this.carbohydratesDemand = carbohydratesDemand;
        this.fatsDemand = fatsDemand;
        this.proteinsDemand = proteinsDemand;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getKilocaloriesDemand() {
        return kilocaloriesDemand;
    }

    public void setKilocaloriesDemand(int kilocaloriesDemand) {
        this.kilocaloriesDemand = kilocaloriesDemand;
    }

    public int getCarbohydratesDemand() {
        return carbohydratesDemand;
    }

    public void setCarbohydratesDemand(int carbohydratesDemand) {
        this.carbohydratesDemand = carbohydratesDemand;
    }

    public int getFatsDemand() {
        return fatsDemand;
    }

    public void setFatsDemand(int fatsDemand) {
        this.fatsDemand = fatsDemand;
    }

    public int getProteinsDemand() {
        return proteinsDemand;
    }

    public void setProteinsDemand(int proteinsDemand) {
        this.proteinsDemand = proteinsDemand;
    }
}