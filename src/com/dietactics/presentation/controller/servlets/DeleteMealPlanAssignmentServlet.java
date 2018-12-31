package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealPlanAssignmentDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteMealPlanAssignment")
public class DeleteMealPlanAssignmentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            MealPlanAssignmentDAO.delete(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect("schedule?date=" + req.getParameter("date"));
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}