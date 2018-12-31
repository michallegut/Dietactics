package com.dietactics.presentation.model.entities;

import java.sql.Date;
import java.util.Objects;

public class MealPlanAssignmentEntity implements Comparable<MealPlanAssignmentEntity> {
    private final int id;
    private final Date date;
    private final int mealPlanId;
    private final String username;

    public MealPlanAssignmentEntity(int id, Date date, int mealPlanId, String username) {
        this.id = id;
        this.date = date;
        this.mealPlanId = mealPlanId;
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public Date getDate() {
        return date;
    }

    public int getMealPlanId() {
        return mealPlanId;
    }

    public String getUsername() {
        return username;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MealPlanAssignmentEntity that = (MealPlanAssignmentEntity) o;
        return id == that.id ||
                (Objects.equals(date, that.date) &&
                        Objects.equals(username, that.username));
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, date, username);
    }

    @Override
    public int compareTo(MealPlanAssignmentEntity o) {
        return this.date.compareTo(o.date);
    }
}