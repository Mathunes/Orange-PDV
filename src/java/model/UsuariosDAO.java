package model;

import aplicacao.Usuarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;


@WebServlet(name = "UsuariosDAO", urlPatterns = {"/UsuariosDAO"})
public class UsuariosDAO extends HttpServlet {

    private Connection conexao;
    private int tipo;
    
    public UsuariosDAO() {
        try {
            conexao = Conexao.criaConexao();
        } catch (SQLException ex) {
            System.out.println("Erro na criação da conexao DAO: " + ex.getMessage());
        }
        
    }
    
    public Usuarios Login(Usuarios usuario) {
        
        try {
          
            String sql = "SELECT * FROM usuarios WHERE cpf = ? and senha = ?";
            
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, usuario.getCpf());
            ps.setString(2, usuario.getSenha());
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("Nome"));
                usuario.setTipo(rs.getString("tipo"));
            }
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        } 
        
        return usuario;
    }
    public ArrayList<Usuarios> getUsuarios() {
        ArrayList<Usuarios> usuarios = new ArrayList<>();
        
        try {
            Statement stmt = conexao.createStatement();
            
            ResultSet rs = stmt.executeQuery("SELECT * FROM usuarios ORDER BY nome");
            
            while (rs.next()) {
                
                Usuarios usuario = new Usuarios();
                
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setCpf(rs.getString("cpf"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setTipo(rs.getString("tipo"));

                
                usuarios.add(usuario);   
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return usuarios;
    }

    public Usuarios getUsuarioId(int id) {
        Usuarios usuario = new Usuarios();
        
        try {
            String sql = "SELECT * FROM usuarios WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setCpf(rs.getString("cpf"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setTipo(rs.getString("tipo"));
                
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return usuario;
    }
    
    public ArrayList<Usuarios> getUsuarioNome(String nome) {
        ArrayList<Usuarios> usuarios = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM usuarios WHERE nome LIKE ? ORDER BY nome";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, '%' + nome + '%');
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                
                Usuarios usuario = new Usuarios();
                
                 usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setCpf(rs.getString("cpf"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setTipo(rs.getString("tipo"));
                
                usuarios.add(usuario);
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return usuarios;
    }
    
    public boolean excluir(int id) {
        try {
            String sql = "DELETE FROM usuarios WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            return false;
        }
    }
    
    public boolean gravar(Usuarios usuario) {
        
        try { 
            String sql;
            
            if (usuario.getId() == 0) {
                sql = "INSERT INTO usuarios "
                        + "(nome, cpf, senha, tipo)"
                        + "VALUES (?, ?, ?, ?)";
            } else {
                sql = "UPDATE usuarios SET "
                        + "nome=?, cpf=?, senha=?, tipo=?"
                        + "WHERE id=?";
            }
            
            Integer.toString(tipo);
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, usuario.getNome());
            ps.setString(2, usuario.getCpf());
            ps.setString(3, usuario.getSenha());
            ps.setString(4, usuario.getTipo());
    
            if (usuario.getId() > 0)
                ps.setInt(5, usuario.getId());
            
            ps.execute();
            
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            
            return false;
        }
            
    }

}
