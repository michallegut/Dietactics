<%@ page import="com.dietactics.presentation.model.entities.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="layout/userHeader.jsp" %>
<div class="container">
    <h1 class="mt-4">Plany żywieniowe</h1>
    <div class="row mt-4">
        <div class="col-lg-3 col-lg-push-12 mb-4">
            <form method="get" action="addMealPlan">
                <button type="submit" class="btn btn-success btn-block">Dodaj plan żywieniowy</button>
            </form>
            <div class="card">
                <h5 class="card-header">Filtry</h5>
                <div class="card-body">
                    <form action="mealPlans" method="get">
                        <div class="form-group">
                            <label for="name">Nazwa planu, posiłku lub produktu</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="<c:out value='<%=request.getParameter("name") != null ? request.getParameter("name") : ""%>'/>"
                                   placeholder="Tekst zawarty w nazwie">
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
                    <form action="mealPlans" method="get">
                        <button type="submit" class="btn btn-warning btn-block">Wyczyść</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-lg-9 col-lg-pull-12">
            <%
                if (request.getParameter("mealPlanAdded") != null) {
            %>
            <div class="alert alert-success" role="alert">
                Plan żywieniowy został dodany pomyślnie
            </div>
            <%
            } else if (request.getParameter("mealPlanChanged") != null) {
            %>
            <div class="alert alert-success" role="alert">
                Plan żywieniowy został zmieniony pomyślnie
            </div>
            <%
            } else if (request.getParameter("mealPlanDeleted") != null) {
            %>
            <div class="alert alert-success" role="alert">
                Plan żywieniowy został usunięty pomyślnie
            </div>
            <%
            } else if (request.getParameter("assignedMealPlan") != null) {
            %>
            <div class="alert alert-danger" role="alert">
                Nie można usunąć planu żywieniowego, ponieważ jest przypisany do dnia <c:out
                    value='<%=request.getParameter("assignedMealPlan")%>'/>
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
                    List<MealPlanEntity> mealPlanEntities = (List<MealPlanEntity>) request.getAttribute("mealPlanEntities");
                    boolean areMealPlanEntitiesEmpty = Objects.requireNonNull(mealPlanEntities).isEmpty();
                    Iterator<MealPlanEntity> iterator = mealPlanEntities.iterator();
                    while (iterator.hasNext()) {
                        MealPlanEntity mealPlanEntity = iterator.next();
                        StringBuilder stringBuilder = new StringBuilder();
                        stringBuilder.append(mealPlanEntity.getName());
                        for (MealInclusionEntity mealInclusionEntity : mealPlanEntity.getMealInclusionEntities()) {
                            stringBuilder.append(" ");
                            stringBuilder.append(mealInclusionEntity.getMealEntity().getName());
                            for (ProductInclusionEntity productInclusionEntity : mealInclusionEntity.getMealEntity().getProductInclusionEntities()) {
                                stringBuilder.append(" ");
                                stringBuilder.append(productInclusionEntity.getProductEntity().getName());
                            }
                        }
                        if (!stringBuilder.toString().toLowerCase().contains(name.trim().toLowerCase()) ||
                                mealPlanEntity.getKilocalories() < doubleKilocaloriesFrom ||
                                mealPlanEntity.getKilocalories() > doubleKilocaloriesTo ||
                                mealPlanEntity.getCarbohydrates() < doubleCarbohydratesFrom ||
                                mealPlanEntity.getCarbohydrates() > doubleCarbohydratesTo ||
                                mealPlanEntity.getFats() < doubleFatsFrom ||
                                mealPlanEntity.getFats() > doubleFatsTo ||
                                mealPlanEntity.getProteins() < doubleProteinsFrom ||
                                mealPlanEntity.getProteins() > doubleProteinsTo) {
                            iterator.remove();
                        }
                    }
                    Collections.sort(mealPlanEntities);
                    if (mealPlanEntities.isEmpty()) {
                        if (areMealPlanEntitiesEmpty) {
                %>
                <div class="col-10 mx-auto mb-4 p-5 text-center alert alert-warning" role="alert">
                    Nie masz żadnych planów żywieniowych
                </div>
                <%
                } else {
                %>
                <div class="col-10 mx-auto mb-4 p-5 text-center alert alert-warning" role="alert">
                    Nie znaleziono planów żywieniowych spełniających podane kryteria
                </div>
                <%
                    }
                } else {
                    UserEntity userEntity = (UserEntity) request.getAttribute("userEntity");
                    boolean wasFirstMealCollapsed = false;
                    for (MealPlanEntity mealPlanEntity : mealPlanEntities) {
                %>
                <div class="col-lg-6 col-sm-12 portfolio-item">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">
                                <a href="editMealPlan?id=<c:out value='<%=mealPlanEntity.getId()%>'/>"><c:out
                                        value='<%=mealPlanEntity.getName()%>'/>
                                </a>
                            </h5>
                            <h6 class="mt-2">Wartości odżywcze</h6>
                            <hr/>
                            <div class="row">
                                <div class="col-6">
                                    <h6>Kilokalorie:</h6>
                                </div>
                                <div class="col-6">
                                    <div class="progress position-relative">
                                        <div class='text-dark progress-bar bg-<%=Math.abs(mealPlanEntity.getKilocalories()-Objects.requireNonNull(userEntity).getKilocaloriesDemand()) < 100 ? "success" : "warning"%>'
                                             style='width: <c:out
                                                     value='<%=mealPlanEntity.getKilocalories()/Objects.requireNonNull(userEntity).getKilocaloriesDemand()*100%>'/>%'>
                                        </div>
                                        <div style="bottom: 3%"
                                             class="justify-content-center d-flex position-absolute w-100"><c:out
                                                value='<%=String.format("%.2f", mealPlanEntity.getKilocalories())%>'/> /
                                            <c:out value='<%=Objects.requireNonNull(userEntity).getKilocaloriesDemand()%>'/></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <h6>Węglowodany:</h6>
                                </div>
                                <div class="col-6">
                                    <div class="progress position-relative">
                                        <div class='text-dark progress-bar bg-<%=Math.abs(mealPlanEntity.getCarbohydrates()-Objects.requireNonNull(userEntity).getCarbohydratesDemand()) < 10 ? "success" : "warning"%>'
                                             style='width: <c:out
                                                     value='<%=mealPlanEntity.getCarbohydrates()/Objects.requireNonNull(userEntity).getCarbohydratesDemand()*100%>'/>%'>
                                        </div>
                                        <div style="bottom: 3%"
                                             class="justify-content-center d-flex position-absolute w-100"><c:out
                                                value='<%=String.format("%.2f", mealPlanEntity.getCarbohydrates())%>'/>g
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
                                        <div class='text-dark progress-bar bg-<%=Math.abs(mealPlanEntity.getFats()-Objects.requireNonNull(userEntity).getFatsDemand()) < 10 ? "success" : "warning"%>'
                                             style='width: <c:out
                                                     value='<%=mealPlanEntity.getFats()/Objects.requireNonNull(userEntity).getFatsDemand()*100%>'/>%'>
                                        </div>
                                        <div style="bottom: 3%"
                                             class="justify-content-center d-flex position-absolute w-100"><c:out
                                                value='<%=String.format("%.2f", mealPlanEntity.getFats())%>'/>g / <c:out
                                                value='<%=Objects.requireNonNull(userEntity).getFatsDemand()%>'/>g
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
                                        <div class='text-dark progress-bar bg-<%=Math.abs(mealPlanEntity.getProteins()-Objects.requireNonNull(userEntity).getProteinsDemand()) < 10 ? "success" : "warning"%>'
                                             style='width: <c:out
                                                     value='<%=mealPlanEntity.getProteins()/Objects.requireNonNull(userEntity).getProteinsDemand()*100%>'/>%'>
                                        </div>
                                        <div style="bottom: 3%"
                                             class="justify-content-center d-flex position-absolute w-100"><c:out
                                                value='<%=String.format("%.2f", mealPlanEntity.getProteins())%>'/>g /
                                            <c:out value='<%=Objects.requireNonNull(userEntity).getProteinsDemand()%>'/>g
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <h6 class="mt-2">Posiłki</h6>
                            <hr/>
                            <div class="accordion">
                                <%
                                    for (MealInclusionEntity mealInclusionEntity : mealPlanEntity.getMealInclusionEntities()) {
                                        MealEntity mealEntity = mealInclusionEntity.getMealEntity();
                                %>
                                <div class="card">
                                    <div class="card-header"
                                         id="heading<c:out value='<%=mealPlanEntity.getId() + "_" + mealEntity.getId()%>'/>">
                                        <div class="row" type="button btn btn-link" data-toggle="collapse"
                                             data-target="#collapse<c:out value='<%=mealPlanEntity.getId() + "_" + mealEntity.getId()%>'/>"
                                             aria-expanded="true"
                                             aria-controls="collapse<c:out value='<%=mealPlanEntity.getId() + "_" + mealEntity.getId()%>'/>">
                                            <div class="col-6">
                                                <h6><c:out value='<%=mealInclusionEntity.getGrams()%>'/>g
                                                    <br/>
                                                    <c:out value='<%=Math.round(((double)mealInclusionEntity.getGrams())/mealEntity.getGrams()*100)%>'/>%
                                                    posiłku</h6>
                                            </div>
                                            <div class="col-6">
                                                <h6>
                                                    <a href="editMeal?id=<c:out value='<%=mealEntity.getId()%>'/>"><c:out
                                                            value='<%=mealEntity.getName()%>'/>
                                                    </a>
                                                </h6>
                                            </div>
                                        </div>
                                    </div>
                                    <div id="collapse<c:out value='<%=mealPlanEntity.getId() + "_" + mealEntity.getId()%>'/>"
                                         class="collapse<%=wasFirstMealCollapsed ? "" : " show"%>"
                                         aria-labelledby="heading<c:out value='<%=mealPlanEntity.getId() + "_" + mealEntity.getId()%>'/>">
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
                                        wasFirstMealCollapsed = true;
                                    }
                                %>
                            </div>
                            <div class="row mt-4">
                                <div class="col-6">
                                    <form method="get" action="editMealPlan">
                                        <label class="d-none">
                                            <input type="text" name="id"
                                                   value="<c:out value='<%=mealPlanEntity.getId()%>'/>"
                                                   hidden>
                                        </label>
                                        <button type="submit" class="btn btn-primary btn-block">Edytuj</button>
                                    </form>
                                </div>
                                <div class="col-6">
                                    <%
                                        List<MealPlanAssignmentEntity> mealPlanAssignmentEntities = ((Map<Integer, List<MealPlanAssignmentEntity>>) request.getAttribute("mealPlanAssignmentEntities")).get(mealPlanEntity.getId());
                                        if (Objects.requireNonNull(mealPlanAssignmentEntities).isEmpty()) {
                                    %>
                                    <form method="post" action="deleteMealPlan">
                                        <label class="d-none">
                                            <input type="text" name="id"
                                                   value="<c:out value='<%=mealPlanEntity.getId()%>'/>"
                                                   hidden>
                                        </label>
                                        <button type="submit" class="btn btn-danger btn-block">Usuń</button>
                                    </form>
                                    <%
                                    } else {
                                        Collections.sort(mealPlanAssignmentEntities);
                                    %>
                                    <a href="mealPlans?assignedMealPlan=<c:out value='<%=new SimpleDateFormat("dd.MM.yyyy").format(mealPlanAssignmentEntities.get(0).getDate())%>'/>"
                                       type="button"
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