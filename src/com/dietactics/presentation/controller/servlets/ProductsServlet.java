package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.ProductDAO;
import com.dietactics.data.dao.ProductInclusionDAO;
import com.dietactics.presentation.model.entities.ProductEntity;
import com.dietactics.presentation.model.entities.ProductInclusionEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            List<ProductEntity> productEntities = ProductDAO.getAllForUser((String) req.getSession().getAttribute("username"));
            req.setAttribute("productEntities", productEntities);
            Map<Integer, List<ProductInclusionEntity>> productInclusionEntities = new HashMap<>();
            for (ProductEntity productEntity : productEntities) {
                productInclusionEntities.put(productEntity.getId(), ProductInclusionDAO.getAllForProduct((productEntity.getId())));
            }
            req.setAttribute("productInclusionEntities", productInclusionEntities);
            req.getRequestDispatcher("products.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}