<%@page import="aplicacao.Categorias"%>
<%@page import="java.util.Arrays"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "aplicacao.Produtos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
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
            <div class="row header">
                <div class="col-sm">
                    <h2>Área restrita - Compras</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="">
                    
                        <input type="hidden" name="acao" value="" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="busca" placeholder="Buscar compra pelo nome do fornecedor..." >
                            <button class="btn" type="submit">
                                <img src="assets/imagens/search.svg" alt="Lupa">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>