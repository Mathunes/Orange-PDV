package aplicacao;

public class Produtos {
    
    private int id;
    private String nomeProduto;
    private String descricao;
    private double precoCompra;
    private double precoVenda;
    private int quantidadeDisponivel;
    private char liberadoVenda;
    private int idCategoria;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNomeProduto() {
        return nomeProduto;
    }

    public void setNomeProduto(String nomeProduto) {
        this.nomeProduto = nomeProduto;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public double getPrecoCompra() {
        return precoCompra;
    }

    public void setPrecoCompra(double precoCompra) {
        this.precoCompra = precoCompra;
    }

    public double getPrecoVenda() {
        return precoVenda;
    }

    public void setPrecoVenda(double precoVenda) {
        this.precoVenda = precoVenda;
    }

    public int getQuantidadeDisponivel() {
        return quantidadeDisponivel;
    }

    public void setQuantidadeDisponivel(int quantidadeDisponivel) {
        this.quantidadeDisponivel = quantidadeDisponivel;
    }

    public char getLiberadoVenda() {
        return liberadoVenda;
    }

    public void setLiberadoVenda(char liberadoVenda) {
        this.liberadoVenda = liberadoVenda;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public Produtos(int id, String nomeProduto, String descricao, double precoCompra, double precoVenda, int quantidadeDisponivel, char liberadoVenda, int idCategoria) {
        this.id = id;
        this.nomeProduto = nomeProduto;
        this.descricao = descricao;
        this.precoCompra = precoCompra;
        this.precoVenda = precoVenda;
        this.quantidadeDisponivel = quantidadeDisponivel;
        this.liberadoVenda = liberadoVenda;
        this.idCategoria = idCategoria;
    }
    
}
