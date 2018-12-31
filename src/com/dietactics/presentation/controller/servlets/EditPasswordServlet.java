package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.UserDAO;
import com.dietactics.presentation.model.entities.UserEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

@WebServlet("/editPassword")
public class EditPasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String password = req.getParameter("password");
            String passwordConfirmation = req.getParameter("passwordConfirmation");
            if (password == null || passwordConfirmation == null ||
                    password.isEmpty() || passwordConfirmation.isEmpty()) {
                resp.sendRedirect("profile?emptyPasswords");
            } else if (password.contains(" ")) {
                resp.sendRedirect("profile?whitespaceCharacters");
            } else if (!password.equals(passwordConfirmation)) {
                resp.sendRedirect("profile?mismatchedPasswords");
            } else if (password.length() < 8 || password.length() > 20) {
                resp.sendRedirect("profile?incorrectPasswordLength");
            } else {
                UserEntity userEntity = UserDAO.getByUsername((String) req.getSession().getAttribute("username"));
                Objects.requireNonNull(userEntity).setPassword(password);
                UserDAO.update(userEntity);
                resp.sendRedirect("profile?passwordChanged");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}