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

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
    
    private UsuariosDAO dao = new UsuariosDAO();
    private Usuarios usuario;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        //Identificador da acao no método POST
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha");

        if (cpf.isEmpty() || senha.isEmpty()) {

            //Enviando produtos/categorias para o index.jsp para evitar reload e perder mensagem de erro
            ProdutosDAO daoProdutos = new ProdutosDAO();
            ArrayList<Produtos> produtos = daoProdutos.getProdutos();
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
            ProdutosDAO daoProdutos = new ProdutosDAO();
            ArrayList<Produtos> produtos = daoProdutos.getProdutos();
            request.setAttribute("produtos", produtos);
            CategoriasDAO daoCategorias = new CategoriasDAO();
            ArrayList<Categorias> categorias = daoCategorias.getCategorias();
            request.setAttribute("categorias", categorias);
            
            request.setAttribute("mensagem", "Usuário/senha não encontrado");
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");        
            rd.forward(request, response);
                
        }
        
    }

}
