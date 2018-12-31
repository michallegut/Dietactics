<%@ page contentType="text/html;charset=UTF-8" %>
<% if (request.getSession().getAttribute("username") == null) {
%>
<%@include file="layout/anonymousHeader.jsp" %>
<%
} else {
%>
<%@include file="layout/userHeader.jsp" %>
<%
    }
%>
<div class="container">
    <div class="row">
        <div class="col-12 mx-auto mt-5 p-5 alert alert-danger text-center" role="alert">
            <h4>Wystąpił nieoczekiwany błąd</h4>
        </div>
    </div>
    <div class="row">
        <a href="<%=request.getSession().getAttribute("username") == null ? "index" : "profile"%>" type="button"
           class="btn btn-primary mt-4 mx-auto btn-lg">Powrót</a>
    </div>
</div>
<%@include file="layout/footer.jsp" %>