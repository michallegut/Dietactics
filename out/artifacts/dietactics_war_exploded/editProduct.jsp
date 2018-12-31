<%@ page import="com.dietactics.presentation.model.entities.ProductEntity" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="layout/userHeader.jsp" %>
<div class="container">
    <h1 class="mt-4">Edytuj produkt</h1>
    <div class="col-md-6 mx-auto my-4">
        <div class="card">
            <h5 class="card-header">Edytowany produkt</h5>
            <div class="card-body">
                <%
                    if (request.getParameter("emptyFields") != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    Wszystkie pola muszą zostać wypełnione
                </div>
                <%
                } else if (request.getParameter("nameTooLong") != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    Nazwa produktu może mieć maksymalnie 50 znaków długości
                </div>
                <%
                } else if (request.getParameter("tooLowKilocalories") != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    Zbyt niskia liczba kilokalorii
                </div>
                <%
                } else if (request.getParameter("tooHighKilocalories") != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    Liczba kilokalorii w 100g produktu nie może przekroczyć 900
                </div>
                <%
                } else if (request.getParameter("tooMuchMacronutrients") != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    Łączna masa makroskładników nie może przekroczyć 100g
                </div>
                <%
                } else if (request.getParameter("textMacronutrients") != null) {
                %>
                <div class="alert alert-danger" role="alert">
                    Makroskładniki muszą być liczbami całkowitymi
                </div>
                <%
                    }
                    ProductEntity productEntity = (ProductEntity) request.getAttribute("productEntity");
                %>
                <form action="editProduct" method="post">
                    <label>
                        <input type="text" name="id"
                               value="<c:out value='<%=Objects.requireNonNull(productEntity).getId()%>'/>"
                               hidden>
                    </label>
                    <div class="form-group mb-4">
                        <label for="carbohydrates">Nazwa</label>
                        <input type="text" class="form-control" id="name" name="name"
                               value="<c:out value='<%=Objects.requireNonNull(productEntity).getName()%>'/>"
                               placeholder="Nazwa produktu" maxlength="50">
                    </div>
                    <h6>Wartości odżywcze w 100g</h6>
                    <hr/>
                    <div class="form-group">
                        <label for="kilocalories">Kilokalorie</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="kilocalories" name="kilocalories"
                                   value="<c:out value='<%=String.format("%.2f", Objects.requireNonNull(productEntity).getKilocalories())%>'/>"
                                   aria-describedby="kilocaloriesHelp" placeholder="Zawartość kilokalorii">
                            <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="kilocaloriesAppend">kcal</span>
                            </div>
                        </div>
                        <small id="kilocaloriesHelp" class="form-text text-muted">Zawartość kilokalorii
                            musi
                            być co
                            najmniej równe sumie kalorii wynikającej z podanych makroskładników.
                        </small>
                    </div>
                    <div class="form-group">
                        <label for="carbohydrates">Węglowodany</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="carbohydrates" name="carbohydrates"
                                   value="<c:out value='<%=String.format("%.2f", Objects.requireNonNull(productEntity).getCarbohydrates())%>'/>"
                                   placeholder="Zawartość węglowodanów">
                            <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="carbohydratesAppend">g</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="fats">Tłuszcze</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="fats" name="fats"
                                   value="<c:out value='<%=String.format("%.2f", Objects.requireNonNull(productEntity).getFats())%>'/>"
                                   placeholder="Zawartość tłuszczy">
                            <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="fatsAppend">g</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="proteins">Białko</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="proteins" name="proteins"
                                   value="<c:out value='<%=String.format("%.2f", Objects.requireNonNull(productEntity).getProteins())%>'/>"
                                   placeholder="Zawartość białka">
                            <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="proteinsAppend">g</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary btn-block">Zapisz</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<%@include file="layout/footer.jsp" %>