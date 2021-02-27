package model;

import aplicacao.Produtos;
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


                System.out.println(produtos);

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


                System.out.println(produtos);

            } catch (SQLException ex) {
                System.out.println("Erro de SQL: " + ex.getMessage());
            }

            return produtos;
        }


}
