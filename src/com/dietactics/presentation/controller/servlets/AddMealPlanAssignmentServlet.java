package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealPlanAssignmentDAO;
import com.dietactics.presentation.model.entities.MealPlanAssignmentEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/addMealPlanAssignment")
public class AddMealPlanAssignmentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String dateString = req.getParameter("date");
            Date date = Date.valueOf(dateString);
            MealPlanAssignmentDAO.create(new MealPlanAssignmentEntity(0, date, Integer.parseInt(req.getParameter("mealPlanId")), (String) req.getSession().getAttribute("username")));
            resp.sendRedirect("schedule?date=" + dateString);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}