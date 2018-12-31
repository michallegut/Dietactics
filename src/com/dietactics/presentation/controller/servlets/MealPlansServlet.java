package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealPlanAssignmentDAO;
import com.dietactics.data.dao.MealPlanDAO;
import com.dietactics.data.dao.UserDAO;
import com.dietactics.presentation.model.entities.MealPlanAssignmentEntity;
import com.dietactics.presentation.model.entities.MealPlanEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/mealPlans")
public class MealPlansServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String username = (String) req.getSession().getAttribute("username");
            List<MealPlanEntity> mealPlanEntities = MealPlanDAO.getAllForUser(username);
            req.setAttribute("mealPlanEntities", mealPlanEntities);
            req.setAttribute("userEntity", UserDAO.getByUsername(username));
            Map<Integer, List<MealPlanAssignmentEntity>> mealPlanAssignmentEntities = new HashMap<>();
            for (MealPlanEntity mealPlanEntity : mealPlanEntities) {
                mealPlanAssignmentEntities.put(mealPlanEntity.getId(), MealPlanAssignmentDAO.getAllForMealPlan(mealPlanEntity.getId()));
            }
            req.setAttribute("mealPlanAssignmentEntities", mealPlanAssignmentEntities);
            req.getRequestDispatcher("mealPlans.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}