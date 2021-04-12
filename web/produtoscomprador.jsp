<%@page import="aplicacao.Produtos"%>
<%@page import="java.util.ArrayList"%>
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
            <!-- Mensagens  -->
            <div id="container-alert">
                <p hidden id="mensagem"><%= request.getAttribute("mensagem")%></p>
            </div>
            
            <div class="row header">
                <div class="col-sm">
                    <h2>Área restrita - Produtos</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="ProdutosController">
                    
                        <input type="hidden" name="acaoRestrito" value="mostrar_produto_busca" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="busca" placeholder="Buscar produto..." >
                            <button class="btn" type="submit">
                                <img src="assets/imagens/search.svg" alt="Lupa">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="container-table mb-4">
                <a href="ProdutosController?acaoRestrito=cadastrar_produto&produto=0">
                    <button class="btn btn-novo">Novo produto</button>
                </a>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Nome produto</th>
                            <th scope="col">Venda</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <%
                            ArrayList<Produtos> produtos = (ArrayList<Produtos>) request.getAttribute("produtos");
                            //Se não houver produtos, pedir para o servidor enviar
                            if (produtos == null)
                                response.sendRedirect("ProdutosController?acaoRestrito=mostrar_produtos");
                            else
                                for (int i = 0; i < produtos.size(); i++) {
                                    Produtos produto = produtos.get(i);
                                    String linkExibirProduto = "ProdutosController?acaoRestrito=mostrar_produto&id="+produto.getId();
                                    String linkEditarProduto = "ProdutosController?acaoRestrito=editar_produto&id="+produto.getId();
                            
                        %>                        
                        
                        <tr class="info-produto">
                            <td><%=produto.getNomeProduto() %></td>
                            <td><%=produto.getLiberadoVenda().equals("S") ? "Liberada" : "Bloqueada" %></td>
                            <td>
                                <button class="btn-liberar" name="<%=produto.getId()%>-<%=produto.getLiberadoVenda()%>" value="<%=produto.getNomeProduto()%>"><img src="assets/imagens/padlock-fill.svg" class="btn-icon" style="width: 15px; height: 15px;" alt="Liberar produto" data-bs-toggle="modal" data-bs-target="#modalLiberar"></button>
                            </td>
                            <td>
                                <a href="<%=linkExibirProduto%>"><img src="assets/imagens/eye-fill.svg" class="btn-icon" alt="Exibir produto"></a>
                            </td>
                            <td>
                                <a href="<%=linkEditarProduto%>"><img src="assets/imagens/pencil-fill.svg" class="btn-icon" alt="Editar produto"></a>
                            </td>
                            <td>
                                <button class="btn-excluir" name="<%=produto.getId()%>" value="<%=produto.getNomeProduto()%>"><img src="assets/imagens/trash-fill.svg" class="btn-icon" alt="Excluir produto" data-bs-toggle="modal" data-bs-target="#modalExcluir"></button>
                            </td>
                        </tr>
                        <%
                                }
                        %>
                        
                    </tbody>
                </table>
            </div>
            
        </div>
        
        <!--Modal para confirmar exclusão do produto-->
        <div class="modal fade" id="modalExcluir" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Excluir produto</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="modal-mensagem"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Não</button>
                        <a href="" id="link-delete">
                            <button type="button" class="btn btn-primary">Sim</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>           
        
        <!--Modal para confirmar liberação do produto-->
        <div class="modal fade" id="modalLiberar" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Liberar produto</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p id="modal-mensagem-liberar"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Não</button>
                        <a href="" id="link-liberar">
                            <button type="button" class="btn btn-primary">Sim</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>           
        
        <%@include file="scripts.html" %>
        <script>            
            $(document).ready(function(){      
                //Excluir produto
                $(".info-produto").find("button[class='btn-excluir']").click(function(){
                    var nomeProduto = $(this).attr("value");
                    var id = $(this).attr("name");
                    
                    $('#modal-mensagem').text("Deseja realmente excluir o produto " + nomeProduto + "?");
                    $('#link-delete').attr("href", "ProdutosController?acaoRestrito=excluir_produto&id=" + id);
                });
                
                //Liberar produto
                $(".info-produto").find("button[class='btn-liberar']").click(function(){
                    var nomeProduto = $(this).attr("value");
                    var name = $(this).attr("name").split("-");
                    var id = name[0];
                    var acao = (name[1] == "S") ? "bloquear" : "liberar";
                    
                    $('#modal-mensagem-liberar').text("Deseja realmente " + acao + " o produto " + nomeProduto + " para venda?");
                    $('#link-liberar').attr("href", "ProdutosController?acaoRestrito=liberar_produto&id=" + id + "&bloquear=" + name[1]);
                });
                
                //Exibir mensagem
                if ($('#mensagem').text().trim() != "null") {
                    $('#container-alert').append("<%@include file="mensagem.jsp" %>");
                }
            });
        </script>
    </body>
</html>