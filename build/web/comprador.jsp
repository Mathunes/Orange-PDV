<%@page import="aplicacao.Categorias"%>
<%@page import="java.util.Arrays"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "aplicacao.Produtos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
    switch (usuario.getTipo()) {
        case '0':
            response.sendRedirect("administrador.jsp");
            break;
        case '1':
            response.sendRedirect("produtos.jsp");
            break;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarcomprador.jsp" %>
        
        <div class="container">
            <h2>Área do comprador - em construção</h2>
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>