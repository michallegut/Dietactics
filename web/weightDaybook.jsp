<%@ page import="com.dietactics.presentation.model.entities.WeightRecordEntity" %>
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
        SimpleDateFormat displayFormat = new SimpleDateFormat("dd.MM.yyyy EEEE");
        SimpleDateFormat monthNameFormat = new SimpleDateFormat("MMMM");
        SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
        Date today = (Date) request.getAttribute("today");
        Calendar currentMonth = (Calendar) request.getAttribute("currentMonth");
        Calendar calendar = (Calendar) request.getAttribute("calendar");
        boolean isCurrentMonth = calendar.get(Calendar.MONTH) == currentMonth.get(Calendar.MONTH) && calendar.get(Calendar.YEAR) == currentMonth.get(Calendar.YEAR);
        Calendar previousMonth = Calendar.getInstance();
        previousMonth.setTime(calendar.getTime());
        previousMonth.add(Calendar.MONTH, -1);
        Calendar nextMonth = Calendar.getInstance();
        nextMonth.setTime(calendar.getTime());
        nextMonth.add(Calendar.MONTH, 1);
    %>
    <h1 class="mt-4">Dzienik wagi</h1>
    <div class="row mt-4">
        <div class="col-12">
            <div class="card">
                <h5 class="card-header">Zarządzaj wpisami</h5>
                <div class="card-body">
                    <%
                        if (request.getParameter("emptyFields") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Wszystkie pola muszą zostać wypełnione
                    </div>
                    <%
                    } else if (request.getParameter("textWeight") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Waga musi być liczbą
                    </div>
                    <%
                    } else if (request.getParameter("weightRecordChanged") != null) {
                    %>
                    <div class="alert alert-success" role="alert">
                        Wpis został zmieniony pomyślnie
                    </div>
                    <%
                    } else if (request.getParameter("weightRecordAdded") != null) {
                    %>
                    <div class="alert alert-success" role="alert">
                        Wpis został dodany pomyślnie
                    </div>
                    <%
                    } else if (request.getParameter("noWeightRecord") != null) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Wpis dla podanej daty nie istnieje
                    </div>
                    <%
                    } else if (request.getParameter("weightRecordDeleted") != null) {
                    %>
                    <div class="alert alert-success" role="alert">
                        Wpis został usunięty pomyślnie
                    </div>
                    <%
                        }
                    %>
                    <form class="form-inline float-left m-0" method="post" action="addOrEditWeightRecord">
                        <div class="col-xs-3 mt-2 mr-2">
                            <div class="input-group">
                                <input type="text" class="form-control" id="weight" name="weight"
                                       placeholder="Podaj wagę">
                                <div class="input-group-append">
                                                <span class="input-group-text"
                                                      id="weightAppend">kg</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3 mt-2 mr-2">
                            <label for="addOrEditDate" class="d-none"></label><input type="date" class="form-control"
                                                                                     id="addOrEditDate"
                                                                                     name="date"
                                                                                     value='<c:out value='<%=sqlFormat.format(calendar.getTime())%>'/>'>
                        </div>
                        <div class="col-xs-3 mt-2 mr-2">
                            <button type="submit" class="btn btn-success">Zapisz</button>
                        </div>
                    </form>
                    <form class="float-left m-0" method="post" action="deleteWeightRecord"
                          onsubmit='this.date.value=document.getElementById("addOrEditDate").value;'>
                        <label for="deleteDate" class="d-none"></label>
                        <input type="date" id="deleteDate" name="date" hidden>
                        <div class="col-xs-3 mt-2">
                            <button type="submit" class="btn btn-danger">Usuń</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12 my-4">
            <div class="card<%=isCurrentMonth ? " border-primary" : ""%>">
                <div class="card-header<%=isCurrentMonth ? " bg-primary text-light" : ""%>">
                    <div class="row">
                        <h4 class="col-md-3 my-0">
                            <%=monthNameFormat.format(calendar.getTime()).substring(0, 1).toUpperCase() + monthNameFormat.format(calendar.getTime()).substring(1) + " " + yearFormat.format(calendar.getTime())%>
                        </h4>
                        <div class="col-md-6 my-2">
                            <a class="btn btn-warning"
                               href='weightDaybook?month=<c:out value='<%=(previousMonth.get(Calendar.MONTH) + 1) + "&year=" + previousMonth.get(Calendar.YEAR)%>'/>'>Poprzedni</a>
                            <a class="btn btn-secondary"
                               href='weightDaybook?month=<c:out value='<%=(currentMonth.get(Calendar.MONTH) + 1) + "&year=" + currentMonth.get(Calendar.YEAR)%>'/>'>Obecny</a>
                            <a class="btn btn-info"
                               href='weightDaybook?month=<c:out value='<%=(nextMonth.get(Calendar.MONTH) + 1) + "&year=" + nextMonth.get(Calendar.YEAR)%>'/>'>Następny</a>
                        </div>
                        <div class="col-md-3">
                            <%
                                if (isCurrentMonth) {
                            %>
                            <div class="alert alert-primary text-center my-0">
                                <small>Obecny miesiąc
                                </small>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-9 my-4">
                            <canvas id="monthWeightChartCanvas"></canvas>
                            <canvas class="mt-4" id="generalWeightChartCanvas"></canvas>
                        </div>
                        <div class="col-md-3">
                            <h5 class="text-center mt-0 mb-3">Lista wpisów</h5>
                            <ul class="list-group">
                                <%
                                    List<WeightRecordEntity> weightRecordEntities = (List<WeightRecordEntity>) request.getAttribute("weightRecordEntities");
                                    Collections.sort(Objects.requireNonNull(weightRecordEntities));
                                    for (int index = 0; calendar.get(Calendar.DAY_OF_MONTH) < calendar.getActualMaximum(Calendar.DAY_OF_MONTH); calendar.add(Calendar.DAY_OF_MONTH, 1)) {
                                        Date date = Date.valueOf(sqlFormat.format(calendar.getTime()));
                                %>
                                <li class="list-group-item<%=date.equals(today) ? " active" : ""%>">
                                    <div class="row">
                                        <div class="col-12 text-center"><%=displayFormat.format(date)%>
                                        </div>
                                    </div>
                                        <%
                                        if (date.equals(today)) {
                                            %>
                                    <div class="alert alert-primary text-center mt-2 mb-0">
                                        <small>Dzisiejszy dzień
                                        </small>
                                    </div>
                                        <%
                                        }
                                        if (!weightRecordEntities.isEmpty() && index < weightRecordEntities.size() && weightRecordEntities.get(index).getDate().equals(date)){
                                        %>
                                    <div class="alert alert-success text-center mt-2 mb-0">
                                        <small><c:out
                                                value='<%=String.format("%.1f", weightRecordEntities.get(index).getWeight())%>'/>
                                            kg
                                        </small>
                                    </div>
                                        <%
                                        index++;
                                        } else {
                                            %>
                                    <div class="alert alert-warning text-center mt-2 mb-0">
                                        <small>
                                            Brak wpisu
                                        </small>
                                    </div>
                                        <%
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="vendor/chart/Chart.bundle.js"></script>
<script>
    var monthWeightChartCanvas = document.getElementById("monthWeightChartCanvas");
    var monthWeightChart = new Chart(monthWeightChartCanvas, {
        type: 'line',
        data: {
            <%
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("[");
            if (!weightRecordEntities.isEmpty()) {
            for (WeightRecordEntity weightRecordEntity : weightRecordEntities) {
                stringBuilder.append("{x: ");
                stringBuilder.append('"');
                stringBuilder.append(weightRecordEntity.getDate());
                stringBuilder.append('"');
                stringBuilder.append(",y: ");
                stringBuilder.append(weightRecordEntity.getWeight());
                stringBuilder.append("}, ");
            }
            stringBuilder.deleteCharAt(stringBuilder.length()-1);
            stringBuilder.deleteCharAt(stringBuilder.length()-1);
            }
            stringBuilder.append("]");
            %>
            datasets: [{
                borderColor: '#127cd4',
                backgroundColor: '#127cd4',
                fill: false,
                lineTension: 0,
                data: <%=stringBuilder.toString()%>
            }]
        },
        options: {
            responsive: true,
            title: {
                display: true,
                text: '<%=monthNameFormat.format(calendar.getTime()).substring(0, 1).toUpperCase() + monthNameFormat.format(calendar.getTime()).substring(1) + " " + yearFormat.format(calendar.getTime())%>'
            },
            scales: {
                xAxes: [{
                    type: "time",
                    time: {
                        unit: 'day',
                        displayFormats: {
                            day: 'DD.MM.YYYY'
                        },
                        distribution: 'linear'
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Data'
                    }
                }],
                yAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'Waga'
                    }
                }]
            },
            legend: {
                display: false
            }
        }
    });
    var generalWeightChartCanvas = document.getElementById("generalWeightChartCanvas");
    var generalWeightChart = new Chart(generalWeightChartCanvas, {
        type: 'line',
        data: {
            <%
            List<WeightRecordEntity> allWeightRecordEntities = (List<WeightRecordEntity>) request.getAttribute("allWeightRecordEntities");
            Collections.sort(Objects.requireNonNull(allWeightRecordEntities));
            stringBuilder = new StringBuilder();
            stringBuilder.append("[");
            if (!allWeightRecordEntities.isEmpty()) {
            for (WeightRecordEntity weightRecordEntity : allWeightRecordEntities) {
                stringBuilder.append("{x: ");
                stringBuilder.append('"');
                stringBuilder.append(weightRecordEntity.getDate());
                stringBuilder.append('"');
                stringBuilder.append(",y: ");
                stringBuilder.append(weightRecordEntity.getWeight());
                stringBuilder.append("}, ");
            }
            stringBuilder.deleteCharAt(stringBuilder.length()-1);
            stringBuilder.deleteCharAt(stringBuilder.length()-1);
            }
            stringBuilder.append("]");
            %>
            datasets: [{
                borderColor: '#127cd4',
                backgroundColor: '#127cd4',
                fill: false,
                borderWidth: 1,
                data: <%=stringBuilder.toString()%>
            }]
        },
        options: {
            responsive: true,
            title: {
                display: true,
                text: 'Wszystkie wpisy'
            },
            scales: {
                xAxes: [{
                    type: "time",
                    time: {
                        displayFormats: {
                            day: 'DD.MM.YYYY',
                            month: 'MM.YYYY',
                            year: 'YYYY'
                        },
                        distribution: 'linear'
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Data'
                    }
                }],
                yAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'Waga'
                    }
                }]
            },
            legend: {
                display: false
            },
            tooltips: {
                enabled: false
            },
            elements: {
                point: {
                    radius: 0,
                    hitRadius: 0
                }
            }
        }
    });
</script>
<%@include file="layout/footer.jsp" %>