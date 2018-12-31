package com.dietactics.presentation.model.entities;

import java.sql.Date;

public class WeightRecordEntity implements Comparable<WeightRecordEntity> {
    private final int id;
    private final Date date;
    private final String username;
    private double weight;

    public WeightRecordEntity(int id, double weight, Date date, String username) {
        this.id = id;
        this.weight = weight;
        this.date = date;
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public Date getDate() {
        return date;
    }

    public String getUsername() {
        return username;
    }

    @Override
    public int compareTo(WeightRecordEntity o) {
        return this.date.compareTo(o.date);
    }
}