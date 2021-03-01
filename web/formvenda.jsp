<%@page import="aplicacao.Produtos"%>
<%@page import="java.util.ArrayList"%>
<%@page import="aplicacao.Clientes"%>
<%@page import="aplicacao.Vendas"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
    Vendas venda = (Vendas)request.getAttribute("venda");
    ArrayList<Clientes> clientes = (ArrayList<Clientes>)request.getAttribute("clientes");
    
    Produtos produto = (Produtos)request.getAttribute("produto");
    
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
            
            <h2>Área restrita - Venda</h2>
            
            <form class="mt-4" id="form-cliente" method="POST" action="">
                <input type="hidden" name="idProduto" value="<%=produto.getId() %>" required="">
                    <div class="col-md mb-4">
                        <div class="col-md mb-4">
                            <label for="nomeProduto" class="form-label">Nome produto</label>
                            <input type="text" class="form-control" placeholder="Nome produto" aria-label="Nome produto" name="nomeProduto" value="<%=produto.getNomeProduto() %>" id="nomeProduto" required disabled>
                        </div>
                    </div>
                    <div class="col-md mb-4">
                        <label for="nomeCliente" class="form-label">Nome cliente</label>
                        <select class="form-select" aria-label="Nome cliente" name="Nome do cliente" id="nomeCliente" required="">
                            <option selected>Cliente</option>
                            <%
                                for (int i = 0; i < clientes.size(); i++) {
                                    Clientes cliente = clientes.get(i);
                            %>
                                    <option value="<%=cliente.getId() %>"><%=cliente.getNome() %> - <%=cliente.getCpf() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="quantidade" class="form-label">Quantidade</label>
                        <input type="number" class="form-control" placeholder="Quantidade" aria-label="Quantidade" name="quantidade" value="<%=venda.getQuantidadeVenda() %>" id="quantidade" min="1" max="<%=produto.getQuantidadeDisponivel() %>" required>
                    </div>
                    <div class="col-md mb-4">
                        <label for="desconto" class="form-label">Desconto (R$)</label>
                        <input type="number" class="form-control" placeholder="Desconto (R$)" aria-label="Desconto" name="desconto" value="0" min="0" max="" id="desconto" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="valorProduto" class="form-label">Valor unitário</label>
                        <input type="number" class="form-control" placeholder="Valor unitário" aria-label="Valor unitário" name="valorProduto" value="<%=produto.getPrecoVenda() %>" id="valorProduto" disabled="" required>
                    </div>
                    <div class="col-md mb-4">
                        <label for="valorTotal" class="form-label">Valor total</label>
                        <input type="number" class="form-control" placeholder="Valor total" aria-label="Valor total" name="valorTotal" value="" id="valorTotal" disabled="" required>
                    </div>
                </div>
                
                <input type="submit" class="btn btn-registrar" value="Registrar venda">
            </form>
            
        </div>
                    
        <%@include file="scripts.html" %>
        <script>            
            $(document).ready(function(){
                $('#quantidade').change(() => {
                    $('#desconto').val("0");
                    $('#valorTotal').val("");
                    
                    $('#valorTotal').val(($('#quantidade').val() * $('#valorProduto').val()) - $('#desconto').val());
                    $('#desconto').attr("max", $('#valorTotal').val() - ((<%= produto.getPrecoCompra() + (produto.getPrecoCompra() * 0.1)%>) * $('#quantidade').val()));
                });
                
                $('#desconto').change(() => {
                    $('#valorTotal').val(($('#quantidade').val() * $('#valorProduto').val()) - $('#desconto').val());
                });
            });
        </script>                    
    </body>
</html>
