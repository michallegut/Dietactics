    <%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
        <%@ page contentType="text/html;charset=UTF-8" %>
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="Michał Legut">
        <title>Twoja taktyka dietetyczna - Dietactics</title>
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        </head>
        <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
        <a class="navbar-brand" href="profile">Dietactics</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive"
        aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
        <li class="nav-item<%=request.getRequestURI().contains("profile") ? " active" : ""%>">
        <a class="nav-link" href="profile">Profil
        </a>
        </li>
        <li class="nav-item<%=request.getRequestURI().toLowerCase().contains("product") ? " active" : ""%>">
        <a class="nav-link" href="products">Produkty</a>
        </li>
        <li
        class="nav-item<%=request.getRequestURI().toLowerCase().contains("meal") && !request.getRequestURI().toLowerCase().contains("plan") ? " active" : ""%>
        ">
        <a class="nav-link" href="meals">Posiłki</a>
        </li>
        <li class="nav-item<%=request.getRequestURI().toLowerCase().contains("mealplan") ? " active" : ""%>">
        <a class="nav-link" href="mealPlans">Plany żywieniowe</a>
        </li>
        <li class="nav-item<%=request.getRequestURI().contains("schedule") ? " active" : ""%>">
        <a class="nav-link" href="schedule">Rozpiska</a>
        </li>
        <li class="nav-item<%=request.getRequestURI().contains("weightDaybook") ? " active" : ""%>">
        <a class="nav-link" href="weightDaybook">Dziennik wagi</a>
        </li>
        <li class="nav-item">
        <a class="nav-link" href="logout">Wyloguj
        <c:out value='<%=" (" + request.getSession().getAttribute("username")+ ")"%>'/>
        </a>
        </li>
        </ul>
        </div>
        </div>
        </nav>