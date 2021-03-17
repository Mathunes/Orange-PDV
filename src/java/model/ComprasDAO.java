package model;

import java.sql.Connection;
import java.sql.SQLException;
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
    
}
