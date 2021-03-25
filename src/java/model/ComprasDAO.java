package model;

import aplicacao.Compras;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(name = "ComprasDAO", urlPatterns = {"/ComprasDAO"})
public class ComprasDAO extends HttpServlet {

    private Connection conexao;
    
    public ComprasDAO() {
        try {
            conexao = Conexao.criaConexao();
        } catch (SQLException ex) {
            System.out.println("Erro na criação da conexao DAO: " + ex.getMessage());
        }
    }
    
    public ArrayList<Compras> getCompras() {
        ArrayList<Compras> compras = new ArrayList<>();
        
        try {
            Statement stmt = conexao.createStatement();
            
            ResultSet rs = stmt.executeQuery("SELECT * FROM "
                    + "compras as c, "
                    + "fornecedores as f, "
                    + "produtos as p, "
                    + "usuarios as u"
                + " WHERE "
                    + "c.id_fornecedor = f.id AND "
                    + "c.id_produto = p.id AND "
                    + "c.id_comprador = u.id "
                + "ORDER BY c.id");
            
            while (rs.next()) {
                Compras compra = new Compras();
                
                compra.setDataCompra(rs.getString("c.data_compra"));
                compra.setIdFornecedor(rs.getInt("c.id_fornecedor"));
                compra.setId(rs.getInt("c.id"));
                compra.setIdProduto(rs.getInt("c.id_produto"));
                compra.setIdComprador(rs.getInt("c.id_comprador"));
                compra.setRazaoSocialFornecedor(rs.getString("f.razao_social"));
                compra.setNomeProduto(rs.getString("p.nome_produto"));
                compra.setNomeComprador(rs.getString("u.nome"));
                compra.setQuantidadeCompra(rs.getInt("c.quantidade_compra"));
                compra.setValorCompra(rs.getDouble("c.valor_compra"));
                
                compras.add(compra);
            }
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return compras;
        
    }
    
    public Compras getCompraId(int id) {
        Compras compra = new Compras();
        
        try {
            String sql = "SELECT * FROM "
                    + "compras as c, "
                    + "fornecedores as f, "
                    + "produtos as p, "
                    + "usuarios as u"
                + " WHERE "
                    + "c.id_fornecedor = f.id AND "
                    + "c.id_produto = p.id AND "
                    + "c.id_comprador = u.id AND "
                    + "c.id = ?";
            
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                compra.setDataCompra(rs.getString("c.data_compra"));
                compra.setIdFornecedor(rs.getInt("c.id_fornecedor"));
                compra.setId(rs.getInt("c.id"));
                compra.setIdProduto(rs.getInt("c.id_produto"));
                compra.setIdComprador(rs.getInt("c.id_comprador"));
                compra.setRazaoSocialFornecedor(rs.getString("f.razao_social"));
                compra.setNomeProduto(rs.getString("p.nome_produto"));
                compra.setNomeComprador(rs.getString("u.nome"));
                compra.setQuantidadeCompra(rs.getInt("c.quantidade_compra"));
                compra.setValorCompra(rs.getDouble("c.valor_compra"));
            }
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return compra;
    }
    
}
