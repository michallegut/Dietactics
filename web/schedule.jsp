<%@ page import="com.dietactics.presentation.model.entities.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@include file="layout/userHeader.jsp" %>
<div class="container">
    <%
        SimpleDateFormat sqlFormat = (SimpleDateFormat) request.getAttribute("sqlFormat");
        SimpleDateFormat displayFormat = new SimpleDateFormat("dd.MM.yyyy");
        SimpleDateFormat dayNameFormat = new SimpleDateFormat("EEEE");
        Date today = (Date) request.getAttribute("today");
        Date date = (Date) request.getAttribute("date");
        boolean isToday = date.equals(today);
        Calendar calendar = (Calendar) request.getAttribute("calendar");
        calendar.add(Calendar.DAY_OF_MONTH, -2);
        Date previousDate = new Date(calendar.getTimeInMillis());
        Date nextDate = (Date) request.getAttribute("nextDate");
        boolean wasFirstMealCollapsed = false;
    %>
    <h1 class="mt-4">Rozpiska</h1>
    <div class="row">
        <div class="col-md-6 mt-4">
            <div class="row">
                <div class="col-12">
                    <a class="btn btn-warning"
                       href='schedule?date=<c:out value='<%=sqlFormat.format(previousDate)%>'/>'>Poprzedni</a>
                    <a class="btn btn-secondary" href='schedule?date=<c:out value='<%=sqlFormat.format(today)%>'/>'>Dzisiejszy</a>
                    <a class="btn btn-primary"
                       href='schedule?date=<c:out value='<%=sqlFormat.format(nextDate)%>'/>'>Następny</a>
                </div>
            </div>
            <div class="row">
                <div class="col-12 mt-2">
                    <form class="form-inline" method="get" action="schedule">
                        <div class="col-xs-6 mr-2">
                            <label for="date" class="d-none"></label><input type="date" class="form-control" id="date"
                                                                            name="date"
                                                                            value='<c:out value='<%=sqlFormat.format(date)%>'/>'>
                        </div>
                        <div class="col-xs-6">
                            <button type="submit" class="btn btn-dark">Przejdź</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-6 mt-4">
            <form method="post" action="deletePastMealPlansAssignments">
                <label class="d-none">
                    <input type="text" name="date"
                           value='<c:out value='<%=sqlFormat.format(date)%>'/>' hidden>
                </label>
                <div class="form-group mx-auto">
                    <button type="submit" class="btn btn-danger btn-block">Usuń historię<br/>
                        <small>Wszystkie wpisy sprzed dnia dzisiejszego, tj. <c:out
                                value='<%=displayFormat.format(today)%>'/> zostaną usunięte!
                        </small>
                    </button>
                </div>
            </form>
            <%
                if (request.getParameter("historyDeleted") != null) {
            %>
            <div class="alert alert-success m-0" role="alert">
                Historia została usunięta pomyślnie
            </div>
            <%
                }
            %>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 my-4">
            <div class="card border-primary">
                <div class="card-header bg-primary text-light">
                    <div class="row">
                        <div class="col-6 text-center"><%=dayNameFormat.format(date).substring(0, 1).toUpperCase() + dayNameFormat.format(date).substring(1)%>
                        </div>
                        <div class="col-6 text-center"><%=displayFormat.format(date)%>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <%
                        if (isToday) {
                    %>
                    <div class="alert alert-primary text-center" role="alert">
                        Dzisiejszy dzień
                    </div>
                    <%
                        }
                        MealPlanAssignmentEntity mealPlanAssignmentEntity = (MealPlanAssignmentEntity) request.getAttribute("mealPlanAssignmentEntity");
                        MealPlanEntity assignedMealPlanEntity = (MealPlanEntity) request.getAttribute("assignedMealPlanEntity");
                        UserEntity userEntity = (UserEntity) request.getAttribute("userEntity");
                        if (assignedMealPlanEntity != null) {
                    %>
                    <h5 class="card-title">
                        <a href="editMealPlan?id=<c:out value='<%=assignedMealPlanEntity.getId()%>'/>"><c:out
                                value='<%=assignedMealPlanEntity.getName()%>'/>
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
                                <div class='text-dark progress-bar bg-<%=Math.abs(assignedMealPlanEntity.getKilocalories()-Objects.requireNonNull(userEntity).getKilocaloriesDemand()) < 100 ? "success" : "warning"%>'
                                     style='width: <c:out
                                             value='<%=assignedMealPlanEntity.getKilocalories()/Objects.requireNonNull(userEntity).getKilocaloriesDemand()*100%>'/>%'>
                                </div>
                                <div style="bottom: 3%"
                                     class="justify-content-center d-flex position-absolute w-100"><c:out
                                        value='<%=String.format("%.2f", assignedMealPlanEntity.getKilocalories())%>'/>
                                    /
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
                                <div class='text-dark progress-bar bg-<%=Math.abs(assignedMealPlanEntity.getCarbohydrates()-Objects.requireNonNull(userEntity).getCarbohydratesDemand()) < 10 ? "success" : "warning"%>'
                                     style='width: <c:out
                                             value='<%=assignedMealPlanEntity.getCarbohydrates()/Objects.requireNonNull(userEntity).getCarbohydratesDemand()*100%>'/>%'>
                                </div>
                                <div style="bottom: 3%"
                                     class="justify-content-center d-flex position-absolute w-100"><c:out
                                        value='<%=String.format("%.2f", assignedMealPlanEntity.getCarbohydrates())%>'/>g
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
                                <div class='text-dark progress-bar bg-<%=Math.abs(assignedMealPlanEntity.getFats()-Objects.requireNonNull(userEntity).getFatsDemand()) < 10 ? "success" : "warning"%>'
                                     style='width: <c:out
                                             value='<%=assignedMealPlanEntity.getFats()/Objects.requireNonNull(userEntity).getFatsDemand()*100%>'/>%'>
                                </div>
                                <div style="bottom: 3%"
                                     class="justify-content-center d-flex position-absolute w-100"><c:out
                                        value='<%=String.format("%.2f", assignedMealPlanEntity.getFats())%>'/>g
                                    /
                                    <c:out
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
                                <div class='text-dark progress-bar bg-<%=Math.abs(assignedMealPlanEntity.getProteins()-Objects.requireNonNull(userEntity).getProteinsDemand()) < 10 ? "success" : "warning"%>'
                                     style='width: <c:out
                                             value='<%=assignedMealPlanEntity.getProteins()/Objects.requireNonNull(userEntity).getProteinsDemand()*100%>'/>%'>
                                </div>
                                <div style="bottom: 3%"
                                     class="justify-content-center d-flex position-absolute w-100"><c:out
                                        value='<%=String.format("%.2f", assignedMealPlanEntity.getProteins())%>'/>g
                                    /
                                    <c:out value='<%=Objects.requireNonNull(userEntity).getProteinsDemand()%>'/>g
                                </div>
                            </div>
                        </div>
                    </div>
                    <h6 class="mt-2">Posiłki</h6>
                    <hr/>
                    <div class="accordion">
                        <%
                            for (MealInclusionEntity mealInclusionEntity : assignedMealPlanEntity.getMealInclusionEntities()) {
                                MealEntity mealEntity = mealInclusionEntity.getMealEntity();
                        %>
                        <div class="card">
                            <div class="card-header"
                                 id="heading<c:out value='<%=mealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>">
                                <div class="row" type="button btn btn-link" data-toggle="collapse"
                                     data-target="#collapse<c:out value='<%=mealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>"
                                     aria-expanded="true"
                                     aria-controls="collapse<c:out value='<%=mealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>">
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
                            <div id="collapse<c:out value='<%=mealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>"
                                 class="collapse<%=wasFirstMealCollapsed ? "" : " show"%>"
                                 aria-labelledby="heading<c:out value='<%=mealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>">
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
                    <form class="mt-4" method="post" action="deleteMealPlanAssignment">
                        <label class="d-none">
                            <input type="text" name="id"
                                   value="<c:out value='<%=mealPlanAssignmentEntity.getId()%>'/>"
                                   hidden>
                        </label>
                        <label class="d-none">
                            <input type="text" name="date"
                                   value="<c:out value='<%=sqlFormat.format(date)%>'/>"
                                   hidden>
                        </label>
                        <button type="submit" class="btn btn-danger btn-block">Wyczyść</button>
                    </form>
                    <%
                    } else {
                    %>
                    <h5 class="card-title">
                        Wybierz plan żywieniowy
                    </h5>
                    <form action="addMealPlanAssignment" method="post">
                        <div class="form-group">
                            <label>
                                <select name="mealPlanId" class="form-control">
                                    <%
                                        List<MealPlanEntity> mealPlanEntities = (List<MealPlanEntity>) request.getAttribute("mealPlanEntities");
                                        Collections.sort(Objects.requireNonNull(mealPlanEntities));
                                        for (MealPlanEntity mealPlanEntity : mealPlanEntities) {
                                    %>
                                    <option value='<c:out value='<%=mealPlanEntity.getId()%>'/>'><c:out
                                            value='<%=mealPlanEntity.getName()%>'/> | Kilokalorie: <c:out
                                            value='<%=String.format("%.2f", mealPlanEntity.getKilocalories())%>'/>,
                                        Węglowodany:
                                        <c:out value='<%=String.format("%.2f", mealPlanEntity.getCarbohydrates())%>'/>g,
                                        Tłuszcze: <c:out
                                                value='<%=String.format("%.2f", mealPlanEntity.getFats())%>'/>g,
                                        Białko
                                        <c:out value='<%=String.format("%.2f", mealPlanEntity.getProteins())%>'/>g
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </label>
                        </div>
                        <label class="d-none">
                            <input type="text" name="date"
                                   value="<c:out value='<%=sqlFormat.format(date)%>'/>"
                                   hidden>
                        </label>
                        <div class="form-group">
                            <button type="submit" class="btn btn-success btn-block">Zapisz</button>
                        </div>
                    </form>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <div class="col-md-6 my-4">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-4 text-center">Następny dzień
                        </div>
                        <div class="col-4 text-center"><%=dayNameFormat.format(nextDate).substring(0, 1).toUpperCase() + dayNameFormat.format(nextDate).substring(1)%>
                        </div>
                        <div class="col-4 text-center"><%=displayFormat.format(nextDate)%>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <%
                        MealPlanAssignmentEntity nextMealPlanAssignmentEntity = (MealPlanAssignmentEntity) request.getAttribute("nextMealPlanAssignmentEntity");
                        MealPlanEntity nextAssignedMealPlanEntity = (MealPlanEntity) request.getAttribute("nextAssignedMealPlanEntity");
                        if (nextAssignedMealPlanEntity != null) {
                    %>
                    <h5 class="card-title">
                        <a href="editMealPlan?id=<c:out value='<%=nextAssignedMealPlanEntity.getId()%>'/>"><c:out
                                value='<%=nextAssignedMealPlanEntity.getName()%>'/>
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
                                <div class='text-dark progress-bar bg-<%=Math.abs(nextAssignedMealPlanEntity.getKilocalories()-Objects.requireNonNull(userEntity).getKilocaloriesDemand()) < 100 ? "success" : "warning"%>'
                                     style='width: <c:out
                                             value='<%=nextAssignedMealPlanEntity.getKilocalories()/Objects.requireNonNull(userEntity).getKilocaloriesDemand()*100%>'/>%'>
                                </div>
                                <div style="bottom: 3%"
                                     class="justify-content-center d-flex position-absolute w-100"><c:out
                                        value='<%=String.format("%.2f", nextAssignedMealPlanEntity.getKilocalories())%>'/>
                                    /
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
                                <div class='text-dark progress-bar bg-<%=Math.abs(nextAssignedMealPlanEntity.getCarbohydrates()-Objects.requireNonNull(userEntity).getCarbohydratesDemand()) < 10 ? "success" : "warning"%>'
                                     style='width: <c:out
                                             value='<%=nextAssignedMealPlanEntity.getCarbohydrates()/Objects.requireNonNull(userEntity).getCarbohydratesDemand()*100%>'/>%'>
                                </div>
                                <div style="bottom: 3%"
                                     class="justify-content-center d-flex position-absolute w-100"><c:out
                                        value='<%=String.format("%.2f", nextAssignedMealPlanEntity.getCarbohydrates())%>'/>g
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
                                <div class='text-dark progress-bar bg-<%=Math.abs(nextAssignedMealPlanEntity.getFats()-Objects.requireNonNull(userEntity).getFatsDemand()) < 10 ? "success" : "warning"%>'
                                     style='width: <c:out
                                             value='<%=nextAssignedMealPlanEntity.getFats()/Objects.requireNonNull(userEntity).getFatsDemand()*100%>'/>%'>
                                </div>
                                <div style="bottom: 3%"
                                     class="justify-content-center d-flex position-absolute w-100"><c:out
                                        value='<%=String.format("%.2f", nextAssignedMealPlanEntity.getFats())%>'/>g
                                    /
                                    <c:out
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
                                <div class='text-dark progress-bar bg-<%=Math.abs(nextAssignedMealPlanEntity.getProteins()-Objects.requireNonNull(userEntity).getProteinsDemand()) < 10 ? "success" : "warning"%>'
                                     style='width: <c:out
                                             value='<%=nextAssignedMealPlanEntity.getProteins()/Objects.requireNonNull(userEntity).getProteinsDemand()*100%>'/>%'>
                                </div>
                                <div style="bottom: 3%"
                                     class="justify-content-center d-flex position-absolute w-100"><c:out
                                        value='<%=String.format("%.2f", nextAssignedMealPlanEntity.getProteins())%>'/>g
                                    /
                                    <c:out value='<%=Objects.requireNonNull(userEntity).getProteinsDemand()%>'/>g
                                </div>
                            </div>
                        </div>
                    </div>
                    <h6 class="mt-2">Posiłki</h6>
                    <hr/>
                    <div class="accordion">
                        <%
                            for (MealInclusionEntity mealInclusionEntity : nextAssignedMealPlanEntity.getMealInclusionEntities()) {
                                MealEntity mealEntity = mealInclusionEntity.getMealEntity();
                        %>
                        <div class="card">
                            <div class="card-header"
                                 id="heading<c:out value='<%=nextMealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>">
                                <div class="row" type="button btn btn-link" data-toggle="collapse"
                                     data-target="#collapse<c:out value='<%=nextMealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>"
                                     aria-expanded="true"
                                     aria-controls="collapse<c:out value='<%=nextMealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>">
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
                            <div id="collapse<c:out value='<%=nextMealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>"
                                 class="collapse<%=wasFirstMealCollapsed ? "" : " show"%>"
                                 aria-labelledby="heading<c:out value='<%=nextMealPlanAssignmentEntity.getId() + "_" + mealEntity.getId()%>'/>">
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
                    <%
                    } else {
                    %>
                    <div class="col-10 mx-auto mb-4 p-5 text-center alert alert-warning" role="alert">
                        Nie przypisałeś jeszcze planu na kolejny dzień
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="layout/footer.jsp" %>