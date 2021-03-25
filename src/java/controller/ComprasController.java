package controller;

import aplicacao.Compras;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ComprasDAO;

@WebServlet(name = "ComprasController", urlPatterns = {"/ComprasController"})
public class ComprasController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ComprasDAO daoCompras = new ComprasDAO();
        
        String acao = (String) request.getParameter("acao");
        ArrayList<Compras> compras;
        int id;
        Compras compra;
        
        switch(acao) {
            //Requisição para exibir todas as compras
            case "mostrar_compras":
                compras = daoCompras.getCompras();
                request.setAttribute("compras", compras);
                RequestDispatcher mostrarCompras = getServletContext().getRequestDispatcher("/compras.jsp");
                mostrarCompras.forward(request, response);
                break;
                
            //Requisição para exibir a compra pelo id
            case "mostrar_compra":
                id = Integer.parseInt(request.getParameter("id"));
                compra = daoCompras.getCompraId(id);
                request.setAttribute("compra", compra);
                RequestDispatcher mostrarCompra = getServletContext().getRequestDispatcher("/compra.jsp");
                mostrarCompra.forward(request, response);
                break;
        }
        
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
