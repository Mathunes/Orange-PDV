package controller;

import aplicacao.Categorias;
import aplicacao.Produtos;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoriasDAO;
import model.ProdutosDAO;

//Tratamento dos produtos para área restrita
@WebServlet(name = "ProdutosController", urlPatterns = {"/ProdutosController"})
public class ProdutosController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ProdutosDAO dao = new ProdutosDAO();
        ArrayList<Produtos> produtos = dao.getProdutos();
        request.setAttribute("produtos", produtos);
        
        CategoriasDAO daoCategorias = new CategoriasDAO();
        ArrayList<Categorias> categorias = daoCategorias.getCategorias();
        request.setAttribute("categorias", categorias);

        
        String acaoRestrito = (String)request.getParameter("acaoRestrito");
        
        switch(acaoRestrito){
            
            case "mostrar_produtos_restrito":
                RequestDispatcher rdRestrito = request.getRequestDispatcher("/produtos.jsp");
                rdRestrito.forward(request, response);
                break;

            case "pesquisar_produtos_restrito":
                String nomeProduto = request.getParameter("nomeProduto");
                produtos = dao.getNomeProduto(nomeProduto);
                request.setAttribute("produtos", produtos);
                RequestDispatcher mostrarNomeProduto = getServletContext().getRequestDispatcher("/produtos.jsp");
                mostrarNomeProduto.forward(request, response);
                break;
            }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
