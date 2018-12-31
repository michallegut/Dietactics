package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteMeal")
public class DeleteMealServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            MealDAO.delete(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect("meals?mealDeleted");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}