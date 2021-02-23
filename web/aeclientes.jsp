<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="aenavbar.jsp" %>
        
        <div class="container">
            <div class="row">
                <div class="col">
                    <h2>Área restrita - Clientes</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Buscar produto..." >
                        <button class="btn " type="button">
                            <img src="assets/imagens/search.svg" alt="Lupa">
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="scripts.html" %>
    </body>
</html>
