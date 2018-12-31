package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.ProductDAO;
import com.dietactics.presentation.model.entities.ProductEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

@WebServlet("/editProduct")
public class EditProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            ProductEntity productEntity = ProductDAO.getById(Integer.parseInt(req.getParameter("id")));
            String username = (String) req.getSession().getAttribute("username");
            if (!Objects.requireNonNull(productEntity).getUsername().equals(username)) {
                resp.sendRedirect("dontSteal");
            } else {
                req.setAttribute("productEntity", ProductDAO.getById(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("editProduct.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
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
                resp.sendRedirect("editProduct?emptyFields&id=" + req.);
            } else {
                name = name.trim();
                kilocalories = kilocalories.trim().replace(',', '.');
                carbohydrates = carbohydrates.trim().replace(',', '.');
                fats = fats.trim().replace(',', '.');
                proteins = proteins.trim().replace(',', '.');
                if (name.length() > 50) {
                    resp.sendRedirect("editProduct?nameTooLong");
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
                        resp.sendRedirect("editProduct?textMacronutrients");
                        return;
                    }
                    if (doubleKilocalories < doubleCarbohydrates * 4 + doubleFats * 9 + doubleProteins * 4) {
                        resp.sendRedirect("editProduct?tooLowKilocalories");
                    } else if (doubleKilocalories > 900) {
                        resp.sendRedirect("editProduct?tooHighKilocalories");
                    } else if (doubleCarbohydrates + doubleFats + doubleProteins > 100) {
                        resp.sendRedirect("editProduct?tooMuchMacronutrients");
                    } else {
                        ProductDAO.update(new ProductEntity(Integer.parseInt(req.getParameter("id")), name, doubleKilocalories, doubleCarbohydrates, doubleFats, doubleProteins, (String) req.getSession().getAttribute("username")));
                        resp.sendRedirect("products?productChanged");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}