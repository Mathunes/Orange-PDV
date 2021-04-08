<%@page import="aplicacao.Categorias"%>
<%@page import="aplicacao.Produtos"%>
<%@page import="java.util.ArrayList"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    
    ArrayList<Categorias> categorias = (ArrayList<Categorias>)request.getAttribute("categorias");
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
<!--Página cadastro do produto-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarcomprador.jsp" %>
        
        <div class="container">
            
            <h2>Área restrita - Produto</h2>
            
            <form class="mt-4" id="form-produto" method="POST" action="ProdutosController">
                <input type="hidden" name="id" value="<%=produto.getId() %>" required="">
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="nomeProduto" class="form-label">Nome produto</label>
                        <input type="text" class="form-control" placeholder="Nome produto" aria-label="Nome produto" name="nomeProduto" value="<%=produto.getNomeProduto() %>" id="nomeProduto" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="descricao" class="form-label">Descrição</label>
                        <textarea class="form-control" placeholder="Descrição" name="descricao" id="descricao" required><%=produto.getDescricao() %></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="precoCompra" class="form-label">Preço compra</label>
                        <input type="number" class="form-control" placeholder="Preço compra" aria-label="Preço compra" name="precoCompra" value="<%=produto.getPrecoCompra() %>" id="precoCompra" min="0" step="0.01" required>
                    </div>
                    <div class="col-md mb-4">
                        <label for="precoVenda" class="form-label">Preço venda</label>
                        <input type="number" class="form-control" placeholder="Preço venda" aria-label="Preço venda" name="precoVenda" value="<%=produto.getPrecoVenda() %>" id="precoVenda" min="0" step="0.01" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <label for="quantidadeDisponivel" class="form-label">Quantidade disponível</label>
                        <input type="number" class="form-control" placeholder="Quantidade disponível" aria-label="Quantidade disponível" name="quantidadeDisponivel" value="<%=produto.getQuantidadeDisponivel()%>" id="quantidadeDisponivel" min="0" required>
                    </div>
                    <div class="col-md mb-4">
                        <label for="liberadoVenda" class="form-label">Liberado para venda</label>
                        <select class="form-select" aria-label="Liberado para venda" name="liberadoVenda" id="liberadoVenda" required="">
                            <option value="N">Não</option>
                            <option value="S">Sim</option>
                        </select>
                    </div>
                </div>
                <div class="col-md mb-4">
                    <label for="idCategoria" class="form-label">Categoria do produto</label>
                    <select class="form-select" aria-label="Categoria do produto" name="idCategoria" id="idCategoria" required="">
                        <%
                            Boolean atualizacao = false;
                            for (int i = 0; i < categorias.size(); i++) {
                                Categorias categoria = categorias.get(i);
                                //Se for atualização, exibir opção da categoria
                                if (produto.getIdCategoria()== categoria.getId()) {
                                    atualizacao = true;
                        %>
                                    <option value="<%=categoria.getId() %>" selected><%=categoria.getNomeCategoria() %></option>
                        <%
                                } else {
                        %>
                                    <option value="<%=categoria.getId() %>"><%=categoria.getNomeCategoria() %></option>
                        <% 
                                }
                            }
                        %>
                    </select>
                </div>                
                <input type="submit" class="btn btn-registrar mb-4" value="Registrar produto">
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