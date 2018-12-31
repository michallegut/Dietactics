<%@ page import="com.dietactics.presentation.model.TemporaryModels" %>
<%@ page import="com.dietactics.presentation.model.entities.MealEntity" %>
<%@ page import="com.dietactics.presentation.model.entities.ProductEntity" %>
<%@ page import="com.dietactics.presentation.model.entities.ProductInclusionEntity" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="layout/userHeader.jsp" %>
<div class="container">
    <h1 class="mt-4">Edytuj posiłek</h1>
    <%
        if (request.getParameter("textAmount") != null) {
    %>
    <div class="alert alert-danger mt-3" role="alert">
        Waga musi być liczbą całkowitą
    </div>
    <%
        }
    %>
    <div class="row my-4">
        <div class="col-md-6">
            <div class="card">
                <h5 class="card-header">Edytowany posiłek</h5>
                <div class="card-body">
                    <%
                        if (request.getParameter("emptyName") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Podaj nazwę posiłku
                    </div>
                    <%
                    } else if (request.getParameter("nameTooLong") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Nazwa produktu może mieć maksymalnie 50 znaków długości
                    </div>
                    <%
                    } else if (request.getParameter("noProductsAdded") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Wybierz produkty posiłku
                    </div>
                    <%
                        }
                        String username = (String) request.getSession().getAttribute("username");
                        MealEntity temporaryMealEntity = TemporaryModels.getMealEntityMap().get(username);
                    %>
                    <form action="editMeal" method="post">
                        <div class="form-group mb-4">
                            <label for="name">Nazwa</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="<c:out value='<%=temporaryMealEntity.getName()%>'/>"
                                   aria-describedby="nameHelp"
                                   placeholder="Nazwa posiłku" maxlength="50">
                            <small id="nameHelp" class="form-text text-muted">Nazwa posiłku może mieć
                                maksymalnie 50
                                znaków długości.
                            </small>
                        </div>
                        <h6>Wartości odżywcze w 100g</h6>
                        <div class="row">
                            <div class="col-6">
                                <h6>Kilokalorie:</h6>
                                <h6>Węglowodany:</h6>
                                <h6>Tłuszcze:</h6>
                                <h6>Białko:</h6>
                            </div>
                            <div class="col-6">
                                <h6><c:out
                                        value='<%=String.format("%.2f", temporaryMealEntity.getKilocaloriesIn100Grams())%>'/></h6>
                                <h6><c:out
                                        value='<%=String.format("%.2f", temporaryMealEntity.getCarbohydratesIn100Grams())%>'/>g</h6>
                                <h6><c:out value='<%=String.format("%.2f", temporaryMealEntity.getFatsIn100Grams())%>'/>g</h6>
                                <h6><c:out
                                        value='<%=String.format("%.2f", temporaryMealEntity.getProteinsIn100Grams())%>'/>g</h6>
                            </div>
                        </div>
                        <hr/>
                        <h6>Wartości odżywcze w całości (<c:out value='<%=temporaryMealEntity.getGrams()%>'/>g)</h6>
                        <div class="row">
                            <div class="col-6">
                                <h6>Kilokalorie:</h6>
                                <h6>Węglowodany:</h6>
                                <h6>Tłuszcze:</h6>
                                <h6>Białko:</h6>
                            </div>
                            <div class="col-6">
                                <h6><c:out
                                        value='<%=String.format("%.2f", temporaryMealEntity.getKilocaloriesInWhole())%>'/></h6>
                                <h6><c:out
                                        value='<%=String.format("%.2f", temporaryMealEntity.getCarbohydratesInWhole())%>'/>g</h6>
                                <h6><c:out
                                        value='<%=String.format("%.2f", temporaryMealEntity.getFatsInWhole())%>'/>g</h6>
                                <h6><c:out
                                        value='<%=String.format("%.2f", temporaryMealEntity.getProteinsInWhole())%>'/>g</h6>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Zapisz</button>
                        </div>
                    </form>
                    <h6>Produkty</h6>
                    <div class="list-group-flush">
                        <%
                            List<ProductEntity> includedProducts = new ArrayList<ProductEntity>();
                            for (ProductInclusionEntity productInclusionEntity : temporaryMealEntity.getProductInclusionEntities()) {
                                ProductEntity productEntity = productInclusionEntity.getProductEntity();
                        %>
                        <li class="list-group-item">
                            <div class="row">
                                <div class="col-7 mt-2">
                                    <h5 class="mb-1"><a
                                            href='editProduct?id=<c:out value='<%=productEntity.getId()%>'/>'><c:out
                                            value='<%=productEntity.getName()%>'/></a></h5>
                                    <small>Kilokalorie: <c:out
                                            value='<%=String.format("%.2f", productInclusionEntity.getKilocalories())%>'/>;
                                        Węglowodany:
                                        <c:out value='<%=String.format("%.2f", productInclusionEntity.getCarbohydrates())%>'/>g;
                                        Tłuszcze:
                                        <c:out value='<%=String.format("%.2f", productInclusionEntity.getFats())%>'/>g;
                                        Białko: <c:out
                                                value='<%=String.format("%.2f", productInclusionEntity.getProteins())%>'/>g
                                    </small>
                                </div>
                                <div class="col-5">
                                    <form method="post" action="editProductInclusion" class="mb-0"
                                          onsubmit='this.mealName.value=document.getElementById("name").value;'>
                                        <label>
                                            <input type="text" name="mealName" hidden>
                                        </label>
                                        <label>
                                            <input type="text" name="productId"
                                                   value='<c:out value='<%=productEntity.getId()%>'/>' hidden>
                                        </label>
                                        <div class="input-group my-2">
                                            <input type="text" class="form-control"
                                                   id="amount<c:out value='<%=productEntity.getId()%>'/>" name="amount"
                                                   placeholder="Waga"
                                                   value="<c:out value='<%=productInclusionEntity.getGrams()%>'/>">
                                            <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id='amountAppend<c:out value='<%=productEntity.getId()%>'/>"'>g</span>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-block btn-sm">Zmień</button>
                                    </form>
                                    <form method="post" action="excludeProduct"
                                          onsubmit='this.mealName.value=document.getElementById("name").value;'>
                                        <label class="d-none">
                                            <input type="text" name="mealName" hidden>
                                        </label>
                                        <label class="d-none">
                                            <input type="text" name="productId"
                                                   value='<c:out value='<%=productEntity.getId()%>'/>' hidden>
                                        </label>
                                        <button type="submit" class="btn btn-danger btn-block btn-sm">Usuń</button>
                                    </form>
                                </div>
                            </div>
                        </li>
                        <%
                                includedProducts.add(productEntity);
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <h5 class="card-header">Wybierz produkty</h5>
                <div class="card-body">
                    <div class="list-group-flush">
                        <%
                            try {
                                List<ProductEntity> productEntities = (List<ProductEntity>) request.getAttribute("productEntities");
                                Collections.sort(productEntities);
                                for (ProductEntity productEntity : productEntities) {
                                    if (!includedProducts.contains(productEntity)) {
                        %>
                        <li class="list-group-item">
                            <div class="row">
                                <div class="col-7">
                                    <h5><a href='editProduct?id=<c:out value='<%=productEntity.getId()%>'/>'><c:out
                                            value='<%=productEntity.getName()%>'/></a></h5>
                                    <small>Wartości odżywcze w 100g</small>
                                    <br/>
                                    <small class="font-weight-light">Kilokalorie: <c:out
                                            value='<%=String.format("%.2f", productEntity.getKilocalories())%>'/>;
                                        Węglowodany: <c:out
                                                value='<%=String.format("%.2f", productEntity.getCarbohydrates())%>'/>g;
                                        Tłuszcze: <c:out
                                                value='<%=String.format("%.2f", productEntity.getFats())%>'/>g;
                                        Białko <c:out
                                                value='<%=String.format("%.2f", productEntity.getProteins())%>'/>g
                                    </small>
                                </div>
                                <div class="col-5">
                                    <form method="post" action="includeProduct"
                                          onsubmit='this.mealName.value=document.getElementById("name").value;'>
                                        <label>
                                            <input type="text" name="mealName" hidden>
                                        </label>
                                        <label for="productId<c:out value='<%=productEntity.getId()%>'/>"></label><input
                                            type="text" class="form-control"
                                            id="productId<c:out value='<%=productEntity.getId()%>'/>"
                                            name="productId"
                                            value='<c:out value='<%=productEntity.getId()%>'/>' hidden>
                                        <div class="input-group my-2">
                                            <input type="text" class="form-control"
                                                   id="amount<c:out value='<%=productEntity.getId()%>'/>" name="amount"
                                                   placeholder="Waga">
                                            <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id='amountAppend<c:out value='<%=productEntity.getId()%>'/>"'>g</span>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-primary btn-block">Dodaj</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </li>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                response.sendRedirect("unexpectedError");
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="layout/footer.jsp" %>