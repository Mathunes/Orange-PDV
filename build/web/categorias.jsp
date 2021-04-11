<%@page import="java.util.ArrayList"%>
<%@page import="aplicacao.Categorias"%>
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
        case '1':
            response.sendRedirect("vendas.jsp");
            break;
    }
%>

<!DOCTYPE html>
<!--Página de exibição dos categorias-->
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
                    <h2>Área restrita - Categorias</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="CategoriasController">
                        
                        <input type="hidden" name="acao" value="buscar_categorias" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="nome_categoria" placeholder="Buscar categoria..." >
                            <button class="btn " type="submit">
                                <img src="assets/imagens/search.svg" alt="Lupa">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="container-table mb-4">
                <a href="CategoriasController?acao=cadastrar_categoria">
                    <button class="btn btn-novo">Nova categoria</button>
                </a>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Nome</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Categorias> categorias = (ArrayList<Categorias>) request.getAttribute("categorias");
                            //Se não houver categorias, pedir para o servidor enviar
                            if (categorias == null)
                                response.sendRedirect("CategoriasController?acao=mostrar_categorias");
                            else
                                for (int i = 0; i < categorias.size(); i++) {
                                    Categorias aux = categorias.get(i);
                                    String linkExibirCategoria = "CategoriasController?acao=mostrar_categoria&id="+aux.getId();
                                    String linkEditarCategoria = "CategoriasController?acao=editar_categoria&id="+aux.getId();
                                    
                        %>
                        
                        <tr class="info-categoria">
                            <td><%=aux.getId()%></td>
                            <td><%=aux.getNomeCategoria()%></td>
                            <td>
                                <a href="<%=linkExibirCategoria%>"><img src="assets/imagens/eye-fill.svg" alt="Exibir categoria"></a>
                            </td>
                            <td>
                                <a href="<%=linkEditarCategoria%>"><img src="assets/imagens/pencil-fill.svg" alt="Editar categoria"></a>
                            </td>
                            <td>
                                <button class="btn-excluir" name="<%=aux.getNomeCategoria()%>" value="<%=aux.getId()%>"><img src="assets/imagens/trash-fill.svg" alt="Excluir categoria" data-bs-toggle="modal" data-bs-target="#modalExcluir"></button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
        </div>
        <!--Modal para confirmar exclusão do categoria-->
        <div class="modal fade" id="modalExcluir" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Excluir categoria</h5>
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
                //Excluir categoria
                $(".info-categoria").find("button[class='btn-excluir']").click(function(){
                    var nome = $(this).attr("name");
                    var id = $(this).attr("value");
                    
                    $('#modal-mensagem').text("Deseja realmente excluir o(a) categoria " + nome + "?");
                    $('#link-delete').attr("href", "CategoriasController?acao=excluir_categoria&id=" + id);
                });
                
                //Exibir mensagem
                if ($('#mensagem').text().trim() != "null") {
                    $('#container-alert').append("<%@include file="mensagem.jsp" %>");
                }
            });
        </script>
    </body>
</html>

