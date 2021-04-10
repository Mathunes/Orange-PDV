package model;

import aplicacao.Categorias;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(name = "CategoriasDAO", urlPatterns = {"/CategoriasDAO"})
public class CategoriasDAO extends HttpServlet {

    private Connection conexao;
    
    public CategoriasDAO(){
        try {
            conexao = Conexao.criaConexao();          
        } catch(SQLException ex){
            System.out.println("Erro na criação da conexao DAO: " + ex.getMessage());
        }
        
    }
    
    public ArrayList<Categorias> getCategorias(){
        ArrayList<Categorias> categorias = new ArrayList<>();
        
        try{
            Statement stmt = conexao.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM categorias");
            
            while(rs.next()){
                Categorias categoria = new Categorias();
                
                categoria.setId(rs.getInt("id"));
                categoria.setNomeCategoria(rs.getString("nome_categoria"));
                
                categorias.add(categoria);
            }
            
        }catch(SQLException ex){
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return categorias;
    }
    
    public Categorias getCategoriaID (int id) {
        Categorias categoria = new Categorias();
        
        try {
            String sql = "SELECT * FROM categorias WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                categoria.setId(rs.getInt("id"));
                categoria.setNomeCategoria(rs.getString("nome_categoria"));
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return categoria;
    }
public ArrayList<Categorias> getClienteNome(String nome_categoria) {
        ArrayList<Categorias> categorias = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM categorias WHERE nome_categoria LIKE ? ORDER BY nome_categoria";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, '%' + nome_categoria + '%');
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                
                Categorias categoria = new Categorias();
                
                categoria.setId(rs.getInt("id"));
                categoria.setNomeCategoria(rs.getString("nome_categoria"));

                
                categorias.add(categoria);
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return categorias;
    }
    
    public boolean excluir(int id) {
        try {
            String sql = "DELETE FROM categorias WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            return false;
        }
    }
    
    public boolean gravar(Categorias categoria) {
        
        try {
            String sql;
            
            if (categoria.getId() == 0) {
                sql = "INSERT INTO categorias "
                        + "(nome_categoria)"
                        + "VALUES (?)";
            } else {
                sql = "UPDATE categorias SET "
                        + "nome_categoria=?"
                        + "WHERE id=?";
            }
            
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, categoria.getNomeCategoria());
            
            if (categoria.getId() > 0)
                ps.setInt(2, categoria.getId());
            
            ps.execute();
            
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            
            return false;
        }
            
    }
}
