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
    
    public ArrayList<Compras> getCompraPesquisa(String nomeFornecedor) {
        ArrayList<Compras> compras = new ArrayList<>();
        
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
                    + "f.razao_social LIKE ?"
                    + "ORDER BY c.id";
            
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, '%' + nomeFornecedor + '%');
            
            ResultSet rs = ps.executeQuery();
            
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
    
    public boolean excluir(int id) {
        try {
            String sql = "DELETE FROM compras WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            return false;
        }
    }
    
    public boolean gravar(Compras compra) {
        
        try {
            String sql, sqlAtualizarProduto;
            
            if (compra.getId() == 0) {
                //String para inserir compra
                sql = "INSERT INTO compras "
                        + "(quantidade_compra, data_compra, valor_compra, id_fornecedor, id_produto, id_comprador) "
                        + "VALUES (?, ?, ?, ?, ?, ?)";
            } else {
                //String para atualizar compra
                sql = "UPDATE compras SET "
                        + "quantidade_compra=?, data_compra=?, valor_compra=?, id_fornecedor=?, id_produto=?, id_comprador=? "
                        + "WHERE id=?";
            }
            
            //Preparando string de inserção/atualização
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, compra.getQuantidadeCompra());
            ps.setString(2, compra.getDataCompra());
            ps.setDouble(3, compra.getValorCompra());
            ps.setInt(4, compra.getIdFornecedor());
            ps.setInt(5, compra.getIdProduto());
            ps.setInt(6, compra.getIdComprador());
            
            //Se for atualização, inserir o sétimo parâmetro
            if (compra.getId() > 0)
                ps.setInt(7, compra.getId());
            
            //Executando inserção/atualização
            ps.execute();
            
            //Atualizar a quantidade/preço do produto
            //String para pegar quantidade disponível do produto
            String sqlQuantidadeDisponivel = "SELECT quantidade_disponível FROM produtos WHERE id=?";
            PreparedStatement psQuantidadeDisponivel = conexao.prepareStatement(sqlQuantidadeDisponivel);  
            psQuantidadeDisponivel.setInt(1, compra.getIdProduto());
            ResultSet rs = psQuantidadeDisponivel.executeQuery();

            //String para atualizar quantidade disponível do produto
            sqlAtualizarProduto = "UPDATE produtos SET "
                    +"quantidade_disponível=?, "
                    +"preco_compra=? "
                    +"WHERE id=?";

            if (rs.next()) {
                int quantidadeDisponivel = rs.getInt("quantidade_disponível");
                PreparedStatement psAtualizarProduto = conexao.prepareStatement(sqlAtualizarProduto);

                //Atualizando quantidade disponivel com a quantidade disponivel atual mais a quantidade comprada
                psAtualizarProduto.setInt(1, quantidadeDisponivel + compra.getQuantidadeCompra());
                psAtualizarProduto.setDouble(2, (compra.getValorCompra() / compra.getQuantidadeCompra()));
                psAtualizarProduto.setInt(3, compra.getIdProduto());
                psAtualizarProduto.execute();
            }
            
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            
            return false;
        }
        
    }
    
}
