<%@page import="aplicacao.Usuarios"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedindo a função "voltar" do navegador
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Usuarios usuarioChamado = (Usuarios)request.getAttribute("usuario");
    //Verificação do tipo de usuário logado
    switch (usuario.getTipo()) {
        case "1":
            response.sendRedirect("vendas.jsp");
            break;
        case "2":
            response.sendRedirect("compras.jsp");
            break;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--Página cadastro do usuario-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbaradministrador.jsp" %>
        
        <div class="container">
            <!--Toast para ser exibido caso o CPF informado seja inválido-->
            <div aria-live="polite" aria-atomic="true" class="d-flex justify-content-center w-100 position-absolute top-0 end-0 mt-2">
                <div class="toast-container">
                    <div class="toast text-white bg-warning" role="alert" aria-live="assertive" aria-atomic="true">
                        <div class="d-flex">
                            <div class="toast-body">
                                <span id="mensagem">
                                    Informe um CPF válido
                                </span>
                            </div>
                            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                    </div>
                </div>
            </div>
                                
            <h2>Área restrita - Usuarios</h2>
            <a href="UsuariosController?acao=mostrar_usuarios">
                <button class="btn btn-voltar">Voltar</button>
            </a>
            <form class="mt-4" id="form-usuario" method="POST" action="UsuariosController?acao=cadastrar_usuario">
                <input type="hidden" name="id" value="<%=usuarioChamado.getId()%>" required="">
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Nome do usuario" aria-label="Nome do usuario" name="nome" maxlength="50" value="<%=usuarioChamado.getNome()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control cpf" placeholder="CPF do usuario" aria-label="CPF do usuario" name="cpf" maxlength="14" value="<%=usuarioChamado.getCpf()%>" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Senha do usuario" aria-label="Senha do usuario" name="senha" maxlength="50" value="<%=usuarioChamado.getSenha()%>" required>
                    </div>
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Tipo do usuario" aria-label="Tipo do usuario" name="tipo" maxlength="50" value="<%=usuarioChamado.getTipo()%>" required>
                    </div>
                </div>               
                <input type="submit" class="btn btn-registrar" value="Registrar usuario">
            </form>
        </div>
        
        <%@include file="scripts.html" %>
        <script src="js/mascaras.js"></script>
        <script src="js/valida-cpf.js"></script>
        <script>
            $( document ).ready(function() {
                //Ouvindo evento de envio do formulário
                $('#form-usuario').submit(() => {
                    //Interrompendo o envio
                    event.preventDefault();
                    //Verificando se o CPF é válido
                    if (validaCPF($('.cpf').val())) {
                        //Enviando o formulário
                        $('#form-usuario').unbind('submit').submit();
                    } else {
                        //Exibindo a mensagem de erro
                        $('.toast').toast('show');
                    }
                       
                });                
            });
        </script>
    </body>
</html>
