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
            <!-- Mensagens  -->
            <div id="container-alert">
                <p hidden id="mensagem"><%= request.getAttribute("mensagem")%></p>
            </div>
            
            <div class="row header">
                <div class="col-sm">
                    <h2>Área restrita - Compras</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="">
                    
                        <input type="hidden" name="acao" value="mostrar_compra_busca" required>
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
                <a href="ComprasController?acao=cadastrar_compra&produto=0">
                    <button class="btn btn-novo">Nova compra</button>
                </a>
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
                            //Se não houver compras, pedir para o servidor enviar
                            if (compras == null)
                                response.sendRedirect("ComprasController?acao=mostrar_compras");
                            else
                                for (int i = 0; i < compras.size(); i++) {
                                    Compras compra = compras.get(i);
                                    if (compra.getIdComprador() == usuario.getId()) {
                                        String linkExibirCompra = "ComprasController?acao=mostrar_compra&id="+compra.getId();
                                        String linkEditarCompra = "ComprasController?acao=editar_compra&id="+compra.getId();
                            
                        %>                        
                        
                        <tr class="info-compra">
                            <td><%=compra.getId()%></td>
                            <td><%=compra.getRazaoSocialFornecedor()%></td>
                            <td><%=compra.getNomeProduto()%></td>
                            <td>
                                <a href="<%=linkExibirCompra%>"><img src="assets/imagens/eye-fill.svg" alt="Exibir compra"></a>
                            </td>
                            <td>
                                <a href="<%=linkEditarCompra%>"><img src="assets/imagens/pencil-fill.svg" alt="Editar compra"></a>
                            </td>
                            <td>
                                <button class="btn-excluir" name="<%=compra.getId()%>" value="<%=compra.getId()%>"><img src="assets/imagens/trash-fill.svg" alt="Excluir compra" data-bs-toggle="modal" data-bs-target="#modalExcluir"></button>
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
        <!--Modal para confirmar exclusão da compra-->
        <div class="modal fade" id="modalExcluir" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Excluir compra</h5>
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
                        
        <%@include file="scripts.html" %>
        <script>            
            $(document).ready(function(){      
                //Excluir compra
                $(".info-compra").find("button[class='btn-excluir']").click(function(){
                    var id = $(this).attr("value");
                    
                    $('#modal-mensagem').text("Deseja realmente excluir a compra " + id + "?");
                    $('#link-delete').attr("href", "ComprasController?acao=excluir_compra&id=" + id);
                });
                
                //Exibir mensagem
                if ($('#mensagem').text().trim() != "null") {
                    $('#container-alert').append("<%@include file="mensagem.jsp" %>");
                }
            });
        </script>
    </body>
</html>