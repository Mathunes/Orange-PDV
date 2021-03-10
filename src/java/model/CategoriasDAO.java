package model;

import aplicacao.Categorias;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CategoriasDAO", urlPatterns = {"/CategoriasDAO"})
public class CategoriasDAO extends HttpServlet {

    private Connection conexao;
    

    
    public CategoriasDAO(){
        try{
            conexao = Conexao.criaConexao();          
        }catch(SQLException ex){
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

}
