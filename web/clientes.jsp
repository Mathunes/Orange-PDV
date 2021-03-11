<%@page import="java.util.ArrayList"%>
<%@page import="aplicacao.Clientes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case '0':
            response.sendRedirect("administrador.jsp");
            break;
        case '2':
            response.sendRedirect("comprador.jsp");
            break;
    }
%>

<!DOCTYPE html>
<!--Página de exibição dos clientes-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarvendedor.jsp" %>
        
        <div class="container">
            <!-- Mensagens  -->
            <div id="container-alert">
                <p hidden id="mensagem"><%= request.getAttribute("mensagem")%></p>
            </div>
            
            <div class="row header">
                <div class="col-sm">
                    <h2>Área restrita - Clientes</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="ClientesController">
                        
                        <input type="hidden" name="acao" value="mostrar_clientes_nome" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="nome" placeholder="Buscar cliente..." >
                            <button class="btn " type="submit">
                                <img src="assets/imagens/search.svg" alt="Lupa">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="container-table mb-4">
                <a href="ClientesController?acao=cadastrar_cliente">
                    <button class="btn btn-novo">Novo cliente</button>
                </a>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Nome</th>
                            <th scope="col">CPF</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Clientes> clientes = (ArrayList<Clientes>) request.getAttribute("clientes");
                            //Se não houver clientes, pedir para o servidor enviar
                            if (clientes == null)
                                response.sendRedirect("ClientesController?acao=mostrar_clientes");
                            else
                                for (int i = 0; i < clientes.size(); i++) {
                                    Clientes aux = clientes.get(i);
                                    String linkExibirCliente = "ClientesController?acao=mostrar_cliente&id="+aux.getId();
                                    String linkEditarCliente = "ClientesController?acao=editar_cliente&id="+aux.getId();
                                    
                        %>
                        
                        <tr class="info-cliente">
                            <td><%=aux.getNome()%></td>
                            <td><%=aux.getCpf()%></td>
                            <td>
                                <a href="<%=linkExibirCliente%>"><img src="assets/imagens/eye-fill.svg" alt="Exibir cliente"></a>
                            </td>
                            <td>
                                <a href="<%=linkEditarCliente%>"><img src="assets/imagens/pencil-fill.svg" alt="Editar cliente"></a>
                            </td>
                            <td>
                                <button class="btn-excluir" name="<%=aux.getNome()%>" value="<%=aux.getId()%>"><img src="assets/imagens/trash-fill.svg" alt="Excluir cliente" data-bs-toggle="modal" data-bs-target="#modalExcluir"></button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
        </div>
        <!--Modal para confirmar exclusão do cliente-->
        <div class="modal fade" id="modalExcluir" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Excluir cliente</h5>
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
                //Excluir cliente
                $(".info-cliente").find("button[class='btn-excluir']").click(function(){
                    var nome = $(this).attr("name");
                    var id = $(this).attr("value");
                    
                    $('#modal-mensagem').text("Deseja realmente excluir o(a) cliente " + nome + "?");
                    $('#link-delete').attr("href", "ClientesController?acao=excluir_cliente&id=" + id);
                });
                
                //Exibir mensagem
                if ($('#mensagem').text().trim() != "null") {
                    $('#container-alert').append("<%@include file="mensagem.jsp" %>");
                }
            });
        </script>
    </body>
</html>
