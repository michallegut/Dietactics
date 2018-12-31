package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealDAO;
import com.dietactics.data.dao.MealPlanDAO;
import com.dietactics.data.dao.UserDAO;
import com.dietactics.presentation.model.TemporaryModels;
import com.dietactics.presentation.model.entities.MealPlanEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addMealPlan")
public class AddMealPlanServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String username = (String) req.getSession().getAttribute("username");
            req.setAttribute("user", UserDAO.getByUsername(username));
            req.setAttribute("mealEntities", MealDAO.getAllForUser(username));
            req.getRequestDispatcher("addMealPlan.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String name = req.getParameter("name");
            if (name == null || name.isEmpty()) {
                resp.sendRedirect("addMealPlan?emptyName");
            } else {
                name = name.trim();
                if (name.length() > 50) {
                    resp.sendRedirect("addMealPlan?nameTooLong");
                } else {
                    String username = (String) req.getSession().getAttribute("username");
                    MealPlanEntity temporaryMealPlanEntity = TemporaryModels.getMealPlanEntityMap().get(username);
                    temporaryMealPlanEntity.setName(name);
                    if (temporaryMealPlanEntity.getMealInclusionEntities().isEmpty()) {
                        resp.sendRedirect("addMealPlan?noMealsAdded");
                    } else {
                        MealPlanDAO.create(temporaryMealPlanEntity);
                        resp.sendRedirect("mealPlans?mealPlanAdded");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}