package model;

import aplicacao.Clientes;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(name = "ClientesDAO", urlPatterns = {"/ClientesDAO"})
public class ClientesDAO extends HttpServlet {

    private Connection conexao;
    
    public ClientesDAO() {
        try {
            
            conexao = Conexao.criaConexao();
            
        } catch (SQLException ex) {
            System.out.println("Erro na criação da conexao DAO: " + ex.getMessage());
        }
    }

    public ArrayList<Clientes> getClientes() {
        ArrayList<Clientes> clientes = new ArrayList<>();
        
        try {
            Statement stmt = conexao.createStatement();
            
            ResultSet rs = stmt.executeQuery("SELECT * FROM clientes");
            
            while (rs.next()) {
                
                Clientes cliente = new Clientes();
                
                cliente.setId(rs.getInt("id"));
                cliente.setNome(rs.getString("nome"));
                cliente.setCpf(rs.getString("cpf"));
                cliente.setEndereco(rs.getString("endereco"));
                cliente.setBairro(rs.getString("bairro"));
                cliente.setCidade(rs.getString("cidade"));
                cliente.setUf(rs.getString("uf"));
                cliente.setCep(rs.getString("cep"));
                cliente.setTelefone(rs.getString("telefone"));
                cliente.setEmail(rs.getString("email"));
                
                clientes.add(cliente);   
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return clientes;
    }

}
