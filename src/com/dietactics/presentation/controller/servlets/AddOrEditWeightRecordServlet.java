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

@WebServlet("/addOrEditWeightRecord")
public class AddOrEditWeightRecordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String date = req.getParameter("date");
            String weight = req.getParameter("weight");
            if (date == null || date.isEmpty()) {
                resp.sendRedirect("weightDaybook?emptyFields");
            } else {
                try {
                    Date sqlDate = Date.valueOf(date);
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(sqlDate);
                    if (weight == null || weight.trim().isEmpty()) {
                        resp.sendRedirect("weightDaybook?emptyFields&month=" + (calendar.get(Calendar.MONTH) + 1) + "&year=" + calendar.get(Calendar.YEAR));
                    } else {
                        weight = weight.trim().replace(',', '.');
                        double doubleWeight = Double.parseDouble(weight);
                        String username = (String) req.getSession().getAttribute("username");
                        WeightRecordEntity weightRecordEntity = WeightRecordDAO.getByDateAndUser(sqlDate, username);
                        if (weightRecordEntity != null) {
                            weightRecordEntity.setWeight(doubleWeight);
                            WeightRecordDAO.update(weightRecordEntity);
                            resp.sendRedirect("weightDaybook?weightRecordChanged&month=" + (calendar.get(Calendar.MONTH) + 1) + "&year=" + calendar.get(Calendar.YEAR));
                        } else {
                            WeightRecordDAO.create(new WeightRecordEntity(0, doubleWeight, sqlDate, username));
                            resp.sendRedirect("weightDaybook?weightRecordAdded&month=" + (calendar.get(Calendar.MONTH) + 1) + "&year=" + calendar.get(Calendar.YEAR));
                        }
                    }
                } catch (NumberFormatException e) {
                    resp.sendRedirect("weightDaybook?textWeight");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}
