package com.dietactics.presentation.model.entities;

import java.util.Objects;

public class ProductEntity implements Comparable<ProductEntity> {
    private final int id;
    private final String name;
    private final double kilocalories;
    private final double carbohydrates;
    private final double fats;
    private final double proteins;
    private final String username;

    public ProductEntity(int id, String name, double kilocalories, double carbohydrates, double fats, double proteins, String username) {
        this.id = id;
        this.name = name;
        this.kilocalories = kilocalories;
        this.carbohydrates = carbohydrates;
        this.fats = fats;
        this.proteins = proteins;
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getKilocalories() {
        return kilocalories;
    }

    public double getCarbohydrates() {
        return carbohydrates;
    }

    public double getFats() {
        return fats;
    }

    public double getProteins() {
        return proteins;
    }

    public String getUsername() {
        return username;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ProductEntity that = (ProductEntity) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public int compareTo(ProductEntity o) {
        return this.name.toLowerCase().compareTo(o.name.toLowerCase());
    }
}