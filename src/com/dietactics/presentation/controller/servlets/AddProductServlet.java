package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.ProductDAO;
import com.dietactics.presentation.model.entities.ProductEntity;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addProduct")
public class AddProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("addProduct.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String name = req.getParameter("name");
            String kilocalories = req.getParameter("kilocalories");
            String carbohydrates = req.getParameter("carbohydrates");
            String fats = req.getParameter("fats");
            String proteins = req.getParameter("proteins");
            if (name == null || kilocalories == null || carbohydrates == null || fats == null || proteins == null ||
                    name.isEmpty() || kilocalories.isEmpty() || carbohydrates.isEmpty() || fats.isEmpty() || proteins.isEmpty()) {
                resp.sendRedirect("addProduct?emptyFields");
            } else {
                name = name.trim();
                kilocalories = kilocalories.trim().replace(',', '.');
                carbohydrates = carbohydrates.trim().replace(',', '.');
                fats = fats.trim().replace(',', '.');
                proteins = proteins.trim().replace(',', '.');
                if (name.length() > 50) {
                    resp.sendRedirect("addProduct?nameTooLong");
                } else {
                    double doubleKilocalories;
                    double doubleCarbohydrates;
                    double doubleFats;
                    double doubleProteins;
                    try {
                        doubleKilocalories = Double.parseDouble(kilocalories);
                        doubleCarbohydrates = Double.parseDouble(carbohydrates);
                        doubleFats = Double.parseDouble(fats);
                        doubleProteins = Double.parseDouble(proteins);
                    } catch (NumberFormatException e) {
                        resp.sendRedirect("addProduct?textMacronutrients");
                        return;
                    }
                    if (doubleKilocalories < doubleCarbohydrates * 4 + doubleFats * 9 + doubleProteins * 4) {
                        resp.sendRedirect("addProduct?tooLowKilocalories");
                    } else if (doubleKilocalories > 900) {
                        resp.sendRedirect("addProduct?tooHighKilocalories");
                    } else if (doubleCarbohydrates + doubleFats + doubleProteins > 100) {
                        resp.sendRedirect("addProduct?tooMuchMacronutrients");
                    } else {
                        ProductDAO.create(new ProductEntity(0, name, doubleKilocalories, doubleCarbohydrates, doubleFats, doubleProteins, (String) req.getSession().getAttribute("username")));
                        resp.sendRedirect("products?productAdded");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}