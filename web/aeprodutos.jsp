<%@page import="java.util.Arrays"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "aplicacao.Produtos"%>
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
                    <h2>Área restrita - Produtos</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method = "GET" action = "ProdutosController"> 
                        <input type = "hidden" name = "acaoRestrito" value = "pesquisar_produtos_restrito" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name = "nomeProduto" placeholder="Buscar produto..." >
                            <button class="btn" type="submit">
                                <img src="assets/imagens/search.svg" alt="Lupa">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <div class = "container">
            <div class = "row d-flex justify-content-between" >
                <%
                    ArrayList<Produtos> produtos = (ArrayList<Produtos>) request.getAttribute("produtos");
                    
                    if (produtos == null){
                        response.sendRedirect("ProdutosController?acaoRestrito=mostrar_produtos_restrito");
                    }else{
                        for (int i = 0; i < produtos.size(); i++) {
                            Produtos aux = produtos.get(i);
                            if(aux.getLiberadoVenda().equals("S") && aux.getQuantidadeDisponivel() > 0){                               
                %>
           
                <div class = "card mx-1 my-5" style="background-color: Wheat; width: 20rem; font-family: inherit" >
                    <div class = "card-body" id = "cardsProd" >
                        <h5 class = "card-title mb-4" style="color: black"><%=aux.getNomeProduto()%></h5>
                        <h6 class = "card-subtitle mb-2" style = "color: OrangeRed">R$<%=aux.getPrecoCompra()%></h6>
                        <p class = "card-text" style = "color: black"><%=aux.getDescricao()%></p>
                        <p class = "card-text" style = "color: black; float:right">Quantidade: <%=aux.getQuantidadeDisponivel()%></p>
                        <a href="VendasController?acao=cadastrar_venda&produto=<%=aux.getId() %>">
                            <button class="btn" style="background-color: OrangeRed; color: Wheat">Vender</button>
                        </a>                     
                    </div>
                </div>
        
         
                <%
                        }
                    }
                }
                %>
            </div>
        </div>

        <%@include file="scripts.html" %>
    </body>
</html>
