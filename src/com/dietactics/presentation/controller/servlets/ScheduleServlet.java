package com.dietactics.presentation.controller.servlets;

import com.dietactics.data.dao.MealPlanAssignmentDAO;
import com.dietactics.data.dao.MealPlanDAO;
import com.dietactics.data.dao.UserDAO;
import com.dietactics.presentation.model.entities.MealPlanAssignmentEntity;
import com.dietactics.presentation.model.entities.MealPlanEntity;
import com.dietactics.presentation.model.entities.UserEntity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

@WebServlet("/schedule")
public class ScheduleServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int timezoneOffset = (Integer) req.getSession().getAttribute("timezoneOffset");
            req.setAttribute("sqlFormat", timezoneOffset);
            SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy-MM-dd");
            req.setAttribute("sqlFormat", sqlFormat);
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.MINUTE, -timezoneOffset);
            Date today = Date.valueOf(sqlFormat.format(calendar.getTime()));
            req.setAttribute("today", today);
            Date date;
            try {
                date = Date.valueOf(req.getParameter("date"));
            } catch (Exception e) {
                date = today;
            }
            req.setAttribute("date", date);
            calendar.setTime(date);
            calendar.add(Calendar.DAY_OF_MONTH, 1);
            req.setAttribute("calendar", calendar);
            Date nextDate = new Date(calendar.getTimeInMillis());
            req.setAttribute("nextDate", nextDate);
            String username = (String) req.getSession().getAttribute("username");
            List<MealPlanEntity> mealPlanEntities = MealPlanDAO.getAllForUser(username);
            req.setAttribute("mealPlanEntities", mealPlanEntities);
            MealPlanAssignmentEntity mealPlanAssignmentEntity = MealPlanAssignmentDAO.getByDateAndUser(date, username);
            req.setAttribute("mealPlanAssignmentEntity", mealPlanAssignmentEntity);
            MealPlanEntity assignedMealPlanEntity = null;
            if (mealPlanAssignmentEntity != null) {
                assignedMealPlanEntity = MealPlanDAO.getById(mealPlanAssignmentEntity.getMealPlanId());
            }
            req.setAttribute("assignedMealPlanEntity", assignedMealPlanEntity);
            UserEntity userEntity = UserDAO.getByUsername(username);
            req.setAttribute("userEntity", userEntity);
            MealPlanAssignmentEntity nextMealPlanAssignmentEntity = MealPlanAssignmentDAO.getByDateAndUser(nextDate, username);
            req.setAttribute("nextMealPlanAssignmentEntity", nextMealPlanAssignmentEntity);
            MealPlanEntity nextAssignedMealPlanEntity = null;
            if (nextMealPlanAssignmentEntity != null) {
                nextAssignedMealPlanEntity = MealPlanDAO.getById(nextMealPlanAssignmentEntity.getMealPlanId());
            }
            req.setAttribute("nextAssignedMealPlanEntity", nextAssignedMealPlanEntity);
            req.getRequestDispatcher("schedule.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("unexpectedError");
        }
    }
}
