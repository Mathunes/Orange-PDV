<%@page import="java.util.ArrayList"%>
<%@page import="aplicacao.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case "1":
            response.sendRedirect("vendas.jsp");
            break;
        case "2":
            response.sendRedirect("compras.jsp");
            break;
    }
%>

<!DOCTYPE html>
<!--Página de exibição dos usuarios-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbaradministrador.jsp" %>
        
        <div class="container">
            <!-- Mensagens  -->
            <div id="container-alert">
                <p hidden id="mensagem"><%= request.getAttribute("mensagem")%></p>
            </div>
            
            <div class="row header">
                <div class="col-sm">
                    <h2>Área restrita - Administrador</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="UsuariosController">
                        
                        <input type="hidden" name="acao" value="mostrar_usuario_nome" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name="nome" placeholder="Buscar usuário..." >
                            <button class="btn " type="submit">
                                <img src="assets/imagens/search.svg" alt="Lupa">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <div class="container-table mb-4">
                <a href="UsuariosController?acao=cadastrar_usuario">
                    <button class="btn btn-novo">Novo usuario</button>
                </a>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Nome</th>
                            <th scope="col">CPF</th>
                            <th scope="col">Tipo</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Usuarios> usuarios = (ArrayList<Usuarios>) request.getAttribute("usuarios");
                            //Se não houver usuarios, pedir para o servidor enviar
                            if (usuarios == null)
                                response.sendRedirect("UsuariosController?acao=mostrar_usuarios");
                            else
                                for (int i = 0; i < usuarios.size(); i++) {
                                    Usuarios aux = usuarios.get(i);                             
                                    String linkExibirUsuario = "UsuariosController?acao=mostrar_usuario&id="+aux.getId();
                                    String linkEditarUsuario = "UsuariosController?acao=editar_usuario&id="+aux.getId();
                                    
                        %>
                        
                        <tr class="info-usuario">
                            <td><%=aux.getNome()%></td>
                            <td><%=aux.getCpf()%></td>
                            <td><%
                                    switch(aux.getTipo()){
                                        case "0":
                                    %>
                                            Administrador
                                    <%
                                            break;
                                        case "1":
                                    %>
                                            Vendedor
                                    <%
                                            break;
                                        case "2":
                                    %>
                                            Comprador
                                    <%
                                            break;
                                    }
                                %>
                            </td>
                            <td>
                                <a href="<%=linkExibirUsuario%>"><img src="assets/imagens/eye-fill.svg" alt="Exibir usuario"></a>
                            </td>
                            <td>
                                <a href="<%=linkEditarUsuario%>"><img src="assets/imagens/pencil-fill.svg" alt="Editar usuario"></a>
                            </td>
                            <td>
                                <button class="btn-excluir" name="<%=aux.getNome()%>" value="<%=aux.getId()%>"><img src="assets/imagens/trash-fill.svg" alt="Excluir usuario" data-bs-toggle="modal" data-bs-target="#modalExcluir"></button>
                            </td>
                        </tr>
                        <%
                            }       
                        %>
                    </tbody>
                </table>
            </div>
            
        </div>
        <!--Modal para confirmar exclusão do usuario-->
        <div class="modal fade" id="modalExcluir" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Excluir usuario</h5>
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
                //Excluir usuario
                $(".info-usuario").find("button[class='btn-excluir']").click(function(){
                    var nome = $(this).attr("name");
                    var id = $(this).attr("value");
                    
                    $('#modal-mensagem').text("Deseja realmente excluir o(a) usuario " + nome + "?");
                    $('#link-delete').attr("href", "UsuariosController?acao=excluir_usuario&id=" + id);
                });
                
                //Exibir mensagem
                if ($('#mensagem').text().trim() != "null") {
                    $('#container-alert').append("<%@include file="mensagem.jsp" %>");
                }
            });
        </script>
    </body>
</html>
