<%@page import="aplicacao.Usuarios"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Usuarios usuarioChamado = (Usuarios)request.getAttribute("usuario");
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case "1":
            response.sendRedirect("vendas.jsp");
            break;
        case "2":
            response.sendRedirect("compras.jsp");
            break;
    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--Página de exibição do usuario por ID-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbaradministrador.jsp" %>
        
        <div class="container">
            <h2>Área restrita - Visualizar usuário</h2>
            
            <div class="container-info">
                <a href="UsuariosController?acao=mostrar_usuarios">
                    <button class="btn btn-voltar">Voltar</button>
                </a>
                    <table class="table mt-2">
                        <tbody>
                            <tr>
                                <td><b>Id</b></td>
                                <td><%= usuarioChamado.getId() %></td>
                            </tr>
                            <tr>
                                <td><b>Nome</b></td>
                                <td><%= usuarioChamado.getNome() %></td>
                            </tr>
                            <tr>
                                <td><b>CPF</b></td>
                                <td><%= usuarioChamado.getCpf() %></td>
                            </tr>
                            <tr>
                                <td><b>Senha</b></td>
                                <td><%= usuarioChamado.getSenha() %></td>
                            </tr>
                            <tr>
                                <td><b>Tipo</b></td>
                                <td><%= usuarioChamado.getTipo() %></td>
                            </tr>
                        </tbody>
                    </table>
            </div>
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>
