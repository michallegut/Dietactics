package com.dietactics.presentation.controller.servlets;

import com.dietactics.presentation.model.TemporaryModels;
import com.dietactics.presentation.model.entities.MealPlanEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editMealInclusion")
public class EditMealInclusionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int amount;
            try {
                amount = Integer.parseInt(req.getParameter("amount").trim());
            } catch (NumberFormatException e) {
                resp.sendRedirect("addMealPlan?textAmount");
                return;
            }
            String mealPlanName = req.getParameter("mealPlanName");
            if (mealPlanName == null) {
                mealPlanName = "";
            } else {
                mealPlanName = mealPlanName.trim();
            }
            String username = (String) req.getSession().getAttribute("username");
            MealPlanEntity temporaryMealPlanEntity = TemporaryModels.getMealPlanEntityMap().get(username);
            temporaryMealPlanEntity.setName(mealPlanName);
            temporaryMealPlanEntity.getMealInclusionEntities().stream().filter(mealInclusionEntity -> mealInclusionEntity.getMealId() == Integer.parseInt(req.getParameter("mealId"))).findFirst().ifPresent(mealInclusionEntity -> mealInclusionEntity.setGrams(amount));
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