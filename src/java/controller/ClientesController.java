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
            //Requisição para exibir todos os clientes
            case "mostrar_clientes":
                clientes = dao.getClientes();
                request.setAttribute("clientes", clientes);
                RequestDispatcher mostrarClientes = getServletContext().getRequestDispatcher("/clientes.jsp");
                mostrarClientes.forward(request, response);
                break;
            
            //Requisição para exibir o cliente pelo id
            case "mostrar_cliente":
                id = Integer.parseInt(request.getParameter("id"));
                cliente = dao.getClienteId(id);
                request.setAttribute("cliente", cliente);
                RequestDispatcher mostrarCliente = getServletContext().getRequestDispatcher("/cliente.jsp");
                mostrarCliente.forward(request, response);
                break;
            
            //Requisição para exibir o cliente pelo nome - usado no campo de busca
            case "mostrar_clientes_nome":
                String nome = request.getParameter("nome");
                clientes = dao.getClienteNome(nome);
                request.setAttribute("clientes", clientes);
                RequestDispatcher mostrarClientesNome = getServletContext().getRequestDispatcher("/clientes.jsp");
                mostrarClientesNome.forward(request, response);
                break;
                
            //Requisição para editar o cliente pelo id
            case "editar_cliente":
                id = Integer.parseInt(request.getParameter("id"));
                cliente = dao.getClienteId(id);
                
                request.setAttribute("cliente", cliente);
                RequestDispatcher editarCliente = request.getRequestDispatcher("/formcliente.jsp");
                editarCliente.forward(request, response);
                
                break;
                
            //Requisição para excluir o cliente pelo id
            case "excluir_cliente":
                id = Integer.parseInt(request.getParameter("id"));
                if (dao.excluir(id))
                    request.setAttribute("mensagem", "Cliente excluído");
                else
                    request.setAttribute("mensagem", "Erro ao excluir cliente");
                
                //Enviando relação de clientes para evitar o reload e perder a mensagem
                clientes = dao.getClientes();
                request.setAttribute("clientes", clientes);
                
                RequestDispatcher excluirCliente = getServletContext().getRequestDispatcher("/clientes.jsp");
                excluirCliente.forward(request, response);
                break;
                
            //Requisição para cadastrar o cliente
            case "cadastrar_cliente":
                cliente = new Clientes();
                cliente.setId(0);
                cliente.setNome("");
                cliente.setCpf("");
                cliente.setEndereco("");
                cliente.setBairro("");
                cliente.setCidade("");
                cliente.setUf("");
                cliente.setCep("");
                cliente.setTelefone("");
                cliente.setEmail("");
                
                request.setAttribute("cliente", cliente);
                
                RequestDispatcher cadastrarCliente = getServletContext().getRequestDispatcher("/formcliente.jsp");
                cadastrarCliente.forward(request, response);
                break;
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
                
        String mensagem;
        
        Clientes cliente = new Clientes();
        ClientesDAO dao = new ClientesDAO();
        
        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String endereco = request.getParameter("endereco");
        String bairro = request.getParameter("bairro");
        String cidade = request.getParameter("cidade");
        String uf = request.getParameter("uf");
        String cep = request.getParameter("cep");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");
        
        if (nome.isEmpty() || cpf.isEmpty() || endereco.isEmpty() || bairro.isEmpty() || 
                cidade.isEmpty() || uf.isEmpty() || cep.isEmpty() || telefone.isEmpty() || 
                email.isEmpty())    
            mensagem = "Preencha todos os campos";
        else if (nome.length() > 50)
            mensagem = "Nome deve conter no máximo 50 caracteres";
        else if (cpf.length() > 14) 
            mensagem = "CPF deve conter no máximo 14 caracteres";
        else if (endereco.length() > 50)
            mensagem = "Estado deve conter no máximo 50 caracteres";
        else if (bairro.length() > 50)
            mensagem = "Bairro deve conter no máximo 50 caracteres";
        else if (cidade.length() > 50)
            mensagem = "Cidade deve conter no máximo 50 caracteres";
        else if (uf.length() > 2)
            mensagem = "UF deve conter no máximo 2 caracteres";
        else if (cep.length() > 8)
            mensagem = "CEP deve conter no máximo 8 caracteres";
        else if (telefone.length() > 20)
            mensagem = "Telefone deve conter no máximo 20 caracteres";
        else if (email.length() > 50)
            mensagem = "Email deve conter no máximo 50 caracteres";
        else {
            
            cliente.setId(id);
            cliente.setNome(nome);
            cliente.setCpf(cpf);
            cliente.setEndereco(endereco);
            cliente.setBairro(bairro);
            cliente.setCidade(cidade);
            cliente.setUf(uf);
            cliente.setCep(cep);
            cliente.setTelefone(telefone);
            cliente.setEmail(email);

            if (dao.gravar(cliente))
                mensagem = "Cliente gravado com sucesso";
            else 
                mensagem = "Erro ao gravar cliente";
        }
        //Enviando relação de clientes para clientes.jsp
        ArrayList<Clientes> clientes;       
        clientes = dao.getClientes();
        request.setAttribute("clientes", clientes);
        request.setAttribute("mensagem", mensagem);
        RequestDispatcher rd = request.getRequestDispatcher("/clientes.jsp");
        rd.forward(request, response);
        
    }

}
