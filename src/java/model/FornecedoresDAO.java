package model;

import aplicacao.Fornecedores;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(name = "FornecedoresDAO", urlPatterns = {"/FornecedoresDAO"})
public class FornecedoresDAO extends HttpServlet {

    private Connection conexao;
    
    public FornecedoresDAO() {
        try {
            conexao = Conexao.criaConexao();
        } catch (SQLException ex) {
            System.out.println("Erro na criação da conexao DAO: " + ex.getMessage());
        }
    }

    public ArrayList<Fornecedores> getFornecedores() {
        ArrayList<Fornecedores> fornecedores = new ArrayList<>();
        
        try {
            Statement stmt = conexao.createStatement();
            
            ResultSet rs = stmt.executeQuery("SELECT * FROM fornecedores ORDER BY razao_social");
            
            while (rs.next()) {
                
                Fornecedores fornecedor = new Fornecedores();
                
                fornecedor.setId(rs.getInt("id"));
                fornecedor.setRazaoSocial(rs.getString("razao_social"));
                fornecedor.setCnpj(rs.getString("cnpj"));
                fornecedor.setEndereco(rs.getString("endereco"));
                fornecedor.setBairro(rs.getString("bairro"));
                fornecedor.setCidade(rs.getString("cidade"));
                fornecedor.setUf(rs.getString("uf"));
                fornecedor.setCep(rs.getString("cep"));
                fornecedor.setTelefone(rs.getString("telefone"));
                fornecedor.setEmail(rs.getString("email"));
                
                fornecedores.add(fornecedor);   
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return fornecedores;
    }

    public Fornecedores getFornecedorId(int id) {
        Fornecedores fornecedor = new Fornecedores();
        
        try {
            String sql = "SELECT * FROM fornecedores WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                fornecedor.setId(rs.getInt("id"));
                fornecedor.setRazaoSocial(rs.getString("razao_social"));
                fornecedor.setCnpj(rs.getString("cnpj"));
                fornecedor.setEndereco(rs.getString("endereco"));
                fornecedor.setBairro(rs.getString("bairro"));
                fornecedor.setCidade(rs.getString("cidade"));
                fornecedor.setUf(rs.getString("uf"));
                fornecedor.setCep(rs.getString("cep"));
                fornecedor.setTelefone(rs.getString("telefone"));
                fornecedor.setEmail(rs.getString("email"));
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return fornecedor;
    }
    
    public ArrayList<Fornecedores> getRazaoSocialFornecedor(String razaoSocial) {
        ArrayList<Fornecedores> fornecedores = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM fornecedores WHERE razao_social LIKE ? ORDER BY razao_social";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, '%' + razaoSocial + '%');
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                
                Fornecedores fornecedor = new Fornecedores();
                
                fornecedor.setId(rs.getInt("id"));
                fornecedor.setRazaoSocial(rs.getString("razao_social"));
                fornecedor.setCnpj(rs.getString("cnpj"));
                fornecedor.setEndereco(rs.getString("endereco"));
                fornecedor.setBairro(rs.getString("bairro"));
                fornecedor.setCidade(rs.getString("cidade"));
                fornecedor.setUf(rs.getString("uf"));
                fornecedor.setCep(rs.getString("cep"));
                fornecedor.setTelefone(rs.getString("telefone"));
                fornecedor.setEmail(rs.getString("email"));
                
                fornecedores.add(fornecedor);
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return fornecedores;
    }
    
    public boolean excluir(int id) {
        try {
            String sql = "DELETE FROM fornecedores WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            return false;
        }
    }
    
    public boolean gravar(Fornecedores fornecedor) {
        
        try {
            String sql;
            
            if (fornecedor.getId() == 0) {
                sql = "INSERT INTO fornecedores "
                        + "(razao_social, cnpj, endereco, bairro, cidade, uf, cep, telefone, email)"
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            } else {
                sql = "UPDATE fornecedores SET "
                        + "razao_social=?, cnpj=?, endereco=?, bairro=?, cidade=?, uf=?, cep=?, telefone=?, email=?"
                        + "WHERE id=?";
            }
            
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, fornecedor.getRazaoSocial());
            ps.setString(2, fornecedor.getCnpj());
            ps.setString(3, fornecedor.getEndereco());
            ps.setString(4, fornecedor.getBairro());
            ps.setString(5, fornecedor.getCidade());
            ps.setString(6, fornecedor.getUf());
            ps.setString(7, fornecedor.getCep());
            ps.setString(8, fornecedor.getTelefone());
            ps.setString(9, fornecedor.getEmail());
            
            if (fornecedor.getId() > 0)
                ps.setInt(10, fornecedor.getId());
            
            ps.execute();
            
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            
            return false;
        }
            
    }
}
