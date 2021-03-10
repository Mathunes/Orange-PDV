<%@page import="aplicacao.Clientes"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Clientes cliente = (Clientes)request.getAttribute("cliente");
    
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case '0':
            response.sendRedirect("administrador.jsp");
            break;
        case '2':
            response.sendRedirect("comprador.jsp");
            break;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarvendedor.jsp" %>
        
        <div class="container">
            
            <div aria-live="polite" aria-atomic="true" class="d-flex justify-content-center w-100 position-absolute top-0 end-0 mt-2">
                <div class="toast-container">
                    <div class="toast text-white bg-info" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="d-flex">
                            <div class="toast-body">
                                <span id="mensagem">
                                    Informe um CPF válido
                                </span>
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                    </div>
                </div>
            </div>
                                
            <h2>Área restrita - Clientes</h2>
            
            <form class="mt-4" id="form-cliente" method="POST" action="ClientesController">
                <input type="hidden" name="id" value="<%=cliente.getId()%>" required="">
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Nome do cliente" aria-label="Nome do cliente" name="nome" maxlength="50" value="<%=cliente.getNome()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control cpf" placeholder="CPF do cliente" aria-label="CPF do cliente" name="cpf" maxlength="14" value="<%=cliente.getCpf()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Endereço do cliente" aria-label="Endereço do cliente" name="endereco" maxlength="50" value="<%=cliente.getEndereco()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Bairro do cliente" aria-label="Bairro do cliente" name="bairro" maxlength="50" value="<%=cliente.getBairro()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Cidade do cliente" aria-label="Cidade do cliente" name="cidade" maxlength="50" value="<%=cliente.getCidade()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="UF do cliente" aria-label="UF do cliente" name="uf" maxlength="2" value="<%=cliente.getUf()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control cep" placeholder="CEP do cliente" aria-label="CEP do cliente" name="cep" maxlength="8" value="<%=cliente.getCep()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control telefone" placeholder="Telefone do cliente" aria-label="Telefone do cliente" name="telefone" maxlength="20" value="<%=cliente.getTelefone()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col mb-4">
                        <input type="email" class="form-control" placeholder="Email do cliente" aria-label="Email do cliente" name="email" maxlength="50" value="<%=cliente.getEmail()%>" required>
                    </div>
                </div>
                <input type="submit" class="btn btn-registrar" value="Registrar cliente">
            </form>
        </div>
        
        <%@include file="scripts.html" %>
        <script src="js/mascaras.js"></script>
        <script src="js/valida-cpf.js"></script>
        <script>
            $( document ).ready(function() {
                
                $('#form-cliente').submit(() => {
                    event.preventDefault();
                    if (validaCPF($('.cpf').val())) {
                        $('#form-cliente').unbind('submit').submit();
                    } else {
                        $('.toast').toast('show');
                    }
                       
                });
                
            });
        </script>
    </body>
</html>
