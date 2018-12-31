<%@ page import="com.dietactics.presentation.model.entities.UserEntity" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="layout/userHeader.jsp" %>
<div class="container">
    <h1 class="mt-4">Profil</h1>
    <div class="row my-4">
        <div class="col-md-6 mb-4">
            <div class="card">
                <h5 class="card-header">Zmień hasło</h5>
                <div class="card-body">
                    <%
                        if (request.getParameter("emptyPasswords") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Wszystkie pola muszą zostać wypełnione
                    </div>
                    <%
                    } else if (request.getParameter("whitespaceCharacters") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Hasło nie może zawierać spacji
                    </div>
                    <%
                    } else if (request.getParameter("mismatchedPasswords") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Podane hasła są różne
                    </div>
                    <%
                    } else if (request.getParameter("incorrectPasswordLength") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Hasło musi mieć od 8 do 20 znaków długości
                    </div>
                    <%
                    } else if (request.getParameter("passwordChanged") != null) {
                    %>
                    <div class="alert alert-success" role="alert">
                        Hasło zostało zmienione pomyślnie
                    </div>
                    <%
                        }
                    %>
                    <form action="editPassword" method="post">
                        <div class="form-group">
                            <label for="password">Nowe hasło</label>
                            <input type="password" class="form-control" id="password" name="password"
                                   aria-describedby="passwordHelp"
                                   placeholder="Utwórz hasło" maxlength="20">
                            <small id="passwordHelp" class="form-text text-muted">Upewnij się, że twoje hasło ma
                                od 8 do 20 znaków długości.
                            </small>
                        </div>
                        <div class="form-group">
                            <label for="passwordConfirmation">Potwierdź hasło</label>
                            <input type="password" class="form-control" id="passwordConfirmation"
                                   name="passwordConfirmation"
                                   placeholder="Wpisz hasło ponownie" maxlength="20">
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Zapisz</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <h5 class="card-header">Dostosuj zapotrzebowanie</h5>
                <div class="card-body">
                    <%
                        if (request.getParameter("emptyDemands") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Wszystkie pola muszą zostać wypełnione
                    </div>
                    <%
                    } else if (request.getParameter("tooLowKilocaloriesDemand") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Zbyt niskie zapotrzebowanie na kilokalorie
                    </div>
                    <%
                    } else if (request.getParameter("textDemands") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Zapotrzebowania muszą być liczbami całkowitymi
                    </div>
                    <%
                    } else if (request.getParameter("demandsChanged") != null) {
                    %>
                    <div class="alert alert-success" role="alert">
                        Zapotrzebowanie zostało zmienione pomyślnie
                    </div>
                    <%
                        }
                        UserEntity userEntity = (UserEntity) request.getAttribute("userEntity");
                    %>
                    <form action="editDemands" method="post">
                        <div class="form-group">
                            <label for="kilocaloriesDemand">Kilokalorie</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="kilocaloriesDemand"
                                       name="kilocaloriesDemand"
                                       aria-describedby="kilocaloriesDemandHelp"
                                       placeholder="Zapotrzebowanie na kilokalorie"
                                       value='<c:out value='<%=Objects.requireNonNull(userEntity).getKilocaloriesDemand()%>'/>'>
                                <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="kilocaloriesDemandAppend">kcal</span>
                                </div>
                            </div>
                            <small id="kilocaloriesDemandHelp" class="form-text text-muted">Zapotrzebowanie na
                                kilokalorie
                                musi
                                być co
                                najmniej równe sumie kalorii wynikającej z podanych makroskładników.
                            </small>
                        </div>
                        <div class="form-group">
                            <label for="carbohydratesDemand">Węglowodany</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="carbohydratesDemand"
                                       name="carbohydratesDemand"
                                       placeholder="Zapotrzebowanie na węglowodany"
                                       value='<c:out value='<%=Objects.requireNonNull(userEntity).getCarbohydratesDemand()%>'/>'>
                                <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="carbohydratesDemandAppend">g</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="fatsDemand">Tłuszcze</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="fatsDemand" name="fatsDemand"
                                       placeholder="Zapotrzebowanie na tłuszcze"
                                       value='<c:out value='<%=Objects.requireNonNull(userEntity).getFatsDemand()%>'/>'>
                                <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="fatsDemandAppend">g</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="proteinsDemand">Białko</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="proteinsDemand" name="proteinsDemand"
                                       placeholder="Zapotrzebowanie na białko"
                                       value='<c:out value='<%=Objects.requireNonNull(userEntity).getProteinsDemand()%>'/>'>
                                <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="proteinsDemandAppend">g</span>
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
</div>
<%@include file="layout/footer.jsp" %>