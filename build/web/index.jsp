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
        <%@include file="head.html" %>
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
            <%@include file="toastmensagem.jsp" %>
            
            <div class="row header">
                <div class="col-sm">
                    <h2>Produtos</h2>
                </div>
                <!-- Input de pesquisa -->
                <div class="col-sm">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Buscar produto..." >
                        <button class="btn " type="button">
                            <img src="assets/imagens/search.svg" alt="Lupa">
                        </button>
                    </div>
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
        
        <%@include file="scripts.html" %>
        <script src="js/mascaras.js"></script>
        
        <script>
            $( document ).ready(function() {
                if ($('#mensagem').text().trim() != "null") {
                    $('.toast').toast('show');
                }
            });
        </script>
    </body>
</html>
