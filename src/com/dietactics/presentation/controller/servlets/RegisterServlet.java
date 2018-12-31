package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.UserDAO;
import com.dietactics.presentation.model.entities.UserEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;
import java.io.IOException;
import java.security.MessageDigest;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String newUsername = req.getParameter("newUsername");
            String newPassword = req.getParameter("newPassword");
            String passwordConfirmation = req.getParameter("passwordConfirmation");
            String kilocaloriesDemand = req.getParameter("kilocaloriesDemand");
            String carbohydratesDemand = req.getParameter("carbohydratesDemand");
            String fatsDemand = req.getParameter("fatsDemand");
            String proteinsDemand = req.getParameter("proteinsDemand");
            if (newUsername == null || newPassword == null || passwordConfirmation == null || kilocaloriesDemand == null || carbohydratesDemand == null || fatsDemand == null || proteinsDemand == null ||
                    newUsername.isEmpty() || newPassword.isEmpty() || passwordConfirmation.isEmpty() || kilocaloriesDemand.isEmpty() || carbohydratesDemand.isEmpty() || fatsDemand.isEmpty() || proteinsDemand.isEmpty()) {
                resp.sendRedirect("index?emptyRegisterFields");
            } else if (newUsername.contains(" ") || newPassword.contains(" ")) {
                resp.sendRedirect("index?whitespaceCharacters");
            } else if (newUsername.length() > 20 || newPassword.length() > 20) {
                resp.sendRedirect("index?tooLong");
            } else if (!newPassword.equals(passwordConfirmation)) {
                resp.sendRedirect("index?mismatchedPasswords");
            } else if (newPassword.length() < 8) {
                resp.sendRedirect("index?passwordTooShort");
            } else if (UserDAO.getByUsername(newUsername) != null) {
                resp.sendRedirect("index?takenUsername");
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
                    resp.sendRedirect("index?textDemands");
                    return;
                }
                if (intKilocaloriesDemand < intCarbohydratesDemand * 4 + intFatsDemand * 9 + intProteinsDemand * 4) {
                    resp.sendRedirect("index?tooLowKilocaloriesDemand");
                } else {
                    UserDAO.create(new UserEntity(newUsername, DatatypeConverter.printHexBinary(MessageDigest.getInstance("MD5").digest((newPassword + "S4L7").getBytes())), intKilocaloriesDemand, intCarbohydratesDemand, intFatsDemand, intProteinsDemand));
                    req.getSession().setAttribute("timezoneOffset", Integer.parseInt(req.getParameter("timezoneOffset")));
                    req.getSession().setAttribute("username", newUsername);
                    resp.sendRedirect("profile");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}