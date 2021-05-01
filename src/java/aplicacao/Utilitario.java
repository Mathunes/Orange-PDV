package aplicacao;

public class Utilitario {
    
    public static String formataData(String data) {
        
        String[] dt = data.split("-");        
        
        return dt[2] + "-" + dt[1] + "-" + dt[0];
    }
}