package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.UserDAO;
import com.dietactics.presentation.model.entities.UserEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            UserEntity userEntity = UserDAO.getByUsername((String) req.getSession().getAttribute("username"));
            req.setAttribute("userEntity", userEntity);
            req.getRequestDispatcher("profile.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}