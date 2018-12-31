<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="layout/anonymousHeader.jsp" %>
<div class="container">
    <div class="row my-4 justify-content-between">
        <div class="col-md-6 my-5">
            <h1 class="mb-5">Zbudowana dla świadomych użytkowników</h1>
            <h5 class="mb-3">Dietactics to aplikacja, która powstała z myślą o
                odbiorcach
                doświadczonych w kwestiach
                związanych z układaniem diety.</h5>
            <h5 class="mb-3">Wystarczy, że określisz swoje zapotrzebowanie na poszczególne makroskładniki, a z
                łatwością opracujesz z nami optymalną taktykę żywienia.</h5>
            <h5>Dietactics pozwoli Ci zdefiniować twoje ulubione posiłki na podstawie wybranych przez
                Ciebie produktów, pomoże przyporządkować je odpowiednim dniom oraz umożliwi wygodne śledzenie
                wagi.</h5>
        </div>
        <div class="col-md-5">
            <div class="card my-4">
                <h5 class="card-header">Logowanie</h5>
                <div class="card-body">
                    <%
                        if (request.getParameter("invalidCredentials") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Niepoprawne dane logowania
                    </div>
                    <%
                        }
                    %>
                    <form action="login" method="post"
                          onsubmit="this.timezoneOffset.value = new Date().getTimezoneOffset()">
                        <div class="form-group">
                            <label for="existingUsername">Nazwa użytkownika</label>
                            <input type="text" class="form-control" id="existingUsername"
                                   name="existingUsername"
                                   placeholder="Twoja nazwa użytkownika" maxlength="20">
                        </div>
                        <div class="form-group">
                            <label for="existingPassword">Hasło</label>
                            <input type="password" class="form-control" id="existingPassword"
                                   name="existingPassword"
                                   placeholder="Twoje hasło" maxlength="20">
                        </div>
                        <label class="d-none">
                            <input type="text" class="form-control" name="timezoneOffset" hidden>
                        </label>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Zaloguj się</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="card my-4">
                <h5 class="card-header">Rejestracja</h5>
                <div class="card-body">
                    <%
                        if (request.getParameter("emptyRegisterFields") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Wszystkie pola muszą zostać wypełnione
                    </div>
                    <%
                    } else if (request.getParameter("whitespaceCharacters") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Nazwa użytkownika oraz hasło nie mogą zawierać spacji
                    </div>
                    <%
                    } else if (request.getParameter("tooLong") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Nazwa użytkownika oraz hasło mogą mieć co najwyżej 20 znaków długości
                    </div>
                    <%
                    } else if (request.getParameter("mismatchedPasswords") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Podane hasła są różne
                    </div>
                    <%
                    } else if (request.getParameter("passwordTooShort") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Hasło musi mieć co najmniej 8 znaków długości
                    </div>
                    <%
                    } else if (request.getParameter("takenUsername") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Wybrana nazwa użytkownika jest zajęta
                    </div>
                    <%
                    } else if (request.getParameter("textDemands") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Zapotrzebowania muszą być liczbami całkowitymi
                    </div>
                    <%
                    } else if (request.getParameter("tooLowKilocaloriesDemand") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Zbyt niskie zapotrzebowanie na kilokalorie
                    </div>
                    <%
                        }
                    %>
                    <form action="register" method="post"
                          onsubmit="this.timezoneOffset.value = new Date().getTimezoneOffset()">
                        <div class="form-group">
                            <label for="newUsername">Nazwa użytkownika</label>
                            <input type="text" class="form-control" id="newUsername" name="newUsername"
                                   aria-describedby="usernameHelp"
                                   placeholder="Wybierz nazwę użytkownika" maxlength="20">
                            <small id="usernameHelp" class="form-text text-muted">Nazwa użytkownika może mieć
                                maksymalnie 20
                                znaków długości.
                            </small>
                        </div>
                        <div class="form-group">
                            <label for="newPassword">Hasło</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword"
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
                            <label for="kilocaloriesDemand">Kilokalorie</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="kilocaloriesDemand"
                                       name="kilocaloriesDemand"
                                       aria-describedby="kilocaloriesDemandHelp"
                                       placeholder="Zapotrzebowanie na kilokalorie">
                                <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="kilocaloriesDemandAppend">kcal</span>
                                </div>
                                <small id="kilocaloriesDemandHelp" class="form-text text-muted">Zapotrzebowanie na
                                    kilokalorie
                                    musi
                                    być co
                                    najmniej równe sumie kalorii wynikającej z podanych makroskładników.
                                </small>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="carbohydratesDemand">Węglowodany</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="carbohydratesDemand"
                                       name="carbohydratesDemand"
                                       placeholder="Zapotrzebowanie na węglowodany">
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
                                       placeholder="Zapotrzebowanie na tłuszcze">
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
                                       placeholder="Zapotrzebowanie na białko">
                                <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="proteinsDemandAppend">g</span>
                                </div>
                            </div>
                        </div>
                        <label class="d-none">
                            <input type="text" class="form-control" name="timezoneOffset" hidden>
                        </label>
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-block">Zarejestruj się</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="layout/footer.jsp" %>