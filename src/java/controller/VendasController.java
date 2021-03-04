package controller;

import aplicacao.Clientes;
import aplicacao.Produtos;
import aplicacao.Vendas;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
                
                RequestDispatcher cadastrarVenda = request.getRequestDispatcher("/formvenda.jsp");
                cadastrarVenda.forward(request, response);
                break;
            
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
                
        String mensagem;
        
        Vendas venda = new Vendas();
        VendasDAO dao = new VendasDAO();
        
        int id = Integer.parseInt(request.getParameter("id"));
        int idProduto = Integer.parseInt(request.getParameter("idProduto"));
        int idVendedor = Integer.parseInt(request.getParameter("idVendedor"));
        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        String dataVenda = request.getParameter("dataVenda");
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));
        Double valorVenda = Double.parseDouble(request.getParameter("valorTotal"));
        
//        if (nome.isEmpty() || cpf.isEmpty() || endereco.isEmpty() || bairro.isEmpty() || 
//                cidade.isEmpty() || uf.isEmpty() || cep.isEmpty() || telefone.isEmpty() || 
//                email.isEmpty())    
//            mensagem = "Preencha todos os campos";
//        else if (nome.length() > 50)
//            mensagem = "Nome deve conter no máximo 50 caracteres";
//        else if (cpf.length() > 14) 
//            mensagem = "CPF deve conter no máximo 14 caracteres";
//        else if (endereco.length() > 50)
//            mensagem = "Estado deve conter no máximo 50 caracteres";
//        else if (bairro.length() > 50)
//            mensagem = "Bairro deve conter no máximo 50 caracteres";
//        else if (cidade.length() > 50)
//            mensagem = "Cidade deve conter no máximo 50 caracteres";
//        else if (uf.length() > 2)
//            mensagem = "UF deve conter no máximo 2 caracteres";
//        else if (cep.length() > 8)
//            mensagem = "CEP deve conter no máximo 8 caracteres";
//        else if (telefone.length() > 20)
//            mensagem = "Telefone deve conter no máximo 20 caracteres";
//        else if (email.length() > 50)
//            mensagem = "Email deve conter no máximo 50 caracteres";
//        else {
            
            venda.setId(id);
            venda.setDataVenda(dataVenda);
            venda.setIdCliente(idCliente);
            venda.setIdProduto(idProduto);
            venda.setIdVendedor(idVendedor);
            venda.setQuantidadeVenda(quantidade);
            venda.setValorVenda(valorVenda);

            if (dao.gravar(venda))
                mensagem = "Venda gravada com sucesso";
            else 
                mensagem = "Erro ao gravar venda";
        //}
        //Enviando relação de clientes para aeclientes.jsp
        ArrayList<Vendas> vendas;
        vendas = dao.getVendas();
        request.setAttribute("vendas", vendas);
        request.setAttribute("mensagem", mensagem);
        RequestDispatcher rd = request.getRequestDispatcher("/aevendas.jsp");
        rd.forward(request, response);
        
    }

}
