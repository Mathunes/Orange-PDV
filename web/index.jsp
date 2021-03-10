<%@page import = "java.util.Arrays"%>
<%@page import = "java.util.ArrayList"%>
<%@page import = "aplicacao.Produtos"%>
<%@page import = "aplicacao.Categorias"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.

%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="head.html"%>
    </head>
    <body>
        <!-- Barra de navegação - Cliente -->
        <nav class="navbar mb-4">
            <div class="container">
                <a class="navbar-brand">
                    <img src="assets/imagens/logo.png" alt="Logo OrangePDV" width="92" class="d-inline-block align-top">
                </a>
                <button class="btn btn-restrito" data-bs-toggle="modal" data-bs-target="#modalLogin">Restrito</button>
            </div>
        </nav>
        
        <div class="container">
            <!-- Mensagens  -->
            <div id="container-alert">
                <p hidden id="mensagem"><%= request.getAttribute("mensagem")%></p>
            </div>
            
            <div class="row header">
                <div class="col-sm">
                    <h2>Produtos</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <form method = "GET" action = "ProdutosControllerClientes"> 
                        <input type = "hidden" name = "acao" value = "pesquisar_produtos" required>
                        <div class="input-group mb-3">
                            <input type="text" class="form-control" name = "nomeProduto" placeholder="Buscar produto..." >
                            <button class="btn" type="submit">
                                <img src="assets/imagens/search.svg" alt="Lupa">
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        
            <!-- Exibir produtos -->
            
        </div>
        
        <!-- Modal Login -->
        
        <div class="modal fade" tabindex="-1" id="modalLogin">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content p-4">
                    <div class="modal-header">
                        <h5 class="modal-title">Login</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Formulário Login -->
                        <form action="UsuariosController" method="POST">
                            <input type="hidden" name="acao" value="login" required>
                            <div class="mb-4">
                                <input type="text" class="form-control cpf" name="cpf" placeholder="CPF" required>
                            </div>
                            <div class="mb-4">
                                <input type="password" class="form-control" name="senha" placeholder="Senha" required>
                            </div>
                            <div class="mb-4">
                                <input type="submit" class="form-control btn btn-entrar" id="exampleFormControlInput1" value="Entrar">
                            </div>
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
        
        <div class = "container">
            <%
                ArrayList<Produtos> produtos = (ArrayList<Produtos>) request.getAttribute("produtos");
                ArrayList<Categorias> categorias = (ArrayList<Categorias>) request.getAttribute("categorias");

                if (produtos == null){
                    response.sendRedirect("ProdutosControllerClientes?acao=mostrar_produtos");
//                    RequestDispatcher rd = request.getRequestDispatcher("/ProdutosControllerClientes?acao=mostrar_produtos");
//                    rd.forward(request, response);
                    
                } else {
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
                                    <div class="row">
                                        <div class = "col-6">
                                            <p class = "card-text" style = "color: #FF4F17; font-weight: bolder; font-size:18px">R$<%=aux.getPrecoVenda()%></p>
                                        </div>
                                        <div class = "col-6">
                                            <p class = "card-text text-end">Quantidade: <%=aux.getQuantidadeDisponivel()%></p>
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
        <%@include file="scripts.html" %>
        <script src="js/mascaras.js"></script>
        
        <script>
            
            $( document ).ready(function() {
                if ($('#mensagem').text().trim() != "null") {
                    $('.toast').toast('show');
                } else {
                    $('.toast').toast('hide');
                }
                
                //Exibir mensagem
                if ($('#mensagem').text().trim() != "null") {
                    $('#container-alert').append("<%@include file="mensagem.jsp" %>");
                }
            });
        </script>

        

    </body>
</html>
