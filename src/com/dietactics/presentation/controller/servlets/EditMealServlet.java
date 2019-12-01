package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealDAO;
import com.dietactics.data.dao.ProductDAO;
import com.dietactics.presentation.model.TemporaryModels;
import com.dietactics.presentation.model.entities.MealEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editMeal")
public class EditMealServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            req.setAttribute("productEntities", ProductDAO.getAllForUser((String) req.getSession().getAttribute("username")));
            req.getRequestDispatcher("editMeal.jsp").forward(req, resp);
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
                resp.sendRedirect("editMeal?emptyName&id=" + req.getParameter("id"));
            } else {
                name = name.trim();
                if (name.length() > 50) {
                    resp.sendRedirect("editMeal?nameTooLong&id=" + req.getParameter("id"));
                } else {
                    String username = (String) req.getSession().getAttribute("username");
                    MealEntity temporaryMealEntity = TemporaryModels.getMealEntityMap().get(username);
                    temporaryMealEntity.setName(name);
                    if (temporaryMealEntity.getProductInclusionEntities().isEmpty()) {
                        resp.sendRedirect("editMeal?noProductsAdded&id=" + req.getParameter("id"));
                    } else {
                        MealDAO.update(temporaryMealEntity);
                        resp.sendRedirect("meals?mealChanged");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}