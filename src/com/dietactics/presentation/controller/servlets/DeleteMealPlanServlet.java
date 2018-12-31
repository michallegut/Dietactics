package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealPlanDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteMealPlan")
public class DeleteMealPlanServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            MealPlanDAO.delete(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect("mealPlans?mealPlanDeleted");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}