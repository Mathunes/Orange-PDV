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
            <h2>Área restrita - Novo cliente</h2>
            
            <form class="mt-4">
                <div class="row mb-2">
                    <div class="col-md mb-2">
                        <input type="text" class="form-control" placeholder="Nome do cliente" aria-label="Nome do cliente" required>
                    </div>
                    <div class="col-md mb-2">
                        <input type="text" class="form-control" placeholder="CPF do cliente" aria-label="CPF do cliente" required>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-md mb-2">
                        <input type="text" class="form-control" placeholder="Endereço do cliente" aria-label="Nome do cliente" required>
                    </div>
                    <div class="col-md mb-2">
                        <input type="text" class="form-control" placeholder="Bairro do cliente" aria-label="CPF do cliente" required>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-md mb-2">
                        <input type="text" class="form-control" placeholder="Cidade do cliente" aria-label="Nome do cliente" required>
                    </div>
                    <div class="col-md mb-2">
                        <input type="text" class="form-control" placeholder="Estado do cliente" aria-label="CPF do cliente" required>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col-md mb-2">
                        <input type="text" class="form-control" placeholder="CEP do cliente" aria-label="Nome do cliente" required>
                    </div>
                    <div class="col-md mb-2">
                        <input type="text" class="form-control" placeholder="Telefone do cliente" aria-label="CPF do cliente" required>
                    </div>
                </div>
                <div class="row mb-2">
                    <div class="col">
                        <input type="text" class="form-control" placeholder="Email do cliente" aria-label="Nome do cliente" required>
                    </div>
                </div>
                <input type="submit" class="btn btn-registrar" value="Registrar cliente">
            </form>
        </div>
        
    </body>
</html>
