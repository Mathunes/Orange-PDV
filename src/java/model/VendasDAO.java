package model;

import aplicacao.Vendas;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(name = "VendasDAO", urlPatterns = {"/VendasDAO"})
public class VendasDAO extends HttpServlet {

    private Connection conexao;

    public VendasDAO() {
        try {
            conexao = Conexao.criaConexao();
            
        } catch (SQLException ex) {
            System.out.println("Erro na criação da conexao DAO: " + ex.getMessage());
        } 
    }
    
    public ArrayList<Vendas> getVendas() {
        ArrayList<Vendas> vendas = new ArrayList<>();
        
        try {
            Statement stmt = conexao.createStatement();
            
            //PARA FAZER: RECUPERAR DADOS DE FORMA ORDENADA
            ResultSet rs = stmt.executeQuery("SELECT * FROM vendas as v, clientes as c WHERE v.id_cliente = c.id");
            
            while (rs.next()) {
                Vendas venda = new Vendas();
                
                venda.setId(rs.getInt("id"));
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(VendasDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return vendas;
    }
}
