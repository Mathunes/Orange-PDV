<%@page import="aplicacao.Categorias"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Categorias categoria = (Categorias)request.getAttribute("categoria");
    
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case "0":
            response.sendRedirect("usuarios.jsp");
            break;
        case "1":
            response.sendRedirect("vendas.jsp");
            break;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--Página de exibição do categoria por ID-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarcomprador.jsp" %>
        
        <div class="container">
            <h2>Área restrita - Visualizar categoria</h2>
            
            <div class="container-info">
                <a href="CategoriasController?acao=mostrar_categorias">
                    <button class="btn btn-voltar">Voltar</button>
                </a>
                    <table class="table mt-2">
                        <tbody>
                            <tr>
                                <td><b>Id</b></td>
                                <td><%= categoria.getId() %></td>
                            </tr>
                            <tr>
                                <td><b>Nome</b></td>
                                <td><%= categoria.getNomeCategoria() %></td>
                            </tr>                            
                        </tbody>
                    </table>
            </div>
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>

