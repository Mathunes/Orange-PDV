package controller;

import aplicacao.Compras;
import aplicacao.Fornecedores;
import aplicacao.Produtos;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ComprasDAO;
import model.FornecedoresDAO;
import model.ProdutosDAO;

@WebServlet(name = "ComprasController", urlPatterns = {"/ComprasController"})
public class ComprasController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ComprasDAO daoCompras = new ComprasDAO();
        FornecedoresDAO daoFornecedores = new FornecedoresDAO();
        ProdutosDAO daoProdutos = new ProdutosDAO();
        
        
        String acao = (String) request.getParameter("acao");
        ArrayList<Compras> compras;
        int id;
        Compras compra;
        
        ArrayList<Fornecedores> fornecedores;
        ArrayList<Produtos> produtos;
        
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
                
            //Requisição para excluir a compra pelo id
            case "excluir_compra":
                id = Integer.parseInt(request.getParameter("id"));
                if (daoCompras.excluir(id))
                    request.setAttribute("mensagem", "Compra excluída");
                else
                    request.setAttribute("mensagem", "Erro ao excluir compra");
                
                //Enviando relação de compras para evitar o reload e perder a mensagem
                compras = daoCompras.getCompras();
                request.setAttribute("compras", compras);
                    
                RequestDispatcher excluirCompra = getServletContext().getRequestDispatcher("/compras.jsp");
                excluirCompra.forward(request, response);
                break;
                
            case "cadastrar_compra":
                int idProduto = Integer.parseInt(request.getParameter("produto"));
                if (!(idProduto > 0))
                    idProduto = 0;
                
                Produtos produto = daoProdutos.getProdutoID(idProduto);
                
                compra = new Compras();
                
                compra.setId(0);
                compra.setIdFornecedor(0);
                compra.setIdProduto(idProduto);
                compra.setIdComprador(0);
                compra.setRazaoSocialFornecedor("");
                compra.setNomeProduto("");
                compra.setNomeComprador("");
                compra.setQuantidadeCompra(0);
                compra.setValorCompra(0);
                compra.setDataCompra("");
                
                fornecedores = daoFornecedores.getFornecedores();
                produtos = daoProdutos.getProdutos();
                
                request.setAttribute("compra", compra);
                request.setAttribute("produto", produto);
                request.setAttribute("fornecedores", fornecedores);
                request.setAttribute("produtos", produtos);
                
                RequestDispatcher cadastrarCompra = getServletContext().getRequestDispatcher("/formcompra.jsp");
                cadastrarCompra.forward(request, response);
                break;
                
        }
        
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String mensagem;
        
        Compras compra = new Compras();
        ComprasDAO dao = new ComprasDAO();
        
        int id = Integer.parseInt(request.getParameter("id"));
        int idProduto = Integer.parseInt(request.getParameter("idProduto"));
        int idComprador = Integer.parseInt(request.getParameter("idComprador"));
        int idFornecedor = Integer.parseInt(request.getParameter("idFornecedor"));
        String dataCompra = request.getParameter("dataCompra");
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));
        Double valorProduto = Double.parseDouble(request.getParameter("valorProduto"));
        Double valorCompra = Double.parseDouble(request.getParameter("valorTotal"));
        
        if (idProduto == 0 || idComprador == 0 || idFornecedor == 0 || 
                dataCompra.isEmpty() || quantidade == 0)    
            mensagem = "Preencha todos os campos";
        else if (quantidade < 1)
            mensagem = "Deve haver pelo menos uma quantidade do produto escolhido";
        else if (valorCompra != (valorProduto * quantidade)) 
            mensagem = "Valor total inválido";
        else {
            
            compra.setId(id);
            compra.setDataCompra(dataCompra);
            compra.setIdFornecedor(idFornecedor);
            compra.setIdProduto(idProduto);
            compra.setIdComprador(idComprador);
            compra.setQuantidadeCompra(quantidade);
            compra.setValorCompra(valorCompra);

            if (dao.gravar(compra))
                mensagem = "Compra gravada com sucesso";
            else 
                mensagem = "Erro ao gravar compra";
        }
        
        //Enviando relação de compras para compras.jsp
        ArrayList<Compras> compras;
        compras = dao.getCompras();
        request.setAttribute("compras", compras);
        request.setAttribute("mensagem", mensagem);
        RequestDispatcher rd = request.getRequestDispatcher("/compras.jsp");
        rd.forward(request, response);
        
    }

}
