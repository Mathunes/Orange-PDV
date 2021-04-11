<%@page import="aplicacao.Produtos"%>
<%@page import="java.util.ArrayList"%>
<%@page import="aplicacao.Fornecedores"%>
<%@page import="aplicacao.Compras"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
    Compras compra = (Compras)request.getAttribute("compra");
    ArrayList<Fornecedores> fornecedores = (ArrayList<Fornecedores>)request.getAttribute("fornecedores");
    ArrayList<Produtos> produtos = (ArrayList<Produtos>)request.getAttribute("produtos");
    Produtos produto = (Produtos)request.getAttribute("produto");
    
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case '0':
            response.sendRedirect("administrador.jsp");
            break;
        case '1':
            response.sendRedirect("produtos.jsp");
            break;
    }
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--Página cadastro da compra-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarcomprador.jsp" %>
        
        <div class="container">
            
            <h2>Área restrita - Compra</h2>
            <a href="ComprasController?acao=mostrar_compras">
                    <button class="btn btn-voltar">Voltar</button>
            </a>
            <form class="mt-4" id="form-compra" method="POST" action="ComprasController">
                <input type="hidden" name="id" value="<%=compra.getId() %>" required="">
                <input type="hidden" name="idComprador" value="<%=usuario.getId() %>" required="">
                <input type="hidden" name="dataCompra" id="dataCompra" value="" required="">
                <div class="col-md mb-4">
                    <div class="col-md mb-4">
                        <label for="idProduto" class="form-label">Nome produto</label>
                        <select class="form-select" aria-label="Id produto" name="idProduto" id="idProduto" required="">
                            <%
                            for (int i = 0; i < produtos.size(); i++) {
                                Produtos produtoAux = produtos.get(i);
                                //Se for atualização, exibir opção do produto
                                if (compra.getIdProduto()== produtoAux.getId()) {
                            %>
                                        <option value="<%=produtoAux.getId() %>" selected><%=produtoAux.getNomeProduto()%></option>
                            <%
                                    } else {
                            %>
                                        <option value="<%=produtoAux.getId() %>"><%=produtoAux.getNomeProduto()%></option>
                            <% 
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>
                <div class="col-md mb-4">
                    <label for="nomeFornecedor" class="form-label">Razão social do fornecedor</label>
                    <select class="form-select" aria-label="Nome fornecedor" name="idFornecedor" id="nomeFornecedor" required="">
                        <%
                            for (int i = 0; i < fornecedores.size(); i++) {
                                Fornecedores fornecedor = fornecedores.get(i);
                                //Se for atualização, exibir opção do fornecedor
                                if (compra.getIdFornecedor()== fornecedor.getId()) {
                        %>
                                    <option value="<%=fornecedor.getId() %>" selected><%=fornecedor.getRazaoSocial() %> - <%=fornecedor.getCnpj() %></option>
                        <%
                                } else {
                        %>
                                    <option value="<%=fornecedor.getId() %>"><%=fornecedor.getRazaoSocial()%> - <%=fornecedor.getCnpj() %></option>
                        <% 
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="quantidade" class="form-label">Quantidade</label>
                        <input type="number" class="form-control" placeholder="Quantidade" aria-label="Quantidade" name="quantidade" value="<%=compra.getQuantidadeCompra() %>" id="quantidade" min="1" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="valorProduto" class="form-label">Valor unitário</label>
                        <input type="number" class="form-control" placeholder="Valor unitário" aria-label="Valor unitário" name="valorProduto" value="" id="valorProduto" min="0" step="0.01" required>
                    </div>
                    <div class="col-md mb-4">
                        <label for="valorTotal" class="form-label">Valor total</label>
                        <input type="number" class="form-control" placeholder="Valor total" aria-label="Valor total" name="valorTotal" value="<%=compra.getValorCompra() %>" id="valorTotal" required readonly>
                    </div>
                </div>
                
                <input type="submit" class="btn btn-registrar" value="Registrar compra">
            </form>
            
        </div>
                    
        <%@include file="scripts.html" %>
        <script>            
            function atualizaTotal() {
                //Limpando
                $('#valorTotal').val("");

                $('#valorTotal').val($('#quantidade').val() * $('#valorProduto').val());
                $('#valorTotal').attr("value", ($('#quantidade').val() * $('#valorProduto').val()));
            }
            
            $(document).ready(function(){
                
                $('#dataCompra').val(new Date().toISOString().slice(0, 10));
                
                $('#valorProduto').val(($('#valorTotal').val() / $('#quantidade').val()).toFixed(2));
                
                $('#quantidade').change(() => {
                    atualizaTotal();
                });
                
                $('#valorProduto').change(() => {
                    atualizaTotal();
                });
                
            });
        </script>                    
    </body>
</html>
