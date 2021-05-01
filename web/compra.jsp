<%@page import="aplicacao.Utilitario"%>
<%@page import="aplicacao.Compras"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Compras compra = (Compras)request.getAttribute("compra");
    
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
<!--Página de exibição da compra por ID-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarcomprador.jsp" %>
        <div class="container">
            <h2>Área restrita - Visualizar compra</h2>
            
            <div class="container-info">
                <a href="compras.jsp">
                    <button class="btn btn-voltar">Voltar</button>
                </a>
                    <table class="table mt-2">
                        <tbody>
                            <tr>
                                <td><b>Id da compra</b></td>
                                <td><%=compra.getId()%></td>
                            </tr>
                            <tr>
                                <td><b>Quant. de produtos</b></td>
                                <td><%=compra.getQuantidadeCompra()%></td>
                            </tr>
                            <tr>
                                <td><b>Data da compra</b></td>
                                <td><%=Utilitario.formataData(compra.getDataCompra())%></td>
                            </tr>
                            <tr>
                                <td><b>Valor da compra</b></td>
                                <td>R$ <%=Double.toString(compra.getValorCompra()).replace(".", ",")%></td>
                            </tr>
                            <tr>
                                <td><b>ID do Fornecedor</b></td>
                                <td><%=compra.getIdFornecedor()%></td>
                            </tr>
                            <tr>
                                <td><b>Razão Social</b></td>
                                <td><%=compra.getRazaoSocialFornecedor()%></td>
                            </tr>
                            <tr>
                                <td><b>ID do produto</b></td>
                                <td><%=compra.getIdProduto()%></td>
                            </tr>
                            <tr>
                                <td><b>Nome do produto</b></td>
                                <td><%=compra.getNomeProduto()%></td>
                            </tr>
                            <tr>
                                <td><b>ID do comprador</b></td>
                                <td><%=compra.getIdComprador()%></td>
                            </tr>
                            <tr>
                                <td><b>Nome do comprador</b></td>
                                <td><%=compra.getNomeComprador()%></td>
                            </tr>
                        </tbody>
                    </table>
            </div>
            
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>
