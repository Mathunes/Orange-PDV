package controller;

import aplicacao.Categorias;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CategoriasDAO;

@WebServlet(name = "CategoriasController", urlPatterns = {"/CategoriasController"})
public class CategoriasController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        
        
        String acao = (String)request.getParameter("acao");
        
        switch(acao){
            case "mostrar_categorias":
                RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
                rd.forward(request, response);     
        }
        
        String acaoRestrito = (String)request.getParameter("acaoRestrito");
        
        switch(acaoRestrito){
                case "mostrar_categorias_restrito":
                RequestDispatcher rdRestrito = request.getRequestDispatcher("/produtos.jsp");
                rdRestrito.forward(request, response);
                break;
                
            }
        
        
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
