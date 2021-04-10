<%@page import="aplicacao.Categorias"%>
<%@include file="infousuario.jsp" %>
<% 
    //Impedir que a página seja armazenada em cache, impedinda a função "voltar" da navegadar
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
    Categorias categoria = (Categorias)request.getAttribute("categoria");
    
    //Verificação da tipo de usuário logada
    switch (usuario.getTipo()) {
        case '0':
            response.sendRedirect("administradar.jsp");
            break;
        case '1':
            response.sendRedirect("vendas.jsp");
            break;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--Página cadastro da categoria-->
<html>
    <head>
        <%@include file="head.html" %>
    </head>
    <body>
        <%@include file="navbarcomprador.jsp" %>
        
                              
            
        <div class="container">
            <h2>Área restrita - Categorias</h2>
            <form class="mt-4" id="form-categoria" method="POST" action="CategoriasController">
                <input class= "form-control" type="hidden" name="id" value="<%=categoria.getId()%>" required="">
                    <div class="col-md mb-4">
                        <input type="text" class="form-control" placeholder="Nome da categoria" aria-label="Nome da categoria" name="nome_categoria" maxlength="50" value="<%=categoria.getNomeCategoria()%>" required>
                    </div>                    
                <input type="submit" class="btn btn-registrar" value="Registrar categoria">
            </form>
        </div>
        
        <%@include file="scripts.html" %>
    </body>
</html>
