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
                    ArrayList<Categorias> categorias = (ArrayList<Categorias>) request.getAttribute("categorias");
                    
                    if (produtos == null){
                        response.sendRedirect("ProdutosController?acaoRestrito=mostrar_produtos_restrito");
                    }else{
                        for(int j = 0; j < categorias.size(); j++){
                            Categorias auxC = categorias.get(j);
                            System.out.println(auxC.getNomeCategoria());
                %>
                            <fieldset class="row justify-content-evenly mb-5 border rounded border-light" style="font-family:Goudy Bookletter 1911, sans-serif">
                                <legend class="mt-3" style="color: #FF4F17"> <%=auxC.getNomeCategoria()%></legend>
                
                <%  
                                for (int i = 0; i < produtos.size(); i++) {                                              
                                    Produtos aux = produtos.get(i);
                                    if(aux.getLiberadoVenda().equals("S") && aux.getQuantidadeDisponivel() > 0 && aux.getIdCategoria() == auxC.getId()){
                                              

                %>
           
                                <div class = "card mx-1 my-5" style="background-color: #FFBC70; width: 20rem; font-family:Goudy Bookletter 1911, sans-serif" >
                                    <div class = "card-body">
                                        <h5 class = "card-title mb-4 text-center" style="color: #402609"><%=aux.getNomeProduto()%></h5>
                                        <p class = "card-text" style = "color: #402609"><%=aux.getDescricao()%></p>
                                        <div class="row" >
                                            <div class = "col-md-6">
                                                <h6 class = "card-subtitle mb-2" style = "color: #FF4F17; font-weight: bolder; font-size:18px">R$<%=aux.getPrecoVenda()%></h6>                    
                                            </div>
                                            <div class = "col-md-4 offset-md-10">
                                                <p class = "card-text" style = "color:#007EB3">Qt: <%=aux.getQuantidadeDisponivel()%></p>
                                            </div>
                                        </div>
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
        </div>

        <%@include file="scripts.html" %>
    </body>
</html>
