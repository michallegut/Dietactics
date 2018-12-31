package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealPlanAssignmentDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

@WebServlet("/deletePastMealPlansAssignments")
public class DeletePastMealPlansAssignmentsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Date today = Date.valueOf(new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()));
            MealPlanAssignmentDAO.deleteAllBeforeDateByUser(today, (String) req.getSession().getAttribute("username"));
            resp.sendRedirect("schedule?historyDeleted&date=" + req.getParameter("date"));
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}