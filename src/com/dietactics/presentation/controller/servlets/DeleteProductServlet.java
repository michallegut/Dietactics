package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.ProductDAO;
import com.dietactics.data.dao.ProductInclusionDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            if (!ProductInclusionDAO.getAllForProduct(id).isEmpty()) {
                resp.sendRedirect("products?productInMeal");
            }
            ProductDAO.delete(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect("products?productDeleted");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}