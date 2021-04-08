<%@page import="aplicacao.Produtos"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Produtos produto = (Produtos)request.getAttribute("produto");
    
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
<!--Página de exibição do produto por ID-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarcomprador.jsp" %>
        <div class="container">
            <h2>Área restrita - Visualizar produto</h2>
            
            <div class="container-info">
                <a href="produtoscomprador.jsp">
                    <button class="btn btn-voltar">Voltar</button>
                </a>
                    <table class="table mt-2">
                        <tbody>
                            <tr>
                                <td><b>Id do produto</b></td>
                                <td><%=produto.getId()%></td>
                            </tr>
                            <tr>
                                <td><b>Nome produto</b></td>
                                <td><%=produto.getNomeProduto()%></td>
                            </tr>
                            <tr>
                                <td><b>Descrição</b></td>
                                <td><%=produto.getDescricao()%></td>
                            </tr>
                            <tr>
                                <td><b>Preço compra</b></td>
                                <td>R$ <%=Double.toString(produto.getPrecoCompra()).replace(".", ",")%></td>
                            </tr>
                            <tr>
                                <td><b>Preço venda</b></td>
                                <td>R$ <%=Double.toString(produto.getPrecoVenda()).replace(".", ",")%></td>
                            </tr>
                            <tr>
                                <td><b>Quantidade disponível</b></td>
                                <td><%=produto.getQuantidadeDisponivel() %></td>
                            </tr>
                            <tr>
                                <td><b>Liberado Venda</b></td>
                                <td><%=(produto.getLiberadoVenda().equals("S")) ? "Sim" : "Não" %></td>
                            </tr>
                            <tr>
                                <td><b>ID categoria</b></td>
                                <td><%=produto.getIdCategoria()%></td>
                            </tr>
                            <tr>
                                <td><b>Nome categoria</b></td>
                                <td><%=produto.getNomeCategoria()%></td>
                            </tr>
                        </tbody>
                    </table>
            </div>
            
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>