package com.dietactics.presentation.model.entities;

public class MealInclusionEntity {
    private final int id;
    private final int mealId;
    private final MealEntity mealEntity;
    private int grams;
    private int mealPlanId;

    public MealInclusionEntity(int id, int grams, int mealId, int mealPlanId, MealEntity mealEntity) {
        this.id = id;
        this.grams = grams;
        this.mealId = mealId;
        this.mealPlanId = mealPlanId;
        this.mealEntity = mealEntity;
    }

    public int getGrams() {
        return grams;
    }

    public void setGrams(int grams) {
        this.grams = grams;
    }

    public int getMealId() {
        return mealId;
    }

    public int getMealPlanId() {
        return mealPlanId;
    }

    public void setMealPlanId(int mealPlanId) {
        this.mealPlanId = mealPlanId;
    }

    public MealEntity getMealEntity() {
        return mealEntity;
    }

    public double getKilocalories() {
        return grams * mealEntity.getKilocaloriesIn100Grams() / 100;
    }

    public double getCarbohydrates() {
        return grams * mealEntity.getCarbohydratesIn100Grams() / 100;
    }

    public double getFats() {
        return grams * mealEntity.getFatsIn100Grams() / 100;
    }

    public double getProteins() {
        return grams * mealEntity.getProteinsIn100Grams() / 100;
    }
}