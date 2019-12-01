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

@WebServlet("/editMealPlan")
public class EditMealPlanServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String username = (String) req.getSession().getAttribute("username");
            req.setAttribute("user", UserDAO.getByUsername(username));
            req.setAttribute("mealEntities", MealDAO.getAllForUser(username));
            req.getRequestDispatcher("editMealPlan.jsp").forward(req, resp);
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
                resp.sendRedirect("editMealPlan?emptyName&id=" + req.getParameter("id"));
            } else {
                name = name.trim();
                if (name.length() > 50) {
                    resp.sendRedirect("editMealPlan?nameTooLong&id=" + req.getParameter("id"));
                } else {
                    String username = (String) req.getSession().getAttribute("username");
                    MealPlanEntity temporaryMealPlanEntity = TemporaryModels.getMealPlanEntityMap().get(username);
                    temporaryMealPlanEntity.setName(name);
                    if (temporaryMealPlanEntity.getMealInclusionEntities().isEmpty()) {
                        resp.sendRedirect("editMealPlan?noMealsAdded&id=" + req.getParameter("id"));
                    } else {
                        MealPlanDAO.update(temporaryMealPlanEntity);
                        resp.sendRedirect("mealPlans?mealPlanChanged&id=" + req.getParameter("id"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}