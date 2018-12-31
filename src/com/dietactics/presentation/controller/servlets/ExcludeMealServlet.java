package com.dietactics.presentation.controller.servlets;

import com.dietactics.presentation.model.TemporaryModels;
import com.dietactics.presentation.model.entities.MealPlanEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/excludeMeal")
public class ExcludeMealServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String mealPlanName = req.getParameter("mealPlanName");
            if (mealPlanName == null) {
                mealPlanName = "";
            } else {
                mealPlanName = mealPlanName.trim();
            }
            String username = (String) req.getSession().getAttribute("username");
            MealPlanEntity temporaryMealPlanEntity = TemporaryModels.getMealPlanEntityMap().get(username);
            temporaryMealPlanEntity.setName(mealPlanName);
            temporaryMealPlanEntity.getMealInclusionEntities().removeIf(d -> d.getMealId() == Integer.parseInt(req.getParameter("mealId")));
            if (temporaryMealPlanEntity.getId() == 0) {
                resp.sendRedirect("addMealPlan");
            } else {
                resp.sendRedirect("editMealPlan");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}