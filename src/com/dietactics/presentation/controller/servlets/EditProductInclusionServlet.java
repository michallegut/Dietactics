package com.dietactics.presentation.controller.servlets;

import com.dietactics.presentation.model.TemporaryModels;
import com.dietactics.presentation.model.entities.MealEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editProductInclusion")
public class EditProductInclusionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int amount;
            try {
                amount = Integer.parseInt(req.getParameter("amount").trim());
            } catch (NumberFormatException e) {
                resp.sendRedirect("addMeal?textAmount");
                return;
            }
            String mealName = req.getParameter("mealName");
            if (mealName == null) {
                mealName = "";
            } else {
                mealName = mealName.trim();
            }
            String username = (String) req.getSession().getAttribute("username");
            MealEntity temporaryMealEntity = TemporaryModels.getMealEntityMap().get(username);
            temporaryMealEntity.setName(mealName);
            temporaryMealEntity.getProductInclusionEntities().stream().filter(productInclusionEntity -> productInclusionEntity.getProductId() == Integer.parseInt(req.getParameter("productId"))).findFirst().ifPresent(productInclusionEntity -> productInclusionEntity.setGrams(amount));
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