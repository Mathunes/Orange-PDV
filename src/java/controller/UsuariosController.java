package controller;

import aplicacao.Usuarios;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UsuariosController", urlPatterns = {"/UsuariosController"})
public class UsuariosController extends HttpServlet {
    
    private UsuariosDao dao = new UsuariosDao();
    private Usuarios usuario;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String acao = request.getParameter("acao");
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha");
        
        if (acao.isEmpty() || cpf.isEmpty() || senha.isEmpty()) {
        
            request.setAttribute("mensagem", "Preencha todos os campos para efetuar o login");
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
            
        } else {
            
            switch (acao) {
                case "login":
                    usuario = new Usuarios(cpf, senha);
                    login(request, response);
                    break;
            }
        }
        
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        usuario = dao.Login(usuario);
        
        if (usuario.getId() > 0) {
            //Sucesso
            
        } else {
            
            request.setAttribute("mensagem", "Usuário não encontrado");
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
            
        }
                
    }

}