package controller;

import aplicacao.Produtos;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ProdutosDAO;

@WebServlet(name = "ProdutosController", urlPatterns = {"/ProdutosController"})
public class ProdutosController extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                //Impedir que a página seja armazena em cache, impedindo a função "voltar" do navegador
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setHeader("Expires", "0"); // Proxies.
        
        
        ProdutosDAO dao = new ProdutosDAO();
        ArrayList<Produtos> produtos = dao.getProdutos();
        request.setAttribute("produtos", produtos);
        
        System.out.println(produtos.size());
        
        
        if("pv".equals(request.getParameter("produtosVendedor"))){
            RequestDispatcher rd = request.getRequestDispatcher("/aeprodutos.jsp");
            rd.forward(request, response);
        }else{
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
        }
        
        
        
        
  
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
