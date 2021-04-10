package controller;

import aplicacao.Fornecedores;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.FornecedoresDAO;

@WebServlet(name = "FornecedoresController", urlPatterns = {"/FornecedoresController"})
public class FornecedoresController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        FornecedoresDAO dao = new FornecedoresDAO();
        String acao = (String) request.getParameter("acao");
        ArrayList<Fornecedores> fornecedores;
        int id;
        Fornecedores fornecedor;
        
        switch (acao) {
            //Requisição para exibir todos os fornecedores
            case "mostrar_fornecedores":
                fornecedores = dao.getFornecedores();
                request.setAttribute("fornecedores", fornecedores);
                RequestDispatcher mostrarFornecedores = getServletContext().getRequestDispatcher("/fornecedores.jsp");
                mostrarFornecedores.forward(request, response);
                break;
            
            //Requisição para exibir o fornecedor pelo id
            case "mostrar_fornecedor":
                id = Integer.parseInt(request.getParameter("id"));
                fornecedor = dao.getFornecedorId(id);
                request.setAttribute("fornecedor", fornecedor);
                RequestDispatcher mostrarFornecedor = getServletContext().getRequestDispatcher("/fornecedor.jsp");
                mostrarFornecedor.forward(request, response);
                break;
            
            //Requisição para exibir o fornecedor pelo nome - usado no campo de busca
            case "mostrar_fornecedores_nome":
                String nome = request.getParameter("nome");
                fornecedores = dao.getRazaoSocialFornecedor(nome);
                request.setAttribute("fornecedores", fornecedores);
                RequestDispatcher mostrarFornecedoresNome = getServletContext().getRequestDispatcher("/fornecedores.jsp");
                mostrarFornecedoresNome.forward(request, response);
                break;
                
            //Requisição para editar o fornecedor pelo id
            case "editar_fornecedor":
                id = Integer.parseInt(request.getParameter("id"));
                fornecedor = dao.getFornecedorId(id);
                
                request.setAttribute("fornecedor", fornecedor);
                RequestDispatcher editarFornecedor = request.getRequestDispatcher("/formfornecedor.jsp");
                editarFornecedor.forward(request, response);
                
                break;
                
            //Requisição para excluir o fornecedor pelo id
            case "excluir_fornecedor":
                id = Integer.parseInt(request.getParameter("id"));
                if (dao.excluir(id))
                    request.setAttribute("mensagem", "Fornecedor excluído");
                else
                    request.setAttribute("mensagem", "Erro ao excluir fornecedor");
                
                //Enviando relação de fornecedores para evitar o reload e perder a mensagem
                fornecedores = dao.getFornecedores();
                request.setAttribute("fornecedores", fornecedores);
                
                RequestDispatcher excluirFornecedor = getServletContext().getRequestDispatcher("/fornecedores.jsp");
                excluirFornecedor.forward(request, response);
                break;
                
            //Requisição para cadastrar o fornecedor
            case "cadastrar_fornecedor":
                fornecedor = new Fornecedores();
                fornecedor.setId(0);
                fornecedor.setRazaoSocial("");
                fornecedor.setCnpj("");
                fornecedor.setEndereco("");
                fornecedor.setBairro("");
                fornecedor.setCidade("");
                fornecedor.setUf("");
                fornecedor.setCep("");
                fornecedor.setTelefone("");
                fornecedor.setEmail("");
                
                request.setAttribute("fornecedor", fornecedor);
                
                RequestDispatcher cadastrarFornecedor = getServletContext().getRequestDispatcher("/formfornecedor.jsp");
                cadastrarFornecedor.forward(request, response);
                break;
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
                
        String mensagem;
        
        Fornecedores fornecedor = new Fornecedores();
        FornecedoresDAO dao = new FornecedoresDAO();
        
        int id = Integer.parseInt(request.getParameter("id"));
        String razao_social = request.getParameter("razao_social");
        String cnpj = request.getParameter("cnpj");
        String endereco = request.getParameter("endereco");
        String bairro = request.getParameter("bairro");
        String cidade = request.getParameter("cidade");
        String uf = request.getParameter("uf");
        String cep = request.getParameter("cep");
        String telefone = request.getParameter("telefone");
        String email = request.getParameter("email");
        
        if (razao_social.isEmpty() || cnpj.isEmpty() || endereco.isEmpty() || bairro.isEmpty() || 
                cidade.isEmpty() || uf.isEmpty() || cep.isEmpty() || telefone.isEmpty() || 
                email.isEmpty())    
            mensagem = "Preencha todos os campos";
        else if (razao_social.length() > 50)
            mensagem = "Razao Social deve conter no máximo 50 caracteres";
        else if (cnpj.length() > 14) 
            mensagem = "CNPJ deve conter no máximo 14 caracteres";
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
        else if (!validaCNPJ(cnpj))
            mensagem = "CNPJ inválido";
        else {
            
            fornecedor.setId(id);
            fornecedor.setRazaoSocial(razao_social);
            fornecedor.setCnpj(cnpj);
            fornecedor.setEndereco(endereco);
            fornecedor.setBairro(bairro);
            fornecedor.setCidade(cidade);
            fornecedor.setUf(uf);
            fornecedor.setCep(cep);
            fornecedor.setTelefone(telefone);
            fornecedor.setEmail(email);

            if (dao.gravar(fornecedor))
                mensagem = "Fornecedor gravado com sucesso";
            else 
                mensagem = "Erro ao gravar fornecedor";
        }
        //Enviando relação de fornecedores para fornecedores.jsp
        ArrayList<Fornecedores> fornecedores;       
        fornecedores = dao.getFornecedores();
        request.setAttribute("fornecedores", fornecedores);
        request.setAttribute("mensagem", mensagem);
        RequestDispatcher rd = request.getRequestDispatcher("/fornecedores.jsp");
        rd.forward(request, response);
        
    }
    
    public static boolean validaCNPJ(String cnpj) {
        double soma = 0;
        double resto;
        
        cnpj = cnpj.replaceAll("\\.", "");
        cnpj = cnpj.replaceAll("\\-", "");
        
        if ((cnpj.equals("00000000000")) || (cnpj.equals("11111111111")) || (cnpj.equals("22222222222")) 
            || (cnpj.equals("33333333333")) || (cnpj.equals("44444444444")) || (cnpj.equals("55555555555")) 
            || (cnpj.equals("66666666666")) || (cnpj.equals("77777777777")) || (cnpj.equals("88888888888")) 
            || (cnpj.equals("99999999999")))
            return false;
        
        for (int i=1; i<=9; i++)
            soma += (Integer.parseInt(cnpj.substring(i-1, i)) * (11 - i));
        resto = (soma * 10) % 11;
        
        if ((resto == 10) || (resto == 11))
            resto = 0;
        if (resto != Integer.parseInt(cnpj.substring(9,10))) 
            return false;
        
        soma = 0;
        for (int i = 1; i <= 10; i++)
            soma += (Integer.parseInt(cnpj.substring(i-1, i)) * (12 - i));
        resto = (soma * 10) % 11;

        if ((resto == 10) || (resto == 11))
            resto = 0;
        if (resto != Integer.parseInt(cnpj.substring(10,11))) 
            return false;
        return true;

    }

}
