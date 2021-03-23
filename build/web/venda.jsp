<%@page import="aplicacao.Vendas"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Vendas venda = (Vendas)request.getAttribute("venda");
    
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case '0':
            response.sendRedirect("administrador.jsp");
            break;
        case '2':
            response.sendRedirect("compras.jsp");
            break;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--Página de exibição da venda por ID-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarvendedor.jsp" %>
        <div class="container">
            <h2>Área restrita - Visualizar venda</h2>
            
            <div class="container-info">
                <a href="vendas.jsp">
                    <button class="btn btn-voltar">Voltar</button>
                </a>
                    <table class="table mt-2">
                        <tbody>
                            <tr>
                                <td><b>Id da venda</b></td>
                                <td><%=venda.getId()%></td>
                            </tr>
                            <tr>
                                <td><b>Quant. de produtos</b></td>
                                <td><%=venda.getQuantidadeVenda()%></td>
                            </tr>
                            <tr>
                                <td><b>Data da venda</b></td>
                                <td><%=venda.getDataVenda()%></td>
                            </tr>
                            <tr>
                                <td><b>Valor da venda</b></td>
                                <td>R$ <%=Double.toString(venda.getValorVenda()).replace(".", ",")%></td>
                            </tr>
                            <tr>
                                <td><b>ID do cliente</b></td>
                                <td><%=venda.getIdCliente()%></td>
                            </tr>
                            <tr>
                                <td><b>Nome do cliente</b></td>
                                <td><%=venda.getNomeCliente()%></td>
                            </tr>
                            <tr>
                                <td><b>ID do produto</b></td>
                                <td><%=venda.getIdProduto()%></td>
                            </tr>
                            <tr>
                                <td><b>Nome do produto</b></td>
                                <td><%=venda.getNomeProduto()%></td>
                            </tr>
                            <tr>
                                <td><b>ID do vendedor</b></td>
                                <td><%=venda.getIdVendedor()%></td>
                            </tr>
                            <tr>
                                <td><b>Nome do vendedor</b></td>
                                <td><%=venda.getNomeVendedor()%></td>
                            </tr>
                        </tbody>
                    </table>
            </div>
            
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>
