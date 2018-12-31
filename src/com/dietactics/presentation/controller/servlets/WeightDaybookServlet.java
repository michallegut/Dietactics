package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.WeightRecordDAO;
import com.dietactics.presentation.model.entities.WeightRecordEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@WebServlet("/weightDaybook")
public class WeightDaybookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int timezoneOffset = (Integer) req.getSession().getAttribute("timezoneOffset");
            req.setAttribute("timezoneOffset", timezoneOffset);
            SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy-MM-dd");
            req.setAttribute("sqlFormat", sqlFormat);
            Calendar currentMonth = Calendar.getInstance();
            currentMonth.add(Calendar.MINUTE, -timezoneOffset);
            Date today = Date.valueOf(sqlFormat.format(currentMonth.getTime()));
            req.setAttribute("today", today);
            currentMonth.setTime(today);
            currentMonth.set(Calendar.DAY_OF_MONTH, 1);
            req.setAttribute("currentMonth", currentMonth);
            Calendar calendar = Calendar.getInstance();
            try {
                calendar.set(Calendar.YEAR, Integer.parseInt(req.getParameter("year")));
                calendar.set(Calendar.MONTH, Integer.parseInt(req.getParameter("month")) - 1);
                calendar.set(Calendar.DAY_OF_MONTH, 1);
            } catch (Exception e) {
                calendar = currentMonth;
            }
            req.setAttribute("calendar", calendar);
            List<WeightRecordEntity> weightRecordEntities = WeightRecordDAO.getAllForMonthYearAndUser(calendar.get(Calendar.MONTH) + 1, calendar.get(Calendar.YEAR), (String) req.getSession().getAttribute("username"));
            req.setAttribute("weightRecordEntities", weightRecordEntities);
            List<WeightRecordEntity> allWeightRecordEntities = WeightRecordDAO.getAllForUser((String) req.getSession().getAttribute("username"));
            req.setAttribute("allWeightRecordEntities", allWeightRecordEntities);
            req.getRequestDispatcher("weightDaybook.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}