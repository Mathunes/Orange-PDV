
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
        
        
        String acaoRestrito = (String)request.getParameter("acaoRestrito");
        
        switch(acaoRestrito){
            
            case "mostrar_produtos_restrito":

                    RequestDispatcher rdRestrito = request.getRequestDispatcher("/aeprodutos.jsp");
                    rdRestrito.forward(request, response);
                    break;

                case "pesquisar_produtos_restrito":
                    String nomeProduto = request.getParameter("nomeProduto");
                    produtos = dao.getNomeProduto(nomeProduto);
                    request.setAttribute("produtos", produtos);
                    RequestDispatcher mostrarNomeProduto = getServletContext().getRequestDispatcher("/aeprodutos.jsp");
                    mostrarNomeProduto.forward(request, response);
                    break;
            }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
