<%@page import="aplicacao.Utilitario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="aplicacao.Vendas"%>
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
            response.sendRedirect("produtos.jsp");
            break;
        case "2":
            response.sendRedirect("produtoscomprador.jsp");
            break;
    }
%>

<!DOCTYPE html>
<!--Página de exibição do relatório de vendas-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbaradministrador.jsp" %>
        
        <div class="container pb-5">
            <!-- Mensagens  -->
            <div id="container-alert">
                <p hidden id="mensagem"><%= request.getAttribute("mensagem")%></p>
            </div>
            
            <div class="row header">
                <div class="col-sm">
                    <h2>Área restrita - Relatório vendas</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method="GET" action="VendasController" id="form-data-venda">
                        
                        <input type="hidden" name="acao" value="mostrar_venda_data" required>
                        <select class="form-select mb-3" id="select-data-venda" aria-label="Data venda" name="dataVenda" required="">
                            
                            <option value="Escolher data" selected>Escolher data</option>
                        <%
                            String dataEscolhida = (String) request.getAttribute("data");
                            
                            if (dataEscolhida == null) dataEscolhida = "Escolher data";
                            
                            ArrayList<String> datas = (ArrayList<String>) request.getAttribute("datas");
                            //Se não houver vendas, pedir para o servidor enviar
                            if (datas == null)
                                response.sendRedirect("VendasController?acao=mostrar_vendas_adm");
                            else
                                for (int i = 0; i < datas.size(); i++) {
                                    String data = datas.get(i);
                                    if (data.equals(dataEscolhida)) {
                        %>
                            <option value="<%=data%>" selected><%=Utilitario.formataData(data)%></option>
                        <%
                                    } else {
                        %>
                            <option value="<%=data%>"><%=Utilitario.formataData(data)%></option>
                        <%
                                    }
                                }
                        %>
                        </select>
                    </form>
                </div>
            </div>

            <div class="container-table mb-4">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Nome produto</th>
                            <th scope="col">Valor da venda</th>
                            <th scope="col"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            ArrayList<Vendas> vendas = (ArrayList<Vendas>) request.getAttribute("vendas");
                            //Se não houver vendas, pedir para o servidor enviar
                            if (vendas == null)
                                response.sendRedirect("VendasController?acao=mostrar_vendas_adm");
                            else
                                for (int j = 0; j < vendas.size(); j++) {
                                    Vendas venda = vendas.get(j);
                                    String linkExibirVenda = "VendasController?acao=mostrar_venda_adm&id="+venda.getId();
                            
                        %>                        
                        
                        <tr class="info-venda">
                            <td><%=venda.getId()%></td>
                            <td><%=venda.getNomeProduto()%></td>
                            <td class="total-venda">R$ <%=Double.toString(venda.getValorVenda()).replace(".", ",")%></td>
                            
                            <td>
                                <a href="<%=linkExibirVenda%>"><img src="assets/imagens/eye-fill.svg" alt="Exibir venda"></a>
                            </td>
                        </tr>
                        <%
                                }
                        %>
                    </tbody>
                </table>
            </div>
            
        </div>
                    
        <nav class="navbar fixed-bottom navbar-light bg-light">
            <div class="container d-flex flex-row-reverse">
                <span class="navbar-brand" id="total-vendas">Total: </span>
            </div>
        </nav>
                    
        <!--Modal para confirmar exclusão da venda-->
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
            
            function exibirTotal() {
                var total = 0;
                
                for (var i = 0; i < $('td.total-venda').length; i++) {
                    total += parseFloat($('td.total-venda')[i]
                            .innerHTML.replace("R$ ", "")
                            .replace(",", "."));
                }
                $("#total-vendas").html("Total: R$ " + String(total.toFixed(2)).replace(".", ","));
            }
            
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
                
                $("#select-data-venda").change(() => {
                    //console.log($("#select-data-venda option:selected").text());
                    $('#form-data-venda').submit();
                });
                
                //Exibindo total venda
                exibirTotal();
                
            });
        </script>
    </body>
</html>
