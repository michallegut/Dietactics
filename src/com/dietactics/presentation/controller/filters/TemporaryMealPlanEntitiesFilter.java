package com.dietactics.presentation.controller.filters;

import com.dietactics.data.dao.MealPlanDAO;
import com.dietactics.presentation.model.TemporaryModels;
import com.dietactics.presentation.model.entities.MealPlanEntity;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Objects;

@WebFilter("/*")
public class TemporaryMealPlanEntitiesFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException {
        try {
            HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
            String username = (String) httpServletRequest.getSession().getAttribute("username");
            if (username != null) {
                if (TemporaryModels.getMealPlanEntityMap().get(username) == null) {
                    if (httpServletRequest.getRequestURI().contains("addMealPlan")) {
                        TemporaryModels.getMealPlanEntityMap().put(username, new MealPlanEntity(0, "", username, new ArrayList<>()));
                    } else if (httpServletRequest.getRequestURI().contains("editMealPlan")) {
                        MealPlanEntity mealPlanEntity = MealPlanDAO.getById(Integer.parseInt(httpServletRequest.getParameter("id")));
                        if (!Objects.requireNonNull(mealPlanEntity).getUsername().equals(username)) {
                            ((HttpServletResponse) servletResponse).sendRedirect("dontSteal");
                            return;
                        }
                        TemporaryModels.getMealPlanEntityMap().put(username, mealPlanEntity);
                    }
                } else if (!httpServletRequest.getRequestURI().endsWith(".css") && !httpServletRequest.getRequestURI().endsWith(".js") && !httpServletRequest.getRequestURI().contains("edit") && !httpServletRequest.getRequestURI().endsWith("includeMeal") && !httpServletRequest.getRequestURI().endsWith("excludeMeal") && !httpServletRequest.getRequestURI().endsWith("addMealPlan")) {
                    TemporaryModels.getMealPlanEntityMap().put(username, null);
                }
            }
            filterChain.doFilter(servletRequest, servletResponse);
        } catch (Exception e) {
            e.printStackTrace();
            ((HttpServletResponse) servletResponse).sendRedirect("unexpectedError");
        }
    }

    @Override
    public void destroy() {
    }
}
