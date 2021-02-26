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
                    <div class="col-md mb-4">
                        <select class="form-select" aria-label="Nome produto" name="Nome do produto" required="">
                            <option selected>Produto</option>
                            <option value="1">One</option>
                        </select>
                    </div>
                    <div class="col-md mb-4">
                        <select class="form-select" aria-label="Nome cliente" name="Nome do cliente" required="">
                            <option selected>Cliente</option>
                            <option value="1">One</option>
                        </select>
                    </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="quantidade" class="form-label">Quantidade</label>
                        <input type="number" class="form-control" placeholder="Quantidade" aria-label="Quantidade" name="quantidade" value="" id="quantidade" min="1" required>
                    </div>
                    <div class="col-md mb-4">
                        <label for="desconto" class="form-label">Desconto</label>
                        <input type="number" class="form-control" placeholder="Desconto %" aria-label="Desconto" name="desconto" value="0" id="desconto" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="valor-produto" class="form-label">Valor unitário</label>
                        <input type="number" class="form-control" placeholder="Valor unitário" aria-label="Valor unitário" name="valorProduto" value="" id="valor-produto" disabled="" required>
                    </div>
                    <div class="col-md mb-4">
                        <label for="valor-total" class="form-label">Valor total</label>
                        <input type="number" class="form-control" placeholder="Valor total" aria-label="Valor total" name="valorTotal" value="" id="valor-total" disabled="" required>
                    </div>
                </div>
                
                <input type="submit" class="btn btn-registrar" value="Registrar venda">
            </form>
            
        </div>
    </body>
</html>
