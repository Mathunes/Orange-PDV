package controller;

import aplicacao.Clientes;
import aplicacao.Produtos;
import aplicacao.Vendas;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ClientesDAO;
import model.VendasDAO;
import model.ProdutosDAO;

@WebServlet(name = "VendasController", urlPatterns = {"/VendasController"})
public class VendasController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
             
        VendasDAO daoVendas = new VendasDAO();
        ClientesDAO daoClientes = new ClientesDAO();
        ProdutosDAO daoProdutos = new ProdutosDAO();
        
        String acao = (String) request.getParameter("acao");
        ArrayList<Vendas> vendas;
        int id;
        Vendas venda;
        
        ArrayList<Clientes> clientes;
        ArrayList<Produtos> produtos;
        
        switch(acao) {
            
            case "mostrar_vendas":
                vendas = daoVendas.getVendas();
                request.setAttribute("vendas", vendas);
                RequestDispatcher mostrarVendas = getServletContext().getRequestDispatcher("/aevendas.jsp");
                mostrarVendas.forward(request, response);
                break;
                
            case "mostrar_venda":
                id = Integer.parseInt(request.getParameter("id"));
                venda = daoVendas.getVendaId(id);
                request.setAttribute("venda", venda);
                RequestDispatcher mostrarVenda = getServletContext().getRequestDispatcher("/aevenda.jsp");
                mostrarVenda.forward(request, response);
                break;
                
            case "cadastrar_venda":
                int idProduto = Integer.parseInt(request.getParameter("produto"));
                if (!(idProduto > 0))
                    idProduto = 0;
                
                Produtos produto = daoProdutos.getProdutoID(idProduto);
                
                venda = new Vendas();
                
                venda.setId(0);
                venda.setIdCliente(0);
                venda.setIdProduto(idProduto);
                venda.setIdVendedor(0);
                venda.setNomeCliente("");
                venda.setNomeProduto("");
                venda.setNomeVendedor("");
                venda.setQuantidadeVenda(0);
                venda.setValorVenda(0);
                venda.setDataVenda("");
                
                clientes = daoClientes.getClientes();
                
                request.setAttribute("venda", venda);
                request.setAttribute("produto", produto);
                request.setAttribute("clientes", clientes);
                
                RequestDispatcher cadastrarVenda = getServletContext().getRequestDispatcher("/formvenda.jsp");
                cadastrarVenda.forward(request, response);
                break;
            
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
