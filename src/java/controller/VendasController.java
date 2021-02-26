package controller;

import aplicacao.Vendas;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.VendasDAO;

@WebServlet(name = "VendasController", urlPatterns = {"/VendasController"})
public class VendasController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
             
        VendasDAO dao = new VendasDAO();
        String acao = (String) request.getParameter("acao");
        ArrayList<Vendas> vendas;
        
        switch(acao) {
            
            case "mostrar_vendas":
                vendas = dao.getVendas();
                request.setAttribute("vendas", vendas);
                RequestDispatcher mostrarVendas = getServletContext().getRequestDispatcher("/aevendas.jsp");
                mostrarVendas.forward(request, response);
                break;
            
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
