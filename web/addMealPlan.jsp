<%@ page import="com.dietactics.presentation.model.TemporaryModels" %>
<%@ page import="com.dietactics.presentation.model.entities.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="layout/userHeader.jsp" %>
<div class="container">
    <h1 class="mt-4">Dodaj plan żywieniowy</h1>
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
                <h5 class="card-header">Nowy plan żywieniowy</h5>
                <div class="card-body">
                    <%
                        if (request.getParameter("emptyName") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Podaj nazwę planu żywieniowego
                    </div>
                    <%
                    } else if (request.getParameter("nameTooLong") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Nazwa planu żywieniowego może mieć maksymalnie 50 znaków długości
                    </div>
                    <%
                    } else if (request.getParameter("noMealsAdded") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Dodaj posiłki do planu żywieniowego
                    </div>
                    <%
                        }
                        String username = (String) request.getSession().getAttribute("username");
                        MealPlanEntity temporaryMealPlanEntity = TemporaryModels.getMealPlanEntityMap().get(username);
                        UserEntity userEntity = (UserEntity) request.getAttribute("user");
                    %>
                    <form action="addMealPlan" method="post">
                        <div class="form-group mb-4">
                            <label for="name">Nazwa</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="<c:out value='<%=temporaryMealPlanEntity.getName()%>'/>"
                                   aria-describedby="nameHelp"
                                   placeholder="Nazwa planu żywieniowego" maxlength="50">
                            <small id="nameHelp" class="form-text text-muted">Nazwa planu żywieniowego może mieć
                                maksymalnie 50
                                znaków długości.
                            </small>
                        </div>
                        <h6>Wartości odżywcze</h6>
                        <hr/>
                        <div class="row">
                            <div class="col-6">
                                <h6>Kilokalorie:</h6>
                            </div>
                            <div class="col-6">
                                <div class="progress position-relative">
                                    <div class='text-dark progress-bar bg-<%=Math.abs(temporaryMealPlanEntity.getKilocalories()-Objects.requireNonNull(userEntity).getKilocaloriesDemand()) < 100 ? "success" : "warning"%>'
                                         style='width: <c:out
                                                 value='<%=temporaryMealPlanEntity.getKilocalories()/Objects.requireNonNull(userEntity).getKilocaloriesDemand()*100%>'/>%'>
                                    </div>
                                    <div style="bottom: 3%"
                                         class="justify-content-center d-flex position-absolute w-100"><c:out
                                            value='<%=String.format("%.2f", temporaryMealPlanEntity.getKilocalories())%>'/>
                                        / <c:out
                                                value='<%=Objects.requireNonNull(userEntity).getKilocaloriesDemand()%>'/></div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <h6>Węglowodany:</h6>
                            </div>
                            <div class="col-6">
                                <div class="progress position-relative">
                                    <div class='text-dark progress-bar bg-<%=Math.abs(temporaryMealPlanEntity.getCarbohydrates()-Objects.requireNonNull(userEntity).getCarbohydratesDemand()) < 10 ? "success" : "warning"%>'
                                         style='width: <c:out
                                                 value='<%=temporaryMealPlanEntity.getCarbohydrates()/Objects.requireNonNull(userEntity).getCarbohydratesDemand()*100%>'/>%'>
                                    </div>
                                    <div style="bottom: 3%"
                                         class="justify-content-center d-flex position-absolute w-100"><c:out
                                            value='<%=String.format("%.2f", temporaryMealPlanEntity.getCarbohydrates())%>'/>g
                                        / <c:out
                                                value='<%=Objects.requireNonNull(userEntity).getCarbohydratesDemand()%>'/>g
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <h6>Tłuszcze:</h6>
                            </div>
                            <div class="col-6">
                                <div class="progress position-relative">
                                    <div class='text-dark progress-bar bg-<%=Math.abs(temporaryMealPlanEntity.getFats()-Objects.requireNonNull(userEntity).getFatsDemand()) < 10 ? "success" : "warning"%>'
                                         style='width: <c:out
                                                 value='<%=temporaryMealPlanEntity.getFats()/Objects.requireNonNull(userEntity).getFatsDemand()*100%>'/>%'>
                                    </div>
                                    <div style="bottom: 3%"
                                         class="justify-content-center d-flex position-absolute w-100"><c:out
                                            value='<%=String.format("%.2f", temporaryMealPlanEntity.getFats())%>'/>g /
                                        <c:out value='<%=Objects.requireNonNull(userEntity).getFatsDemand()%>'/>g
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <h6>Białko:</h6>
                            </div>
                            <div class="col-6">
                                <div class="progress position-relative">
                                    <div class='text-dark progress-bar bg-<%=Math.abs(temporaryMealPlanEntity.getProteins()-Objects.requireNonNull(userEntity).getProteinsDemand()) < 10 ? "success" : "warning"%>'
                                         style='width: <c:out
                                                 value='<%=temporaryMealPlanEntity.getProteins()/Objects.requireNonNull(userEntity).getProteinsDemand()*100%>'/>%'>
                                    </div>
                                    <div style="bottom: 3%"
                                         class="justify-content-center d-flex position-absolute w-100"><c:out
                                            value='<%=String.format("%.2f", temporaryMealPlanEntity.getProteins())%>'/>g
                                        / <c:out value='<%=Objects.requireNonNull(userEntity).getProteinsDemand()%>'/>g
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Zapisz</button>
                        </div>
                    </form>
                    <h6>Posiłki</h6>
                    <div class="accordion">
                        <%
                            List<MealEntity> includedMeals = new ArrayList<MealEntity>();
                            for (MealInclusionEntity mealInclusionEntity : temporaryMealPlanEntity.getMealInclusionEntities()) {
                                MealEntity mealEntity = mealInclusionEntity.getMealEntity();
                        %>
                        <div class="card">
                            <div class="card-header"
                                 id="heading<c:out value='<%=mealEntity.getId()%>'/>">
                                <div class="row" type="button btn btn-link" data-toggle="collapse"
                                     data-target="#collapse<c:out value='<%=mealEntity.getId()%>'/>"
                                     aria-expanded="true"
                                     aria-controls="collapse<c:out value='<%=mealEntity.getId()%>'/>">
                                    <div class="col-7 mt-2">
                                        <h5 class="mb-1"><a
                                                href='editMeal?id=<c:out value='<%=mealEntity.getId()%>'/>'><c:out
                                                value='<%=mealEntity.getName()%>'/></a></h5>
                                        <small>Kilokalorie: <c:out
                                                value='<%=String.format("%.2f", mealInclusionEntity.getKilocalories())%>'/>;
                                            Węglowodany:
                                            <c:out value='<%=String.format("%.2f", mealInclusionEntity.getCarbohydrates())%>'/>g;
                                            Tłuszcze:
                                            <c:out value='<%=String.format("%.2f", mealInclusionEntity.getFats())%>'/>g;
                                            Białko: <c:out
                                                    value='<%=String.format("%.2f", mealInclusionEntity.getProteins())%>'/>g
                                        </small>
                                    </div>
                                    <div class="col-5">
                                        <form method="post" action="editMealInclusion" class="mb-0"
                                              onsubmit='this.mealPlanName.value=document.getElementById("name").value;'>
                                            <label class="d-none">
                                                <input type="text" name="mealPlanName" hidden>
                                            </label>
                                            <label class="d-none">
                                                <input type="text" name="mealId"
                                                       value='<c:out value='<%=mealEntity.getId()%>'/>' hidden>
                                            </label>
                                            <div class="alert alert-primary text-center my-0 p-1">
                                                <small><c:out
                                                        value='<%=Math.round(((double)mealInclusionEntity.getGrams())/mealInclusionEntity.getMealEntity().getGrams()*100)%>'/>%
                                                    posiłku
                                                </small>
                                            </div>
                                            <div class="input-group mb-2">
                                                <input type="text" class="form-control"
                                                       id="amount<c:out value='<%=mealEntity.getId()%>'/>" name="amount"
                                                       placeholder="Waga"
                                                       value="<c:out value='<%=mealInclusionEntity.getGrams()%>'/>">
                                                <div class="input-group-append">
    <span class="input-group-text"
          id='amountAppend<c:out value='<%=mealEntity.getId()%>'/>"'>g</span>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-primary btn-block btn-sm">Zmień
                                            </button>
                                        </form>
                                        <form method="post" action="excludeMeal"
                                              onsubmit='this.mealPlanName.value=document.getElementById("name").value;'>
                                            <label class="d-none">
                                                <input type="text" name="mealPlanName" hidden>
                                            </label>
                                            <label class="d-none">
                                                <input type="text" name="mealId"
                                                       value='<c:out value='<%=mealEntity.getId()%>'/>' hidden>
                                            </label>
                                            <button type="submit" class="btn btn-danger btn-block btn-sm">Usuń</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div id="collapse<c:out value='<%=mealEntity.getId()%>'/>"
                                 class="collapse"
                                 aria-labelledby="heading<c:out value='<%=mealEntity.getId()%>'/>">
                                <div class="card-body">
                                    <h6 class="mt-0 mb-3">Produkty:</h6>
                                    <%
                                        for (ProductInclusionEntity productInclusionEntity : mealEntity.getProductInclusionEntities()) {
                                    %>
                                    <div class="row">
                                        <div class="col-4">
                                            <h6><c:out
                                                    value='<%=(int) Math.ceil(productInclusionEntity.getGrams() * (double)mealInclusionEntity.getGrams() / mealEntity.getGrams())%>'/>g</h6>
                                        </div>
                                        <div class="col-8">
                                            <h6>
                                                <a href='editProduct?id=<c:out value='<%=productInclusionEntity.getProductEntity().getId()%>'/>'><c:out
                                                        value='<%=productInclusionEntity.getProductEntity().getName()%>'/></a>
                                            </h6>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        <%
                                includedMeals.add(mealEntity);
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <h4 class="mb-4">Wybierz posiłki</h4>
            <div class="accordion">
                <%
                    boolean wasFirstMealCollapsed = false;
                    try {
                        List<MealEntity> mealEntities = (List<MealEntity>) request.getAttribute("mealEntities");
                        Collections.sort(mealEntities);
                        for (MealEntity mealEntity : mealEntities) {
                            if (!includedMeals.contains(mealEntity)) {
                %>
                <div class="card">
                    <div class="card-header"
                         id="heading<c:out value='<%=mealEntity.getId()%>'/>">
                        <div class="row" type="button btn btn-link" data-toggle="collapse"
                             data-target="#collapse<c:out value='<%=mealEntity.getId()%>'/>"
                             aria-expanded="true"
                             aria-controls="collapse<c:out value='<%mealEntity.getId()%>'/>">
                            <div class="col-7">
                                <h5><a href='editMeal?id=<c:out value='<%=mealEntity.getId()%>'/>'><c:out
                                        value='<%=mealEntity.getName()%>'/></a></h5>
                                <br/>
                                <small>Wartości odżywcze w 100g</small>
                                <br/>
                                <small class="font-weight-light">Kilokalorie: <c:out
                                        value='<%=String.format("%.2f", mealEntity.getKilocaloriesIn100Grams())%>'/>;
                                    Węglowodany: <c:out
                                            value='<%=String.format("%.2f", mealEntity.getCarbohydratesIn100Grams())%>'/>g;
                                    Tłuszcze: <c:out
                                            value='<%=String.format("%.2f", mealEntity.getFatsIn100Grams())%>'/>g;
                                    Białko <c:out
                                            value='<%=String.format("%.2f", mealEntity.getProteinsIn100Grams())%>'/>g
                                </small>
                                <br/>
                                <br/>
                                <small>Wartości odżywcze całości (<c:out value='<%=mealEntity.getGrams()%>'/>g)
                                </small>
                                <br/>
                                <small class="font-weight-light">Kilokalorie: <c:out
                                        value='<%=String.format("%.2f", mealEntity.getKilocaloriesInWhole())%>'/>;
                                    Węglowodany: <c:out
                                            value='<%=String.format("%.2f", mealEntity.getCarbohydratesInWhole())%>'/>g;
                                    Tłuszcze: <c:out
                                            value='<%=String.format("%.2f", mealEntity.getFatsInWhole())%>'/>g;
                                    Białko <c:out
                                            value='<%=String.format("%.2f", mealEntity.getProteinsInWhole())%>'/>g
                                </small>
                            </div>
                            <div class="col-5">
                                <form method="post" action="includeMeal"
                                      onsubmit='this.mealPlanName.value=document.getElementById("name").value;'>
                                    <label class="d-none">
                                        <input type="text" name="mealPlanName" hidden>
                                    </label>
                                    <label for="mealId<c:out value='<%=mealEntity.getId()%>'/>"
                                           class="d-none"></label><input
                                        type="text" class="form-control"
                                        id="mealId<c:out value='<%=mealEntity.getId()%>'/>"
                                        name="mealId"
                                        value='<c:out value='<%=mealEntity.getId()%>'/>' hidden>
                                    <div class="input-group mb-2">
                                        <input type="text" class="form-control"
                                               id="amount<c:out value='<%=mealEntity.getId()%>'/>" name="amount"
                                               placeholder="Waga">
                                        <div class="input-group-append">
    <span class="input-group-text"
          id='amountAppend<c:out value='<%=mealEntity.getId()%>'/>"'>g</span>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary btn-block">Dodaj</button>
                                    </div>
                                </form>
                                <form method="post" action="includeMeal"
                                      onsubmit='this.mealPlanName.value=document.getElementById("name").value;'>
                                    <label class="d-none">
                                        <input type="text" name="mealPlanName" hidden>
                                    </label>
                                    <label for="mealId<c:out value='<%=mealEntity.getId()%>'/>"
                                           class="d-none"></label><input
                                        type="text" class="form-control"
                                        id="mealId<c:out value='<%=mealEntity.getId()%>'/>"
                                        name="mealId"
                                        value='<c:out value='<%=mealEntity.getId()%>'/>' hidden>
                                    <label class="d-none">
                                        <input type="text" name="amount"
                                               value='<c:out value='<%=mealEntity.getGrams()%>'/>' hidden>
                                    </label>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-success btn-block">Dodaj
                                            całość<br/>(<c:out value='<%=mealEntity.getGrams()%>'/>g)
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div id="collapse<c:out value='<%=mealEntity.getId()%>'/>"
                         class="collapse<%=wasFirstMealCollapsed ? "" : " show"%>"
                         aria-labelledby="heading<c:out value='<%=mealEntity.getId()%>'/>">
                        <div class="card-body">
                            <h6 class="mt-0 mb-3">Produkty:</h6>
                            <%
                                for (ProductInclusionEntity productInclusionEntity : mealEntity.getProductInclusionEntities()) {
                            %>
                            <div class="row">
                                <div class="col-4">
                                    <h6><c:out
                                            value='<%=productInclusionEntity.getGrams()%>'/>g</h6>
                                </div>
                                <div class="col-8">
                                    <h6>
                                        <a href='editProduct?id=<c:out value='<%=productInclusionEntity.getProductEntity().getId()%>'/>'><c:out
                                                value='<%=productInclusionEntity.getProductEntity().getName()%>'/></a>
                                    </h6>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
                <%
                                wasFirstMealCollapsed = true;
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
<%@include file="layout/footer.jsp" %>