package model;

import aplicacao.Categorias;
import aplicacao.Produtos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(name = "ProdutosDAO", urlPatterns = {"/ProdutosDAO"})
public class ProdutosDAO extends HttpServlet {

    private Connection conexao;
    
    public ProdutosDAO(){
        try {
            conexao = Conexao.criaConexao();
        } catch (SQLException ex) {
            System.out.println("Erro na criação da conexao DAO: " + ex.getMessage());
        }
    }
    
    public ArrayList<Produtos> getProdutos() {
        ArrayList<Produtos> produtos = new ArrayList<>();
        
        try {
            Statement stmt = conexao.createStatement();

            ResultSet rs = stmt.executeQuery("SELECT * FROM produtos ORDER BY nome_produto");

            while (rs.next()) {

                Produtos produto = new Produtos();

                produto.setId(rs.getInt("id"));
                produto.setNomeProduto(rs.getString("nome_produto"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPrecoCompra(rs.getDouble("preco_compra"));
                produto.setPrecoVenda(rs.getDouble("preco_venda"));
                produto.setQuantidadeDisponivel(rs.getInt("quantidade_disponível"));
                produto.setLiberadoVenda(rs.getString("liberado_venda"));
                produto.setIdCategoria(rs.getInt("id_categoria"));

                produtos.add(produto);   
            }


        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
            
        return produtos;
    }
        
    public ArrayList<Produtos> getNomeProduto(String nomeProduto) {
        ArrayList<Produtos> produtos = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM produtos WHERE nome_produto LIKE ? ORDER BY nome_produto";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, '%' + nomeProduto + '%');

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Produtos produto = new Produtos();

                produto.setId(rs.getInt("id"));
                produto.setNomeProduto(rs.getString("nome_produto"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPrecoCompra(rs.getDouble("preco_compra"));
                produto.setPrecoVenda(rs.getDouble("preco_venda"));
                produto.setQuantidadeDisponivel(rs.getInt("quantidade_disponível"));
                produto.setLiberadoVenda(rs.getString("liberado_venda"));
                produto.setIdCategoria(rs.getInt("id_categoria"));

                produtos.add(produto);   
            }

        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }

        return produtos;
    }
        
    public Produtos getProdutoID(int id) {
        Produtos produto = new Produtos();
        CategoriasDAO daoCategorias = new CategoriasDAO();
        
        try {
            String sql = "SELECT * FROM produtos WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Categorias categoria = daoCategorias.getCategoriaID(rs.getInt("id_categoria"));
                
                produto.setId(rs.getInt("id"));
                produto.setNomeProduto(rs.getString("nome_produto"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setPrecoCompra(rs.getDouble("preco_compra"));
                produto.setPrecoVenda(rs.getDouble("preco_venda"));
                produto.setQuantidadeDisponivel(rs.getInt("quantidade_disponível"));
                produto.setLiberadoVenda(rs.getString("liberado_venda"));
                produto.setIdCategoria(rs.getInt("id_categoria"));
                produto.setNomeCategoria(categoria.getNomeCategoria());
            }
                    
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
        }
        
        return produto;
    }
    
    public boolean excluir(int id) {
        try {
            String sql = "DELETE FROM produtos WHERE id = ?";
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setInt(1, id);
            ps.execute();
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            return false;
        }
    }
    
    public boolean gravar(Produtos produto) {
        
        try {
            String sql;
            
            if (produto.getId() == 0) {
                //String para inserir produto
                sql = "INSERT INTO produtos "
                        + "(nome_produto, descricao, preco_compra, preco_venda, quantidade_disponível, liberado_venda, id_categoria) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            } else {
                //String para atualizar produto
                sql = "UPDATE produtos SET "
                        + "nome_produto=?, descricao=?, preco_compra=?, preco_venda=?, quantidade_disponível=?, liberado_venda=?, id_categoria=? "
                        + "WHERE id=?";
            }
            
            //Preparando string de inserção/atualização
            PreparedStatement ps = conexao.prepareStatement(sql);
            ps.setString(1, produto.getNomeProduto());
            ps.setString(2, produto.getDescricao());
            ps.setDouble(3, produto.getPrecoCompra());
            ps.setDouble(4, produto.getPrecoVenda());
            ps.setInt(5, produto.getQuantidadeDisponivel());
            ps.setString(6, produto.getLiberadoVenda());
            ps.setInt(7, produto.getIdCategoria());
            
            //Se for atualização, inserir o oitavo parâmetro
            if (produto.getId() > 0)
                ps.setInt(8, produto.getId());
            
            //Executando inserção/atualização
            ps.execute();            
            
            return true;
            
        } catch (SQLException ex) {
            System.out.println("Erro de SQL: " + ex.getMessage());
            
            return false;
        }
    }

}
