package com.dietactics.presentation.model;

import com.dietactics.presentation.model.entities.MealEntity;
import com.dietactics.presentation.model.entities.MealPlanEntity;

import java.util.HashMap;
import java.util.Map;

public class TemporaryModels {
    private static Map<String, MealEntity> mealEntityMap;
    private static Map<String, MealPlanEntity> mealPlanEntityMap;

    public static Map<String, MealEntity> getMealEntityMap() {
        if (mealEntityMap == null) {
            mealEntityMap = new HashMap<>();
        }
        return mealEntityMap;
    }

    public static Map<String, MealPlanEntity> getMealPlanEntityMap() {
        if (mealPlanEntityMap == null) {
            mealPlanEntityMap = new HashMap<>();
        }
        return mealPlanEntityMap;
    }
}