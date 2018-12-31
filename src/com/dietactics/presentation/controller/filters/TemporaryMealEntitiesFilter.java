package com.dietactics.presentation.controller.filters;

import com.dietactics.data.dao.MealDAO;
import com.dietactics.presentation.model.TemporaryModels;
import com.dietactics.presentation.model.entities.MealEntity;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Objects;

@WebFilter("/*")
public class TemporaryMealEntitiesFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException {
        try {
            HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
            String username = (String) httpServletRequest.getSession().getAttribute("username");
            if (username != null) {
                if (TemporaryModels.getMealEntityMap().get(username) == null) {
                    if (httpServletRequest.getRequestURI().contains("addMeal")) {
                        TemporaryModels.getMealEntityMap().put(username, new MealEntity(0, "", username, new ArrayList<>()));
                    } else if (httpServletRequest.getRequestURI().contains("editMeal") && !httpServletRequest.getRequestURI().contains("Plan") && !httpServletRequest.getRequestURI().contains("Inclusion")) {
                        MealEntity mealEntity = MealDAO.getById(Integer.parseInt(httpServletRequest.getParameter("id")));
                        if (!Objects.requireNonNull(mealEntity).getUsername().equals(username)) {
                            ((HttpServletResponse) servletResponse).sendRedirect("dontSteal");
                            return;
                        }
                        TemporaryModels.getMealEntityMap().put(username, mealEntity);
                    }
                } else if (!httpServletRequest.getRequestURI().endsWith(".css") && !httpServletRequest.getRequestURI().endsWith(".js") && !httpServletRequest.getRequestURI().contains("edit") && !httpServletRequest.getRequestURI().endsWith("includeProduct") && !httpServletRequest.getRequestURI().endsWith("excludeProduct") && !httpServletRequest.getRequestURI().endsWith("addMeal")) {
                    TemporaryModels.getMealEntityMap().put(username, null);
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
