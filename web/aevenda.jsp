<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="aenavbar.jsp" %>
        <div class="container">
            <h2>Área restrita - Visualizar venda</h2>
            
            <div class="container-info">
                <a href="aevendas.jsp">
                    <button class="btn btn-voltar">Voltar</button>
                </a>
                    <table class="table mt-2">
                        <tbody>
                            <tr>
                                <td><b>Id</b></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><b>Quantidade venda</b></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><b>Data venda</b></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><b>Valor venda</b></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><b>ID cliente</b></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><b>Nome cliente</b></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><b>ID produto</b></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><b>Nome produto</b></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><b>ID vendedor</b></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><b>Nome vendedor</b></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
            </div>
            
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>
