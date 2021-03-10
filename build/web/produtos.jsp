<%@page import="aplicacao.Categorias"%>
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
    
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case '0':
            response.sendRedirect("administrador.jsp");
            break;
        case '2':
            response.sendRedirect("comprador.jsp");
            break;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarvendedor.jsp" %>
        
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
            <%
                ArrayList<Produtos> produtos = (ArrayList<Produtos>) request.getAttribute("produtos");
                ArrayList<Categorias> categorias = (ArrayList<Categorias>) request.getAttribute("categorias");

                if (produtos == null){
                    response.sendRedirect("ProdutosController?acaoRestrito=mostrar_produtos_restrito");
                }else{
                    for(int j = 0; j < categorias.size(); j++){
                        Categorias auxC = categorias.get(j);
            %>
                        <fieldset class="row justify-content-evenly mb-3 border rounded border-light" style="font-family:Goudy Bookletter 1911, sans-serif">
                            <legend class="mt-3" style="color: #FF4F17"> <%=auxC.getNomeCategoria()%></legend>

            <%  
                            for (int i = 0; i < produtos.size(); i++) {                                              
                                Produtos aux = produtos.get(i);
                                if(aux.getLiberadoVenda().equals("S") && aux.getQuantidadeDisponivel() > 0 && aux.getIdCategoria() == auxC.getId()){

            %>

                                    <div class = "card mx-1 my-3" style="background-color: #FFBC70; width: 20rem; font-family:Goudy Bookletter 1911, sans-serif" >
                                        <div class = "card-body">
                                            <h5 class = "card-title mb-4 text-center" style="color: #402609"><%=aux.getNomeProduto()%></h5>
                                            <p class = "card-text" style = "color: #402609"><%=aux.getDescricao()%></p>
                                            <div class="row mb-2">
                                                <div class = "col-6">
                                                    <p class = "card-text" style = "color: #FF4F17; font-weight: bolder; font-size:18px">R$<%=aux.getPrecoVenda()%></p>
                                                </div>
                                                <div class = "col-6">
                                                    <p class = "card-text text-end">Quantidade: <%=aux.getQuantidadeDisponivel()%></p>
                                                </div>
                                            </div>
                                            <a href="VendasController?acao=cadastrar_venda&produto=<%=aux.getId() %>">
                                                <button class="btn form-control" style="background-color: OrangeRed; color: Wheat">Vender</button>
                                            </a>  
                                        </div>
                                    </div>              

            <%
                        }
                    }
            %>
                        </fieldset>
            <%
                }
            }
            %>

        </div>

        <%@include file="scripts.html" %>
    </body>
</html>
