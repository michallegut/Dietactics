package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealDAO;
import com.dietactics.data.dao.MealInclusionDAO;
import com.dietactics.presentation.model.entities.MealEntity;
import com.dietactics.presentation.model.entities.MealInclusionEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/meals")
public class MealsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            List<MealEntity> mealEntities = MealDAO.getAllForUser((String) req.getSession().getAttribute("username"));
            req.setAttribute("mealEntities", mealEntities);
            Map<Integer, List<MealInclusionEntity>> mealInclusionEntities = new HashMap<>();
            for (MealEntity mealEntity : mealEntities) {
                mealInclusionEntities.put(mealEntity.getId(), MealInclusionDAO.getAllForMeal(mealEntity.getId()));
            }
            req.setAttribute("mealInclusionEntities", mealInclusionEntities);
            req.getRequestDispatcher("meals.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}