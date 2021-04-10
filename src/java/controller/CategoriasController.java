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
        
        CategoriasDAO dao = new CategoriasDAO();
        String acao = (String) request.getParameter("acao");
        ArrayList<Categorias> categorias;
        int id;
        Categorias categoria;
        
        switch (acao) {
            case "mostrar_categorias":
                categorias = dao.getCategorias();
                request.setAttribute("categorias", categorias);
                RequestDispatcher mostrarCategorias = getServletContext().getRequestDispatcher("/categorias.jsp");
                mostrarCategorias.forward(request, response);
                break;
            
            //Requisição para exibir o categoria pelo id
            case "mostrar_categoria":
                id = Integer.parseInt(request.getParameter("id"));
                categoria = dao.getCategoriaID(id);
                request.setAttribute("categoria", categoria);
                RequestDispatcher mostrarCategoria = getServletContext().getRequestDispatcher("/categoria.jsp");
                mostrarCategoria.forward(request, response);
                break;
            
            //Requisição para exibir o categoria pelo nome - usado no campo de busca
            case "buscar_categorias":
                String nome_categoria = request.getParameter("nome_categoria");
                categorias = dao.getNomeCategoria(nome_categoria);
                request.setAttribute("categorias", categorias);
                RequestDispatcher mostrarCategoriasNome = getServletContext().getRequestDispatcher("/categorias.jsp");
                mostrarCategoriasNome.forward(request, response);
                break;
                
            //Requisição para editar o categoria pelo id
            case "editar_categoria":
                id = Integer.parseInt(request.getParameter("id"));
                categoria = dao.getCategoriaID(id);
                
                request.setAttribute("categoria", categoria);
                RequestDispatcher editarCategoria = request.getRequestDispatcher("/formcategoria.jsp");
                editarCategoria.forward(request, response);
                
                break;
                
            //Requisição para excluir o categoria pelo id
            case "excluir_categoria":
                id = Integer.parseInt(request.getParameter("id"));
                if (dao.excluir(id))
                    request.setAttribute("mensagem", "Categoria excluído");
                else
                    request.setAttribute("mensagem", "Categoria não pode ser excluída, pois está sendo referenciada em algum produto. Por favor, retire a referência e tente excluir novamente.");
                
                //Enviando relação de categorias para evitar o reload e perder a mensagem
                categorias = dao.getCategorias();
                request.setAttribute("categorias", categorias);
                
                RequestDispatcher excluirCategoria = getServletContext().getRequestDispatcher("/categorias.jsp");
                excluirCategoria.forward(request, response);
                break;
                
            //Requisição para cadastrar o categoria
            case "cadastrar_categoria":
                categoria = new Categorias();
                categoria.setId(0);
                categoria.setNomeCategoria("");
                
                request.setAttribute("categoria", categoria);
                
                RequestDispatcher cadastrarCategoria = getServletContext().getRequestDispatcher("/formcategoria.jsp");
                cadastrarCategoria.forward(request, response);
                break;
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
                
        String mensagem;
        
        Categorias categoria = new Categorias();
        CategoriasDAO dao = new CategoriasDAO();
        
        int id = Integer.parseInt(request.getParameter("id"));
        String nomeCategoria = request.getParameter("nome_categoria");

        
        if (nomeCategoria.isEmpty())    
            mensagem = "Preencha todos os campos";
        else if (nomeCategoria.length() > 50)
            mensagem = "Nome deve conter no máximo 50 caracteres";
       
        else {
            
            categoria.setId(id);
            categoria.setNomeCategoria(nomeCategoria);
     

            if (dao.gravar(categoria))
                mensagem = "Categoria gravada com sucesso";
            else 
                mensagem = "Erro ao gravar categoria";
        }
        ArrayList<Categorias> categorias;       
        categorias = dao.getCategorias();
        request.setAttribute("categorias", categorias);
        request.setAttribute("mensagem", mensagem);
        RequestDispatcher rd = request.getRequestDispatcher("/categorias.jsp");
        rd.forward(request, response);
    }
}
