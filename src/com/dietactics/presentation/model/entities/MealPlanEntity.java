package com.dietactics.presentation.model.entities;

import java.util.List;

public class MealPlanEntity implements Comparable<MealPlanEntity> {
    private final int id;
    private final String username;
    private final List<MealInclusionEntity> mealInclusionEntities;
    private String name;

    public MealPlanEntity(int id, String name, String username, List<MealInclusionEntity> mealInclusionEntities) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.mealInclusionEntities = mealInclusionEntities;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public List<MealInclusionEntity> getMealInclusionEntities() {
        return mealInclusionEntities;
    }

    public double getKilocalories() {
        if (mealInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return mealInclusionEntities.stream().map(MealInclusionEntity::getKilocalories).mapToDouble(Double::doubleValue).sum();
        }
    }

    public double getCarbohydrates() {
        if (mealInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return mealInclusionEntities.stream().map(MealInclusionEntity::getCarbohydrates).mapToDouble(Double::doubleValue).sum();
        }
    }

    public double getFats() {
        if (mealInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return mealInclusionEntities.stream().map(MealInclusionEntity::getFats).mapToDouble(Double::doubleValue).sum();
        }
    }

    public double getProteins() {
        if (mealInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return mealInclusionEntities.stream().map(MealInclusionEntity::getProteins).mapToDouble(Double::doubleValue).sum();
        }
    }

    @Override
    public int compareTo(MealPlanEntity o) {
        return this.name.toLowerCase().compareTo(o.name.toLowerCase());
    }
}