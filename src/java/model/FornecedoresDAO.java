package model;

import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(name = "FornecedoresDAO", urlPatterns = {"/FornecedoresDAO"})
public class FornecedoresDAO extends HttpServlet {

    private Connection conexao;
    
    public FornecedoresDAO() {
        try {
            conexao = Conexao.criaConexao();
        } catch (SQLException ex) {
            System.out.println("Erro na criação da conexao DAO: " + ex.getMessage());
        }
    }

}
