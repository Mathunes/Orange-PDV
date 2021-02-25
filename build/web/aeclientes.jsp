<%@page import="java.util.ArrayList"%>
<%@page import="aplicacao.Clientes"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
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
        <%@include file="aenavbar.jsp" %>
        
        <div class="container">
            <div class="row header">
                <div class="col-sm">
                    <h2>Área restrita - Clientes</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Buscar produto..." >
                        <button class="btn " type="button">
                            <img src="assets/imagens/search.svg" alt="Lupa">
                        </button>
                    </div>
                </div>
            </div>
            
            <div class="container-table">
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
                        <tr>
                            <td><%=aux.getNome()%></td>
                            <td><%=aux.getCpf()%></td>
                            <td>
                                <a href="<%=linkExibirCliente%>"><img src="assets/imagens/eye-fill.svg" alt="Exibir usuário"></a>
                            </td>
                            <td>
                                <a href="<%=linkEditarCliente%>"><img src="assets/imagens/pencil-fill.svg" alt="Editar usuário"></a>
                            </td>
                            <td>
                                <a href="#"><img src="assets/imagens/trash-fill.svg" alt="Excluir usuário"></a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            
        </div>

        <%@include file="scripts.html" %>
    </body>
</html>
