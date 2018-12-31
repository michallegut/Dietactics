package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.ProductDAO;
import com.dietactics.presentation.model.TemporaryModels;
import com.dietactics.presentation.model.entities.MealEntity;
import com.dietactics.presentation.model.entities.ProductInclusionEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/includeProduct")
public class IncludeProductServlet extends HttpServlet {
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
            int productId = Integer.parseInt(req.getParameter("productId"));
            temporaryMealEntity.getProductInclusionEntities().add(new ProductInclusionEntity(0, amount, productId, 0, ProductDAO.getById(productId)));
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