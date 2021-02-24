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
            <%@include file="toastmensagem.jsp" %>
            <h2>Área restrita - Novo cliente</h2>
            
            <form class="mt-4" method="POST" action="ClientesController">
                <input type="hidden" name="acao" value="novocliente">
                <input type="hidden" name="id" value="0">
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Nome do cliente" aria-label="Nome do cliente" name="nome" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control cpf" placeholder="CPF do cliente" aria-label="CPF do cliente" name="cpf" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Endereço do cliente" aria-label="Endereço do cliente" name="endereco" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Bairro do cliente" aria-label="Bairro do cliente" name="bairro" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Cidade do cliente" aria-label="Cidade do cliente" name="cidade" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Estado do cliente" aria-label="Estado do cliente" name="uf" maxlength="2" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control cep" placeholder="CEP do cliente" aria-label="CEP do cliente" name="cep" maxlength="8" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control telefone" placeholder="Telefone do cliente" aria-label="Telefone do cliente"  name="telefone" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col mb-4">
                        <input type="email" class="form-control" placeholder="Email do cliente" aria-label="Email do cliente" name="email" required>
                    </div>
                </div>
                <input type="submit" class="btn btn-registrar" value="Registrar cliente">
            </form>
        </div>
        
        <%@include file="scripts.html" %>
        <script src="js/mascaras.js"></script>
        <script>
            $( document ).ready(function() {
                if ($('#mensagem').text().trim() != "null") {
                    $('.toast').toast('show');
                }
            });
        </script>
    </body>
</html>
