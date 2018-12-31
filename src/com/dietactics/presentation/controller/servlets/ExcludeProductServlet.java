package com.dietactics.presentation.controller.servlets;

import com.dietactics.presentation.model.TemporaryModels;
import com.dietactics.presentation.model.entities.MealEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/excludeProduct")
public class ExcludeProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String mealName = req.getParameter("mealName");
            if (mealName == null) {
                mealName = "";
            } else {
                mealName = mealName.trim();
            }
            String username = (String) req.getSession().getAttribute("username");
            MealEntity temporaryMealEntity = TemporaryModels.getMealEntityMap().get(username);
            temporaryMealEntity.setName(mealName);
            temporaryMealEntity.getProductInclusionEntities().removeIf(p -> p.getProductId() == Integer.parseInt(req.getParameter("productId")));
            if (temporaryMealEntity.getId() == 0) {
                resp.sendRedirect("addMeal");
            } else {
                resp.sendRedirect("editMeal");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}