<%@page import="java.util.ArrayList"%>
<%@page import="aplicacao.Fornecedores"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
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

<!DOCTYPE html>
<!--Página de exibição dos fornecedors-->
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
                    <h2>Área restrita - Fornecedores</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="FornecedoresController">
                        
                        <input type="hidden" name="acao" value="buscar_fornecedores" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="razao_social" placeholder="Buscar fornecedor..." >
                            <button class="btn" type="submit">
                                <img src="assets/imagens/search.svg" alt="Lupa">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="container-table mb-4">
                <a href="FornecedoresController?acao=cadastrar_fornecedor">
                    <button class="btn btn-novo">Novo fornecedor</button>
                </a>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Razao Social</th>
                            <th scope="col">CNPJ</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Fornecedores> fornecedors = (ArrayList<Fornecedores>) request.getAttribute("fornecedores");
                            //Se não houver fornecedors, pedir para o servidor enviar
                            if (fornecedors == null)
                                response.sendRedirect("FornecedoresController?acao=mostrar_fornecedors");
                            else
                                for (int i = 0; i < fornecedors.size(); i++) {
                                    Fornecedores aux = fornecedors.get(i);
                                    String linkExibirCliente = "FornecedoresController?acao=mostrar_fornecedor&id="+aux.getId();
                                    String linkEditarCliente = "FornecedoresController?acao=editar_fornecedor&id="+aux.getId();
                                    
                        %>
                        
                        <tr class="info-fornecedor">
                            <td><%=aux.getRazaoSocial()%></td>
                            <td><%=aux.getCnpj()%></td>
                            <td>
                                <a href="<%=linkExibirCliente%>"><img src="assets/imagens/eye-fill.svg" alt="Exibir fornecedor"></a>
                            </td>
                            <td>
                                <a href="<%=linkEditarCliente%>"><img src="assets/imagens/pencil-fill.svg" alt="Editar fornecedor"></a>
                            </td>
                            <td>
                                <button class="btn-excluir" name="<%=aux.getRazaoSocial()%>" value="<%=aux.getId()%>"><img src="assets/imagens/trash-fill.svg" alt="Excluir fornecedor" data-bs-toggle="modal" data-bs-target="#modalExcluir"></button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
        </div>
        <!--Modal para confirmar exclusão do fornecedor-->
        <div class="modal fade" id="modalExcluir" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Excluir fornecedor</h5>
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
                //Excluir fornecedor
                $(".info-fornecedor").find("button[class='btn-excluir']").click(function(){
                    var razao_social = $(this).attr("razao_social");
                    var id = $(this).attr("value");
                    
                    $('#modal-mensagem').text("Deseja realmente excluir o(a) fornecedor " + razao_social + "?");
                    $('#link-delete').attr("href", "FornecedoresController?acao=excluir_fornecedor&id=" + id);
                });
                
                //Exibir mensagem
                if ($('#mensagem').text().trim() != "null") {
                    $('#container-alert').append("<%@include file="mensagem.jsp" %>");
                }
            });
        </script>
    </body>
</html>
