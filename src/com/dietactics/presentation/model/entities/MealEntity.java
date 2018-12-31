package com.dietactics.presentation.model.entities;

import java.util.List;
import java.util.Objects;

public class MealEntity implements Comparable<MealEntity> {
    private final int id;
    private final String username;
    private final List<ProductInclusionEntity> productInclusionEntities;
    private String name;

    public MealEntity(int id, String name, String username, List<ProductInclusionEntity> productInclusionEntities) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.productInclusionEntities = productInclusionEntities;
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

    public List<ProductInclusionEntity> getProductInclusionEntities() {
        return productInclusionEntities;
    }

    public double getKilocaloriesIn100Grams() {
        if (productInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return getKilocaloriesInWhole() / getGrams() * 100;
        }
    }

    public double getCarbohydratesIn100Grams() {
        if (productInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return getCarbohydratesInWhole() / getGrams() * 100;
        }
    }

    public double getFatsIn100Grams() {
        if (productInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return getFatsInWhole() / getGrams() * 100;
        }
    }

    public double getProteinsIn100Grams() {
        if (productInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return getProteinsInWhole() / getGrams() * 100;
        }
    }

    public double getKilocaloriesInWhole() {
        if (productInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return productInclusionEntities.stream().map(ProductInclusionEntity::getKilocalories).mapToDouble(Double::doubleValue).sum();
        }
    }

    public double getCarbohydratesInWhole() {
        if (productInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return productInclusionEntities.stream().map(ProductInclusionEntity::getCarbohydrates).mapToDouble(Double::doubleValue).sum();
        }
    }

    public double getFatsInWhole() {
        if (productInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return productInclusionEntities.stream().map(ProductInclusionEntity::getFats).mapToDouble(Double::doubleValue).sum();
        }
    }

    public double getProteinsInWhole() {
        if (productInclusionEntities.isEmpty()) {
            return 0;
        } else {
            return productInclusionEntities.stream().map(ProductInclusionEntity::getProteins).mapToDouble(Double::doubleValue).sum();
        }
    }

    public int getGrams() {
        return productInclusionEntities.stream().map(ProductInclusionEntity::getGrams).mapToInt(Integer::intValue).sum();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MealEntity that = (MealEntity) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public int compareTo(MealEntity o) {
        return this.name.toLowerCase().compareTo(o.name.toLowerCase());
    }
}