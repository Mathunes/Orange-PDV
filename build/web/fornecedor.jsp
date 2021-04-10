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
<!--Página de exibição do fornecedor por ID-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarcomprador.jsp" %>
        
        <div class="container">
            <h2>Área restrita - Visualizar fornecedor</h2>
            
            <div class="container-info">
                <a href="FornecedoresController?acao=mostrar_fornecedores">
                    <button class="btn btn-voltar">Voltar</button>
                </a>
                    <table class="table mt-2">
                        <tbody>
                            <tr>
                                <td><b>Id</b></td>
                                <td><%= fornecedor.getId() %></td>
                            </tr>
                            <tr>
                                <td><b>Nome</b></td>
                                <td><%= fornecedor.getRazaoSocial() %></td>
                            </tr>
                            <tr>
                                <td><b>CPF</b></td>
                                <td><%= fornecedor.getCnpj() %></td>
                            </tr>
                            <tr>
                                <td><b>Endereço</b></td>
                                <td><%= fornecedor.getEndereco() %></td>
                            </tr>
                            <tr>
                                <td><b>Bairro</b></td>
                                <td><%= fornecedor.getBairro() %></td>
                            </tr>
                            <tr>
                                <td><b>Cidade</b></td>
                                <td><%= fornecedor.getCidade() %></td>
                            </tr>
                            <tr>
                                <td><b>UF</b></td>
                                <td><%= fornecedor.getUf() %></td>
                            </tr>
                            <tr>
                                <td><b>CEP</b></td>
                                <td><%= fornecedor.getCep() %></td>
                            </tr>
                            <tr>
                                <td><b>Telefone</b></td>
                                <td><%= fornecedor.getTelefone() %></td>
                            </tr>
                            <tr>
                                <td><b>Email</b></td>
                                <td><%= fornecedor.getEmail() %></td>
                            </tr>
                        </tbody>
                    </table>
            </div>
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>
