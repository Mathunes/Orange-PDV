package model;

import aplicacao.Vendas;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
    
    public ArrayList<Vendas> getVendas(){
        ArrayList<Vendas> vendas = new ArrayList();
        
        try{
           Statement stmt  = conexao.createStatement();
           
           ResultSet rs = stmt.executeQuery("SELECT * FROM vendas");
           
           while(rs.next()){
               Vendas venda = new Vendas();
               
               venda.setId(rs.getInt("id"));
               venda.setQuantidadeVenda(rs.getInt("quantidade_venda"));
               venda.setDataVenda(rs.getString("data_venda"));
               venda.setValorVenda(rs.getDouble("valor_venda"));
               venda.setIdCliente(rs.getInt("id_cliente"));
               venda.setIdProduto(rs.getInt("id_produto"));
               venda.setIdVendedor(rs.getInt("id_vendedor"));
               
               vendas.add(venda);
           }
                   
        }catch(SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return vendas;
    }
    

}
