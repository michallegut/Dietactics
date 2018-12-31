<%@ page import="com.dietactics.presentation.model.entities.ProductEntity" %>
<%@ page import="com.dietactics.presentation.model.entities.ProductInclusionEntity" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="layout/userHeader.jsp" %>
<div class="container">
    <h1 class="mt-4">Produkty</h1>
    <div class="row mt-4">
        <div class="col-lg-3 col-lg-push-12 mb-4">
            <form method="get" action="addProduct">
                <button type="submit" class="btn btn-success btn-block">Dodaj produkt</button>
            </form>
            <div class="card">
                <h5 class="card-header">Filtry</h5>
                <div class="card-body">
                    <form action="products" method="get">
                        <div class="form-group">
                            <label for="name">Nazwa</label>
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
                    <form action="products" method="get">
                        <button type="submit" class="btn btn-warning btn-block">Wyczyść</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-lg-9 col-lg-pull-12">
            <%
                if (request.getParameter("productAdded") != null) {
            %>
            <div class="alert alert-success" role="alert">
                Produkt został dodany pomyślnie
            </div>
            <%
            } else if (request.getParameter("productChanged") != null) {
            %>
            <div class="alert alert-success" role="alert">
                Produkt został zmieniony pomyślnie
            </div>
            <%
            } else if (request.getParameter("productDeleted") != null) {
            %>
            <div class="alert alert-success" role="alert">
                Produkt został usunięty pomyślnie
            </div>
            <%
            } else if (request.getParameter("productInMeal") != null) {
            %>
            <div class="alert alert-danger" role="alert">
                Nie można usunąć produktu, ponieważ jest częścią posiłku
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
                    double doubleKilocaloriesTo = 900;
                    double doubleCarbohydratesFrom = 0;
                    double doubleCarbohydratesTo = 100;
                    double doubleFatsFrom = 0;
                    double doubleFatsTo = 100;
                    double doubleProteinsFrom = 0;
                    double doubleProteinsTo = 100;
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
                    List<ProductEntity> productEntities = (List<ProductEntity>) request.getAttribute("productEntities");
                    boolean areProductEntitiesEmpty = Objects.requireNonNull(productEntities).isEmpty();
                    Iterator<ProductEntity> iterator = productEntities.iterator();
                    while (iterator.hasNext()) {
                        ProductEntity productEntity = iterator.next();
                        if (!productEntity.getName().toLowerCase().contains(name.trim().toLowerCase()) ||
                                productEntity.getKilocalories() < doubleKilocaloriesFrom ||
                                productEntity.getKilocalories() > doubleKilocaloriesTo ||
                                productEntity.getCarbohydrates() < doubleCarbohydratesFrom ||
                                productEntity.getCarbohydrates() > doubleCarbohydratesTo ||
                                productEntity.getFats() < doubleFatsFrom ||
                                productEntity.getFats() > doubleFatsTo ||
                                productEntity.getProteins() < doubleProteinsFrom ||
                                productEntity.getProteins() > doubleProteinsTo) {
                            iterator.remove();
                        }
                    }
                    Collections.sort(productEntities);
                    if (productEntities.isEmpty()) {
                        if (areProductEntitiesEmpty) {
                %>
                <div class="col-10 mx-auto mb-4 p-5 text-center alert alert-warning" role="alert">
                    Nie masz żadnych produktów
                </div>
                <%
                } else {
                %>
                <div class="col-10 mx-auto mb-4 p-5 text-center alert alert-warning" role="alert">
                    Nie znaleziono produktów spełniających podane kryteria
                </div>
                <%
                    }
                } else {
                    for (ProductEntity productEntity : productEntities) {
                %>
                <div class="col-lg-4 col-sm-6 portfolio-item">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">
                                <a href="editProduct?id=<c:out value='<%=productEntity.getId()%>'/>"><c:out
                                        value='<%=productEntity.getName() %>'/>
                                </a>
                            </h5>
                            <h6>Wartości odżywcze w 100g</h6>
                            <hr/>
                            <div class="row">
                                <div class="col-7">
                                    <h6>Kilokalorie:</h6>
                                    <h6>Węglowodany:</h6>
                                    <h6>Tłuszcze:</h6>
                                    <h6>Białko:</h6>
                                </div>
                                <div class="col-5">
                                    <h6><c:out
                                            value='<%=String.format("%.2f", productEntity.getKilocalories())%>'/></h6>
                                    <h6><c:out
                                            value='<%=String.format("%.2f", productEntity.getCarbohydrates())%>'/>g</h6>
                                    <h6><c:out value='<%=String.format("%.2f", productEntity.getFats())%>'/>g</h6>
                                    <h6><c:out value='<%=String.format("%.2f", productEntity.getProteins())%>'/>g</h6>
                                </div>
                            </div>
                            <hr/>
                            <div class="row">
                                <div class="col-6">
                                    <form method="get" action="editProduct">
                                        <label class="d-none">
                                            <input type="text" name="id"
                                                   value="<c:out value='<%=productEntity.getId()%>'/>"
                                                   hidden>
                                        </label>
                                        <button type="submit" class="btn btn-primary btn-block">Edytuj</button>
                                    </form>
                                </div>
                                <div class="col-6">
                                    <%
                                        List<ProductInclusionEntity> productInclusionEntities = ((Map<Integer, List<ProductInclusionEntity>>) request.getAttribute("productInclusionEntities")).get(productEntity.getId());
                                        if (productInclusionEntities.isEmpty()) {
                                    %>
                                    <form method="post" action="deleteProduct">
                                        <label class="d-none">
                                            <input type="text" name="id"
                                                   value="<c:out value='<%=productEntity.getId()%>'/>"
                                                   hidden>
                                        </label>
                                        <button type="submit" class="btn btn-danger btn-block">Usuń</button>
                                    </form>
                                    <%
                                    } else {
                                    %>
                                    <a href="products?productInMeal" type="button"
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