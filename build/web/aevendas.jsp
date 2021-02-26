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
                    <h2>Área restrita - Vendas</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Buscar vendas..." >
                        <button class="btn " type="button">
                            <img src="assets/imagens/search.svg" alt="Lupa">
                        </button>
                    </div>
                </div>
            </div>

            <div class="container-table mb-4">
                <a href="formvenda.jsp">
                    <button class="btn btn-novo">Nova venda</button>
                </a>
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Nome cliente</th>
                            <th scope="col">Nome produto</th>
                            <th scope="col">Valor</th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="info-usuario">
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <a href="aevenda.jsp"><img src="assets/imagens/eye-fill.svg" alt="Exibir usuário"></a>
                            </td>
                            <td>
                                <a href="formvenda.jsp"><img src="assets/imagens/pencil-fill.svg" alt="Editar usuário"></a>
                            </td>
                            <td>
                                <button class="btn-excluir" name="" value=""><img src="assets/imagens/trash-fill.svg" alt="Excluir usuário" data-bs-toggle="modal" data-bs-target="#modalExcluir"></button>
                            </td>
                        </tr>
                        
                    </tbody>
                </table>
            </div>
            
        </div>

        <%@include file="scripts.html" %>
    </body>
</html>
