package model;

import aplicacao.Vendas;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
            ResultSet rs = stmt.executeQuery("SELECT * FROM "
                    + "vendas as v, "
                    + "clientes as c, "
                    + "produtos as p, "
                    + "usuarios as u"
                + " WHERE "
                    + "v.id_cliente = c.id AND "
                    + "v.id_produto = p.id AND "
                    + "v.id_vendedor = u.id");
            
            while (rs.next()) {
                Vendas venda = new Vendas();
                
                venda.setDataVenda(rs.getString("v.data_venda"));
                venda.setId(rs.getInt("v.id"));
                venda.setIdCliente(rs.getInt("v.id_cliente"));
                venda.setIdProduto(rs.getInt("v.id_produto"));
                venda.setIdVendedor(rs.getInt("v.id_vendedor"));
                venda.setNomeCliente(rs.getString("c.nome"));
                venda.setNomeProduto(rs.getString("p.nome_produto"));
                venda.setNomeVendedor(rs.getString("u.nome"));
                venda.setQuantidadeVenda(rs.getInt("v.quantidade_venda"));
                venda.setValorVenda(rs.getDouble("v.valor_venda"));
                
                vendas.add(venda);
            }
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return vendas;
    }

    public Vendas getVendaId(int id) {
        Vendas venda = new Vendas();
        
        try {
            String sql = "SELECT * FROM "
                    + "vendas as v, "
                    + "clientes as c, "
                    + "produtos as p, "
                    + "usuarios as u"
                + " WHERE "
                    + "v.id_cliente = c.id AND "
                    + "v.id_produto = p.id AND "
                    + "v.id_vendedor = u.id AND"
                    + "v.id = ?";
            
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                venda.setDataVenda(rs.getString("v.data_venda"));
                venda.setId(rs.getInt("v.id"));
                venda.setIdCliente(rs.getInt("v.id_cliente"));
                venda.setIdProduto(rs.getInt("v.id_produto"));
                venda.setIdVendedor(rs.getInt("v.id_vendedor"));
                venda.setNomeCliente(rs.getString("c.nome"));
                venda.setNomeProduto(rs.getString("p.nome_produto"));
                venda.setNomeVendedor(rs.getString("u.nome"));
                venda.setQuantidadeVenda(rs.getInt("v.quantidade_venda"));
                venda.setValorVenda(rs.getDouble("v.valor_venda"));
            }
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return venda;
    }
}
