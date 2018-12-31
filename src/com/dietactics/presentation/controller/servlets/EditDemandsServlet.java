package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.UserDAO;
import com.dietactics.presentation.model.entities.UserEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

@WebServlet("/editDemands")
public class EditDemandsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String kilocaloriesDemand = req.getParameter("kilocaloriesDemand");
            String carbohydratesDemand = req.getParameter("carbohydratesDemand");
            String fatsDemand = req.getParameter("fatsDemand");
            String proteinsDemand = req.getParameter("proteinsDemand");
            if (kilocaloriesDemand == null || carbohydratesDemand == null || fatsDemand == null || proteinsDemand == null ||
                    kilocaloriesDemand.isEmpty() || carbohydratesDemand.isEmpty() || fatsDemand.isEmpty() || proteinsDemand.isEmpty()) {
                resp.sendRedirect("profile?emptyDemands");
            } else {
                int intKilocaloriesDemand;
                int intCarbohydratesDemand;
                int intFatsDemand;
                int intProteinsDemand;
                try {
                    intKilocaloriesDemand = Integer.parseInt(kilocaloriesDemand.trim());
                    intCarbohydratesDemand = Integer.parseInt(carbohydratesDemand.trim());
                    intFatsDemand = Integer.parseInt(fatsDemand.trim());
                    intProteinsDemand = Integer.parseInt(proteinsDemand.trim());
                } catch (NumberFormatException e) {
                    resp.sendRedirect("profile?textDemands");
                    return;
                }
                if (intKilocaloriesDemand < intCarbohydratesDemand * 4 + intFatsDemand * 9 + intProteinsDemand * 4) {
                    resp.sendRedirect("profile?tooLowKilocaloriesDemand");
                } else {
                    UserEntity userEntity = UserDAO.getByUsername((String) req.getSession().getAttribute("username"));
                    Objects.requireNonNull(userEntity).setKilocaloriesDemand(intKilocaloriesDemand);
                    userEntity.setCarbohydratesDemand(intCarbohydratesDemand);
                    userEntity.setFatsDemand(intFatsDemand);
                    userEntity.setProteinsDemand(intProteinsDemand);
                    UserDAO.update(userEntity);
                    resp.sendRedirect("profile?demandsChanged");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}