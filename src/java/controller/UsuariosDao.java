package controller;

import aplicacao.Usuarios;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Conexao;
import model.UsuariosDAO;

public class UsuariosDao extends UsuariosDAO {

    private Connection conexao;
    
    public UsuariosDao() {
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
                usuario.setTipo(rs.getString("tipo").charAt(0));
            }
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        } 
        
        return usuario;
    }
    
}
