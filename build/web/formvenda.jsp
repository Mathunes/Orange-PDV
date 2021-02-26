<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="aenavbar.jsp" %>
        
        <div class="container">
            
            <h2>Área restrita - Venda</h2>
            
            <form class="mt-4" id="form-cliente" method="POST" action="">
                <input type="hidden" name="idProduto" value="" required="">
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Nome do produto" aria-label="Nome do produto" name="nomeProduto" value="" required>
                    </div>
                    <div class="col-md mb-4">
                        <select class="form-select" aria-label="Nome cliente" name="Nome do cliente" required="">
                            <option selected>Cliente</option>
                            <option value="1">One</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="number" class="form-control" placeholder="Quantidade" aria-label="Quantidade" name="quantidade" value="" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="number" class="form-control" placeholder="Desconto %" aria-label="Desconto" name="desconto" value="" required>
                    </div>
                </div>
                <label></label>
                
                <input type="submit" class="btn btn-registrar" value="Registrar venda">
            </form>
            
        </div>
    </body>
</html>
