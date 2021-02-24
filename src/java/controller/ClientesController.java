package controller;

import aplicacao.Clientes;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.ClientesDAO;

@WebServlet(name = "ClientesController", urlPatterns = {"/ClientesController"})
public class ClientesController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ClientesDAO dao = new ClientesDAO();
        String acao = (String) request.getParameter("acao");
        ArrayList<Clientes> clientes;
        int id;
        Clientes cliente;
        
        switch (acao) {
            case "clientes":
                clientes = dao.getClientes();
                request.setAttribute("clientes", clientes);
                RequestDispatcher mostrarClientes = getServletContext().getRequestDispatcher("/aeclientes.jsp");
                mostrarClientes.forward(request, response);
                break;
                
            case "cliente":
                id = Integer.parseInt(request.getParameter("id"));
                cliente = dao.getClienteId(id);
                request.setAttribute("cliente", cliente);
                RequestDispatcher mostrarCliente = getServletContext().getRequestDispatcher("/aecliente.jsp");
                mostrarCliente.forward(request, response);
                break;
                
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String acao = (String) request.getParameter("acao");
        
        
        switch (acao) {
            case "novocliente":
                
                String mensagem = gravar(request, response);
                request.setAttribute("mensagem", mensagem);
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/aenovocliente.jsp");
                rd.forward(request, response);
                break;
        
        }

    }

    public String gravar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Clientes cliente = new Clientes();
        ClientesDAO dao = new ClientesDAO();
        
        cliente.setId(Integer.parseInt(request.getParameter("id")));
        cliente.setNome(request.getParameter("nome"));
        cliente.setCpf(request.getParameter("cpf"));
        cliente.setEndereco(request.getParameter("endereco"));
        cliente.setBairro(request.getParameter("bairro"));
        cliente.setCidade(request.getParameter("cidade"));
        cliente.setUf(request.getParameter("uf"));
        cliente.setCep(request.getParameter("cep"));
        cliente.setTelefone(request.getParameter("telefone"));
        cliente.setEmail(request.getParameter("email"));

        if (dao.gravar(cliente)) {
            return "Contato gravado com sucesso!";
        } 
        return "Erro ao gravar contato!";

    }
}
