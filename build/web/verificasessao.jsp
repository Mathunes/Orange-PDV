<%@page import="aplicacao.Usuarios"%>
<%
    Object logado = session.getAttribute("logado");
    Usuarios usuario = null;
    
    if (logado != null) {
        
        if (((String)logado).equals("ok")) {
    
            usuario = (Usuarios)session.getAttribute("usuario");
            
        } else {
            response.sendRedirect("index.jsp");
        }
        
    } else {
        response.sendRedirect("index.jsp");
    }
    
%>