<%@page import="aplicacao.Usuarios"%>
<%
    Usuarios usuario = (Usuarios)request.getAttribute("usuario");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="aenavbar.jsp" %>
        <h1>Hello World!</h1>
        <%= usuario.getNome() %>
        <%@include file="scripts.html" %>
    </body>
</html>
