<%@page import="aplicacao.Compras"%>
<%@page import="aplicacao.Categorias"%>
<%@page import="java.util.Arrays"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "aplicacao.Produtos"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
    switch (usuario.getTipo()) {
        case '0':
            response.sendRedirect("administrador.jsp");
            break;
        case '1':
            response.sendRedirect("produtos.jsp");
            break;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarcomprador.jsp" %>
        
        <div class="container">
            
            <div class="row header">
                <div class="col-sm">
                    <h2>Área restrita - Compras</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="">
                    
                        <input type="hidden" name="acao" value="" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="busca" placeholder="Buscar compra pelo nome do fornecedor..." >
                            <button class="btn" type="submit">
                                <img src="assets/imagens/search.svg" alt="Lupa">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="container-table mb-4">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Fornecedor</th>
                            <th scope="col">Nome produto</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <%
                            ArrayList<Compras> compras = (ArrayList<Compras>) request.getAttribute("compras");
                            //Se não houver vendas, pedir para o servidor enviar
                            if (compras == null)
                                response.sendRedirect("ComprasController?acao=mostrar_compras");
                            else
                                for (int i = 0; i < compras.size(); i++) {
                                    Compras compra = compras.get(i);
                                    if (compra.getIdComprador() == usuario.getId()) {
                                        String linkExibirCompra = "ComprasController?acao=mostrar_compra&id="+compra.getId();
                                        String linkEditarCompra = "VendasController?acao=editar_venda&id="+compra.getId();
                            
                        %>                        
                        
                        <tr class="info-venda">
                            <td><%=compra.getId()%></td>
                            <td><%=compra.getRazaoSocialFornecedor()%></td>
                            <td><%=compra.getNomeProduto()%></td>
                            <td>
                                <a href="<%=linkExibirCompra%>"><img src="assets/imagens/eye-fill.svg" alt="Exibir venda"></a>
                            </td>
                            <td>
                                <a href="<%=linkEditarCompra%>"><img src="assets/imagens/pencil-fill.svg" alt="Editar venda"></a>
                            </td>
                            <td>
                                <button class="btn-excluir" name="<%=compra.getId()%>" value="<%=compra.getId()%>"><img src="assets/imagens/trash-fill.svg" alt="Excluir venda" data-bs-toggle="modal" data-bs-target="#modalExcluir"></button>
                            </td>
                        </tr>
                        <%
                                    }
                                }
                        %>
                        
                    </tbody>
                </table>
            </div>
            
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>