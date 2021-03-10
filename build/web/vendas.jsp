<%@page import="java.util.ArrayList"%>
<%@page import="aplicacao.Vendas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        
        <div class="container">
            <!-- Mensagens  -->
            <div id="container-alert">
                <p hidden id="mensagem"><%= request.getAttribute("mensagem")%></p>
            </div>
            
            <div class="row header">
                <div class="col-sm">
                    <h2>Área restrita - Vendas</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="VendasController">
                    
                        <input type="hidden" name="acao" value="mostrar_venda_busca" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="busca" placeholder="Buscar venda pelo nome do cliente..." >
                            <button class="btn " type="submit">
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
                            <th scope="col">Nome cliente</th>
                            <th scope="col">Nome produto</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Vendas> vendas = (ArrayList<Vendas>) request.getAttribute("vendas");
                            //Se não houver vendas, pedir para o servidor enviar
                            if (vendas == null)
                                response.sendRedirect("VendasController?acao=mostrar_vendas");
                            else
                                for (int i = 0; i < vendas.size(); i++) {
                                    Vendas venda = vendas.get(i);
                                    if (venda.getIdVendedor() == usuario.getId()) {
                                        String linkExibirVenda = "VendasController?acao=mostrar_venda&id="+venda.getId();
                                        String linkEditarVenda = "VendasController?acao=editar_venda&id="+venda.getId();
                            
                        %>                        
                        
                        <tr class="info-venda">
                            <td><%=venda.getId()%></td>
                            <td><%=venda.getNomeCliente()%></td>
                            <td><%=venda.getNomeProduto()%></td>
                            <td>
                                <a href="<%=linkExibirVenda%>"><img src="assets/imagens/eye-fill.svg" alt="Exibir venda"></a>
                            </td>
                            <td>
                                <a href="<%=linkEditarVenda%>"><img src="assets/imagens/pencil-fill.svg" alt="Editar venda"></a>
                            </td>
                            <td>
                                <button class="btn-excluir" name="<%=venda.getId()%>" value="<%=venda.getId()%>"><img src="assets/imagens/trash-fill.svg" alt="Excluir venda" data-bs-toggle="modal" data-bs-target="#modalExcluir"></button>
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
                    
        <div class="modal fade" id="modalExcluir" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Excluir venda</h5>
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
                //Excluir venda
                $(".info-venda").find("button[class='btn-excluir']").click(function(){
                    var id = $(this).attr("value");
                    
                    $('#modal-mensagem').text("Deseja realmente excluir a venda " + id + "?");
                    $('#link-delete').attr("href", "VendasController?acao=excluir_venda&id=" + id);
                });
                
                //Exibir mensagem
                if ($('#mensagem').text().trim() != "null") {
                    $('#container-alert').append("<%@include file="mensagem.jsp" %>");
                }
            });
        </script>
    </body>
</html>
