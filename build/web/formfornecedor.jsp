<%@page import="aplicacao.Fornecedores"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Fornecedores fornecedor = (Fornecedores)request.getAttribute("fornecedor");
    
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case '0':
            response.sendRedirect("administrador.jsp");
            break;
        case '1':
            response.sendRedirect("vendas.jsp");
            break;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--Página cadastro do fornecedor-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarvendedor.jsp" %>
        
<!--        <div class="container">
            Toast para ser exibido caso o CPF informado seja inválido
            <div aria-live="polite" aria-atomic="true" class="d-flex justify-content-center w-100 position-absolute top-0 end-0 mt-2">
                <div class="toast-container">
                    <div class="toast text-white bg-warning" role="alert" aria-live="assertive" aria-atomic="true">
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
            </div>-->
                                
            <h2>Área restrita - Fornecedores</h2>
            
            <form class="mt-4" id="form-fornecedor" method="POST" action="FornecedoresController">
                <input type="hidden" name="id" value="<%=fornecedor.getId()%>" required="">
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Razão Social do fornecedor" aria-label="Razão Social do fornecedor" name="razao_social" maxlength="50" value="<%=fornecedor.getRazaoSocial()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control cpf" placeholder="CNPJ do fornecedor" aria-label="CNPJ do fornecedor" name="cnpj" maxlength="14" value="<%=fornecedor.getCnpj()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Endereço do fornecedor" aria-label="Endereço do fornecedor" name="endereco" maxlength="50" value="<%=fornecedor.getEndereco()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Bairro do fornecedor" aria-label="Bairro do fornecedor" name="bairro" maxlength="50" value="<%=fornecedor.getBairro()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Cidade do fornecedor" aria-label="Cidade do fornecedor" name="cidade" maxlength="50" value="<%=fornecedor.getCidade()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="UF do fornecedor" aria-label="UF do fornecedor" name="uf" maxlength="2" value="<%=fornecedor.getUf()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control cep" placeholder="CEP do fornecedor" aria-label="CEP do fornecedor" name="cep" maxlength="8" value="<%=fornecedor.getCep()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control telefone" placeholder="Telefone do fornecedor" aria-label="Telefone do fornecedor" name="telefone" maxlength="20" value="<%=fornecedor.getTelefone()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col mb-4">
                        <input type="email" class="form-control" placeholder="Email do fornecedor" aria-label="Email do fornecedor" name="email" maxlength="50" value="<%=fornecedor.getEmail()%>" required>
                    </div>
                </div>
                <input type="submit" class="btn btn-registrar" value="Registrar fornecedor">
            </form>
        </div>
        
        <%@include file="scripts.html" %>
        <script src="js/mascaras.js"></script>
        <script>
            $( document ).ready(function() {
                //Ouvindo evento de envio do formulário
                $('#form-fornecedor').submit(() => {
                    //Interrompendo o envio
                    event.preventDefault();
                    //Verificando se o CPF é válido
                    if (validaCPF($('.cpf').val())) {
                        //Enviando o formulário
                        $('#form-fornecedor').unbind('submit').submit();
                    } else {
                        //Exibindo a mensagem de erro
                        $('.toast').toast('show');
                    }
                       
                });
                
            });
        </script>
    </body>
</html>