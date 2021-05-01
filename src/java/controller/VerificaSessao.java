package controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//Servlet para filtrar a URL e restringir acessos indevidos
@WebFilter(filterName = "VerificaSessao", urlPatterns = {"/produtos.jsp", 
    "/vendas.jsp", "/clientes.jsp", "/navbarvendedor.jsp", "/navbarcomprador.jsp",
    "/navbaradministrador.jsp", "/ClientesController", "/cliente.jsp",
    "/formcliente.jsp", "/venda.jsp", "/formvenda.jsp", "/VendasController", 
    "/ProdutosController", "/administrador.jsp", "/compras.jsp", "/compra.jsp", 
    "/formcompra.jsp", "/ComprasController", "/produtoscomprador.jsp", 
    "/formproduto.jsp", "/produto.jsp", "/CategoriasController", "/FornecedoresController", 
    "/formfornecedor.jsp", "/formcategoria.jsp", "/categorias.jsp", "/fornecedores.jsp",
    "/categoria.jsp", "/fornecedor.jsp", "/relatorioestoque.jsp", "/relatoriovendas.jsp",
    "/vendaadm.jsp", "/produtoadm.jsp"})
public class VerificaSessao implements Filter {
    
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        HttpSession session = req.getSession();
        
        Object logado = session.getAttribute("logado");
        
        if (logado != null) {

            if (((String)logado).equals("ok")) {

                chain.doFilter(request, response);
                
            }
        //Se o usuário não estiver logado, redirecionar para index.jsp
        } else {
            res.sendRedirect("index.jsp");
        }
        
    }

    public void destroy() {        
    }

    public void init(FilterConfig filterConfig) {        
        
    }

}
