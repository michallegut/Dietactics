package com.dietactics.presentation.controller.filters;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class AccessFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;
        HttpServletResponse httpServletResponse = (HttpServletResponse) servletResponse;
        if (httpServletRequest.getSession().getAttribute("username") == null) {
            if (!httpServletRequest.getRequestURI().contains(".jsp") && (httpServletRequest.getRequestURI().endsWith(".css") || httpServletRequest.getRequestURI().endsWith(".js") || httpServletRequest.getRequestURI().endsWith(".min.map") || httpServletRequest.getRequestURI().endsWith("unexpectedError") || httpServletRequest.getRequestURI().contains("index") || httpServletRequest.getRequestURI().endsWith("login") || httpServletRequest.getRequestURI().endsWith("register"))) {
                filterChain.doFilter(servletRequest, servletResponse);
            } else {
                httpServletResponse.sendRedirect("index");
            }
        } else {
            if (httpServletRequest.getRequestURI().contains(".jsp") || httpServletRequest.getRequestURI().equals("/") || httpServletRequest.getRequestURI().endsWith("index") || httpServletRequest.getRequestURI().endsWith("login") || httpServletRequest.getRequestURI().endsWith("register")) {
                httpServletResponse.sendRedirect("profile");
            } else {
                filterChain.doFilter(servletRequest, servletResponse);
            }
        }
    }

    @Override
    public void destroy() {
    }
}