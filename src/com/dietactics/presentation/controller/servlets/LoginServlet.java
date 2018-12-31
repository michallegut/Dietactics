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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String existingUsername = req.getParameter("existingUsername");
            String existingPassword = req.getParameter("existingPassword");
            if (existingUsername == null || existingPassword == null ||
                    existingUsername.isEmpty() || existingPassword.isEmpty()) {
                resp.sendRedirect("index?invalidCredentials");
            } else {
                UserEntity userEntity = UserDAO.getByUsername(existingUsername);
                if (userEntity == null || !DatatypeConverter.printHexBinary(MessageDigest.getInstance("MD5").digest((existingPassword + "S4L7").getBytes())).equals(userEntity.getPassword())) {
                    resp.sendRedirect("index?invalidCredentials");
                } else {
                    req.getSession().setAttribute("timezoneOffset", Integer.parseInt(req.getParameter("timezoneOffset")));
                    req.getSession().setAttribute("username", existingUsername);
                    resp.sendRedirect("profile");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}