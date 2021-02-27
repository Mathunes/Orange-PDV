<%@page import="aplicacao.Clientes"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Clientes cliente = (Clientes)request.getAttribute("cliente");
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
            <h2>Área restrita - Visualizar cliente</h2>
            
            <div class="container-info">
                <a href="ClientesController?acao=mostrar_clientes">
                    <button class="btn btn-voltar">Voltar</button>
                </a>
                    <table class="table mt-2">
                        <tbody>
                            <tr>
                                <td><b>Id</b></td>
                                <td><%= cliente.getId() %></td>
                            </tr>
                            <tr>
                                <td><b>Nome</b></td>
                                <td><%= cliente.getNome() %></td>
                            </tr>
                            <tr>
                                <td><b>CPF</b></td>
                                <td><%= cliente.getCpf() %></td>
                            </tr>
                            <tr>
                                <td><b>Endereço</b></td>
                                <td><%= cliente.getEndereco() %></td>
                            </tr>
                            <tr>
                                <td><b>Bairro</b></td>
                                <td><%= cliente.getBairro() %></td>
                            </tr>
                            <tr>
                                <td><b>Cidade</b></td>
                                <td><%= cliente.getCidade() %></td>
                            </tr>
                            <tr>
                                <td><b>UF</b></td>
                                <td><%= cliente.getUf() %></td>
                            </tr>
                            <tr>
                                <td><b>CEP</b></td>
                                <td><%= cliente.getCep() %></td>
                            </tr>
                            <tr>
                                <td><b>Telefone</b></td>
                                <td><%= cliente.getTelefone() %></td>
                            </tr>
                            <tr>
                                <td><b>Email</b></td>
                                <td><%= cliente.getEmail() %></td>
                            </tr>
                        </tbody>
                    </table>
            </div>
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>
