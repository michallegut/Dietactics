<%@ page import="com.dietactics.presentation.model.entities.MealEntity" %>
<%@ page import="com.dietactics.presentation.model.entities.MealInclusionEntity" %>
<%@ page import="com.dietactics.presentation.model.entities.ProductInclusionEntity" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="layout/userHeader.jsp" %>
<div class="container">
    <h1 class="mt-4">Posiłki</h1>
    <div class="row mt-4">
        <div class="col-lg-3 col-lg-push-12 mb-4">
            <form method="get" action="addMeal">
                <button type="submit" class="btn btn-success btn-block">Dodaj posiłek</button>
            </form>
            <div class="card">
                <h5 class="card-header">Filtry</h5>
                <div class="card-body">
                    <form action="meals" method="get">
                        <div class="form-group">
                            <label for="name">Nazwa posiłku lub produktu</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="<c:out value='<%=request.getParameter("name") != null ? request.getParameter("name") : ""%>'/>"
                                   placeholder="Tekst zawarty w nazwie">
                        </div>
                        <div class="form-group align-content-between">
                            <label>Kontekst</label>
                            <br/>
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-secondary active">
                                    <input type="radio" name="amount" value="100Grams" id="100Grams" autocomplete="off"
                                           checked> 100g
                                </label>
                                <label class="btn btn-secondary">
                                    <input type="radio" name="amount" value="Whole" id="Whole" autocomplete="off">
                                    Całość
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="kilocaloriesFrom">Zakres kilokalorii</label>
                            <div>
                                <input type="text" class="form-control d-inline col-5" id="kilocaloriesFrom"
                                       name="kilocaloriesFrom"
                                       value="<c:out value='<%=request.getParameter("kilocaloriesFrom") != null ? request.getParameter("kilocaloriesFrom") : ""%>'/>"
                                       placeholder="Od">
                                <input type="text" class="form-control d-inline col-5" id="kilocaloriesTo"
                                       name="kilocaloriesTo"
                                       value="<c:out value='<%=request.getParameter("kilocaloriesTo") != null ? request.getParameter("kilocaloriesTo") : ""%>'/>"
                                       placeholder="Do">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="carbohydratesFrom">Zakres węglowodanów</label>
                            <div>
                                <input type="text" class="form-control d-inline col-5" id="carbohydratesFrom"
                                       name="carbohydratesFrom"
                                       value="<c:out value='<%=request.getParameter("carbohydratesFrom") != null ? request.getParameter("carbohydratesFrom") : ""%>'/>"
                                       placeholder="Od">
                                <input type="text" class="form-control d-inline col-5" id="carbohydratesTo"
                                       name="carbohydratesTo"
                                       value="<c:out value='<%=request.getParameter("carbohydratesTo") != null ? request.getParameter("carbohydratesTo") : ""%>'/>"
                                       placeholder="Do">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="fatsFrom">Zakres tłuszczy</label>
                            <div>
                                <input type="text" class="form-control d-inline col-5" id="fatsFrom" name="fatsFrom"
                                       value="<c:out value='<%=request.getParameter("fatsFrom") != null ? request.getParameter("fatsFrom") : ""%>'/>"
                                       placeholder="Od">
                                <input type="text" class="form-control d-inline col-5" id="fatsTo" name="fatsTo"
                                       value="<c:out value='<%=request.getParameter("fatsTo") != null ? request.getParameter("fatsTo") : ""%>'/>"
                                       placeholder="Do">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="proteinsFrom">Zakres białka</label>
                            <div>
                                <input type="text" class="form-control d-inline col-5" id="proteinsFrom"
                                       name="proteinsFrom"
                                       value="<c:out value='<%=request.getParameter("proteinsFrom") != null ? request.getParameter("proteinsFrom") : ""%>'/>"
                                       placeholder="Od">
                                <input type="text" class="form-control d-inline col-5" id="proteinsTo" name="proteinsTo"
                                       value="<c:out value='<%=request.getParameter("proteinsTo") != null ? request.getParameter("proteinsTo") : ""%>'/>"
                                       placeholder="Do">
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-dark btn-block">Filtruj</button>
                        </div>
                    </form>
                    <form action="meals" method="get">
                        <button type="submit" class="btn btn-warning btn-block">Wyczyść</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-lg-9 col-lg-pull-12">
            <%
                if (request.getParameter("mealAdded") != null) {
            %>
            <div class="alert alert-success" role="alert">
                Posiłek został dodany pomyślnie
            </div>
            <%
            } else if (request.getParameter("mealChanged") != null) {
            %>
            <div class="alert alert-success" role="alert">
                Posiłek został zmieniony pomyślnie
            </div>
            <%
            } else if (request.getParameter("mealDeleted") != null) {
            %>
            <div class="alert alert-success" role="alert">
                Posiłek został usunięty pomyślnie
            </div>
            <%
            } else if (request.getParameter("mealInMealPlan") != null) {
            %>
            <div class="alert alert-danger" role="alert">
                Nie można usunąć posiłku, ponieważ wchodzi w skład planu żywieniowego
            </div>
            <%
                }
            %>
            <div class="row">
                <%
                    String name = request.getParameter("name");
                    if (name == null) {
                        name = "";
                    } else {
                        name = name.trim();
                    }
                    double doubleKilocaloriesFrom = 0;
                    double doubleKilocaloriesTo = Double.MAX_VALUE;
                    double doubleCarbohydratesFrom = 0;
                    double doubleCarbohydratesTo = Double.MAX_VALUE;
                    double doubleFatsFrom = 0;
                    double doubleFatsTo = Double.MAX_VALUE;
                    double doubleProteinsFrom = 0;
                    double doubleProteinsTo = Double.MAX_VALUE;
                    try {
                        doubleKilocaloriesFrom = Double.parseDouble(request.getParameter("kilocaloriesFrom").trim().replace(',', '.'));
                    } catch (Exception ignored) {
                    }
                    try {
                        doubleKilocaloriesTo = Double.parseDouble(request.getParameter("kilocaloriesTo").trim().replace(',', '.'));
                    } catch (Exception ignored) {
                    }
                    try {
                        doubleCarbohydratesFrom = Double.parseDouble(request.getParameter("carbohydratesFrom").trim().replace(',', '.'));
                    } catch (Exception ignored) {
                    }
                    try {
                        doubleCarbohydratesTo = Double.parseDouble(request.getParameter("carbohydratesTo").trim().replace(',', '.'));
                    } catch (Exception ignored) {
                    }
                    try {
                        doubleFatsFrom = Double.parseDouble(request.getParameter("fatsFrom").trim().replace(',', '.'));
                    } catch (Exception ignored) {
                    }
                    try {
                        doubleFatsTo = Double.parseDouble(request.getParameter("fatsTo").trim().replace(',', '.'));
                    } catch (Exception ignored) {
                    }
                    try {
                        doubleProteinsFrom = Double.parseDouble(request.getParameter("proteinsFrom").trim().replace(',', '.'));
                    } catch (Exception ignored) {
                    }
                    try {
                        doubleProteinsTo = Double.parseDouble(request.getParameter("proteinsTo").trim().replace(',', '.'));
                    } catch (Exception ignored) {
                    }
                    List<MealEntity> mealEntities = (List<MealEntity>) request.getAttribute("mealEntities");
                    boolean areMealEntitiesEmpty = Objects.requireNonNull(mealEntities).isEmpty();
                    Iterator<MealEntity> iterator = mealEntities.iterator();
                    if ("Whole".equals(request.getParameter("amount"))) {
                        while (iterator.hasNext()) {
                            MealEntity mealEntity = iterator.next();
                            StringBuilder stringBuilder = new StringBuilder();
                            stringBuilder.append(mealEntity.getName());
                            for (ProductInclusionEntity productInclusionEntity : mealEntity.getProductInclusionEntities()) {
                                stringBuilder.append(" ");
                                stringBuilder.append(productInclusionEntity.getProductEntity().getName());
                            }
                            if (!stringBuilder.toString().toLowerCase().contains(name.trim().toLowerCase()) ||
                                    mealEntity.getKilocaloriesInWhole() < doubleKilocaloriesFrom ||
                                    mealEntity.getKilocaloriesInWhole() > doubleKilocaloriesTo ||
                                    mealEntity.getCarbohydratesInWhole() < doubleCarbohydratesFrom ||
                                    mealEntity.getCarbohydratesInWhole() > doubleCarbohydratesTo ||
                                    mealEntity.getFatsInWhole() < doubleFatsFrom ||
                                    mealEntity.getFatsInWhole() > doubleFatsTo ||
                                    mealEntity.getProteinsInWhole() < doubleProteinsFrom ||
                                    mealEntity.getProteinsInWhole() > doubleProteinsTo) {
                                iterator.remove();
                            }
                        }
                    } else {
                        while (iterator.hasNext()) {
                            MealEntity mealEntity = iterator.next();
                            StringBuilder stringBuilder = new StringBuilder();
                            stringBuilder.append(mealEntity.getName());
                            for (ProductInclusionEntity productInclusionEntity : mealEntity.getProductInclusionEntities()) {
                                stringBuilder.append(" ");
                                stringBuilder.append(productInclusionEntity.getProductEntity().getName());
                            }
                            if (!stringBuilder.toString().toLowerCase().contains(name.trim().toLowerCase()) ||
                                    mealEntity.getKilocaloriesIn100Grams() < doubleKilocaloriesFrom ||
                                    mealEntity.getKilocaloriesIn100Grams() > doubleKilocaloriesTo ||
                                    mealEntity.getCarbohydratesIn100Grams() < doubleCarbohydratesFrom ||
                                    mealEntity.getCarbohydratesIn100Grams() > doubleCarbohydratesTo ||
                                    mealEntity.getFatsIn100Grams() < doubleFatsFrom ||
                                    mealEntity.getFatsIn100Grams() > doubleFatsTo ||
                                    mealEntity.getProteinsIn100Grams() < doubleProteinsFrom ||
                                    mealEntity.getProteinsIn100Grams() > doubleProteinsTo) {
                                iterator.remove();
                            }
                        }
                    }
                    Collections.sort(mealEntities);
                    if (mealEntities.isEmpty()) {
                        if (areMealEntitiesEmpty) {
                %>
                <div class="col-10 mx-auto mb-4 p-5 text-center alert alert-warning" role="alert">
                    Nie masz żadnych posiłków
                </div>
                <%
                } else {
                %>
                <div class="col-10 mx-auto mb-4 p-5 text-center alert alert-warning" role="alert">
                    Nie znaleziono posiłków spełniających podane kryteria
                </div>
                <%
                    }
                } else {
                    for (MealEntity mealEntity : mealEntities) {
                %>
                <div class="col-lg-6 col-sm-12 portfolio-item">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">
                                <a href="editMeal?id=<c:out value='<%=mealEntity.getId()%>'/>"><c:out
                                        value='<%=mealEntity.getName()%>'/>
                                </a>
                            </h5>
                            <h6>Wartości odżywcze w 100g</h6>
                            <hr/>
                            <div class="row">
                                <div class="col-6">
                                    <h6>Kilokalorie:</h6>
                                    <h6>Węglowodany:</h6>
                                    <h6>Tłuszcze:</h6>
                                    <h6>Białko:</h6>
                                </div>
                                <div class="col-6">
                                    <h6><c:out
                                            value='<%=String.format("%.2f", mealEntity.getKilocaloriesIn100Grams())%>'/></h6>
                                    <h6><c:out
                                            value='<%=String.format("%.2f", mealEntity.getCarbohydratesIn100Grams())%>'/>g</h6>
                                    <h6><c:out
                                            value='<%=String.format("%.2f", mealEntity.getFatsIn100Grams())%>'/>g</h6>
                                    <h6><c:out
                                            value='<%=String.format("%.2f", mealEntity.getProteinsIn100Grams())%>'/>g</h6>
                                </div>
                            </div>
                            <h6 class="mt-2">Wartości odżywcze w całości (<c:out
                                    value='<%=mealEntity.getGrams()%>'/>g)</h6>
                            <hr/>
                            <div class="row">
                                <div class="col-6">
                                    <h6>Kilokalorie:</h6>
                                    <h6>Węglowodany:</h6>
                                    <h6>Tłuszcze:</h6>
                                    <h6>Białko:</h6>
                                </div>
                                <div class="col-6">
                                    <h6><c:out
                                            value='<%=String.format("%.2f", mealEntity.getKilocaloriesInWhole())%>'/></h6>
                                    <h6><c:out
                                            value='<%=String.format("%.2f", mealEntity.getCarbohydratesInWhole())%>'/>g</h6>
                                    <h6><c:out
                                            value='<%=String.format("%.2f", mealEntity.getFatsInWhole())%>'/>g</h6>
                                    <h6><c:out
                                            value='<%=String.format("%.2f", mealEntity.getProteinsInWhole())%>'/>g</h6>
                                </div>
                            </div>
                            <h6 class="mt-2">Produkty</h6>
                            <hr/>
                            <%
                                for (ProductInclusionEntity productInclusionEntity : mealEntity.getProductInclusionEntities()) {
                            %>
                            <div class="row">
                                <div class="col-3">
                                    <h6><c:out value='<%=productInclusionEntity.getGrams()%>'/>g</h6>
                                </div>
                                <div class="col-9">
                                    <h6>
                                        <a href='editProduct?id=<c:out value='<%=productInclusionEntity.getProductEntity().getId()%>'/>'><c:out
                                                value='<%=productInclusionEntity.getProductEntity().getName()%>'/></a>
                                    </h6>
                                </div>
                            </div>
                            <%
                                }
                            %>
                            <hr/>
                            <div class="row">
                                <div class="col-6">
                                    <form method="get" action="editMeal">
                                        <label class="d-none">
                                            <input type="text" name="id"
                                                   value="<c:out value='<%=mealEntity.getId()%>'/>"
                                                   hidden>
                                        </label>
                                        <button type="submit" class="btn btn-primary btn-block">Edytuj</button>
                                    </form>
                                </div>
                                <div class="col-6">
                                    <%
                                        List<MealInclusionEntity> mealInclusionEntities = ((Map<Integer, List<MealInclusionEntity>>) request.getAttribute("mealInclusionEntities")).get(mealEntity.getId());
                                        if (mealInclusionEntities.isEmpty()) {
                                    %>
                                    <form method="post" action="deleteMeal">
                                        <label class="d-none">
                                            <input type="text" name="id"
                                                   value="<c:out value='<%=mealEntity.getId()%>'/>"
                                                   hidden>
                                        </label>
                                        <button type="submit" class="btn btn-danger btn-block">Usuń</button>
                                    </form>
                                    <%
                                    } else {
                                    %>
                                    <a href="meals?mealInMealPlan" type="button"
                                       class="btn btn-outline-secondary btn-block">Usuń</a>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </div>
</div>
<%@include file="layout/footer.jsp" %>