package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.WeightRecordDAO;
import com.dietactics.presentation.model.entities.WeightRecordEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;

@WebServlet("/deleteWeightRecord")
public class DeleteWeightRecordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String date = req.getParameter("date");
            if (date == null || date.isEmpty()) {
                resp.sendRedirect("weightDaybook?emptyFields");
            } else {
                WeightRecordEntity weightRecordEntity = WeightRecordDAO.getByDateAndUser(Date.valueOf(date), (String) req.getSession().getAttribute("username"));
                if (weightRecordEntity != null) {
                    WeightRecordDAO.delete(weightRecordEntity.getId());
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(Date.valueOf(date));
                    resp.sendRedirect("weightDaybook?weightRecordDeleted&month=" + (calendar.get(Calendar.MONTH) + 1) + "&year=" + calendar.get(Calendar.YEAR));
                } else {
                    resp.sendRedirect("weightDaybook?noWeightRecord");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}