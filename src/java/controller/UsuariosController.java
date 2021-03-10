package controller;

import aplicacao.Categorias;
import aplicacao.Produtos;
import aplicacao.Usuarios;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CategoriasDAO;
import model.ProdutosDAO;
import model.UsuariosDAO;

@WebServlet(name = "UsuariosController", urlPatterns = {"/UsuariosController"})
public class UsuariosController extends HttpServlet {
    
    private UsuariosDAO dao = new UsuariosDAO();
    private Usuarios usuario;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        //Identificador da acao no método POST
        String acao = request.getParameter("acao");
        String cpf = "";
        String senha = "";
        
        switch (acao) {
            case "login":
                cpf = request.getParameter("cpf");
                senha = request.getParameter("senha");
                
                //Verificando se há campos vazios
                if (cpf.isEmpty() || senha.isEmpty()) {

                    //Enviando produtos/categorias para o index.jsp para evitar reload e perder mensagem de erro
                    ProdutosDAO dao = new ProdutosDAO();
                    ArrayList<Produtos> produtos = dao.getProdutos();
                    request.setAttribute("produtos", produtos);
                    CategoriasDAO daoCategorias = new CategoriasDAO();
                    ArrayList<Categorias> categorias = daoCategorias.getCategorias();
                    request.setAttribute("categorias", categorias);
            
                    request.setAttribute("mensagem", "Preencha todos os campos para efetuar o login");
                    RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
                    rd.forward(request, response);

                } else {
                    usuario = new Usuarios(cpf, senha);
                    login(request, response);
                }
                break;
                
            case "logout":
                logout(request, response);
                break;
        }
            
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
  
        usuario = dao.Login(usuario);
        
        if (usuario.getId() > 0) {
            
            HttpSession session = request.getSession();
            session.setAttribute("logado", "ok");
            session.setAttribute("usuario", usuario);

            response.sendRedirect("ProdutosController?acaoRestrito=mostrar_produtos_restrito");
            
        } else {
            //Enviando produtos/categorias para o index.jsp para evitar reload e perder mensagem de erro
            ProdutosDAO dao = new ProdutosDAO();
            ArrayList<Produtos> produtos = dao.getProdutos();
            request.setAttribute("produtos", produtos);
            CategoriasDAO daoCategorias = new CategoriasDAO();
            ArrayList<Categorias> categorias = daoCategorias.getCategorias();
            request.setAttribute("categorias", categorias);
            
            request.setAttribute("mensagem", "Usuário não encontrado");
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");        
            rd.forward(request, response);
                
        }
        
    }

    private void logout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("index.jsp");
    }

}