package com.dietactics.presentation.model.entities;

import java.util.Objects;

public class ProductInclusionEntity {
    private final int id;
    private final int productId;
    private final ProductEntity productEntity;
    private int grams;
    private int mealId;

    public ProductInclusionEntity(int id, int grams, int productId, int mealId, ProductEntity productEntity) {
        this.id = id;
        this.grams = grams;
        this.productId = productId;
        this.mealId = mealId;
        this.productEntity = productEntity;
    }

    public int getGrams() {
        return grams;
    }

    public void setGrams(int grams) {
        this.grams = grams;
    }

    public int getProductId() {
        return productId;
    }

    public int getMealId() {
        return mealId;
    }

    public void setMealId(int mealId) {
        this.mealId = mealId;
    }

    public ProductEntity getProductEntity() {
        return productEntity;
    }

    public double getKilocalories() {
        return grams * productEntity.getKilocalories() / 100;
    }

    public double getCarbohydrates() {
        return grams * productEntity.getCarbohydrates() / 100;
    }

    public double getFats() {
        return grams * productEntity.getFats() / 100;
    }

    public double getProteins() {
        return grams * productEntity.getProteins() / 100;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductInclusionEntity that = (ProductInclusionEntity) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}