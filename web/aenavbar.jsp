<!-- Barra de navagação da área restrita - Usuário vendedor -->
<nav class="navbar navbar-expand-lg">
  <div class="container">
    <a class="navbar-brand" href="#">
        <img src="assets/imagens/logo.png" alt="Logo OrangePDV" width="92" class="d-inline-block align-top">
    </a>
      
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
      
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto d-flex align-items-center mb-2 mb-lg-0">
            <li class="nav-item mx-2">
                <a class="nav-link text-dark" href="aeprodutos.jsp">Produtos</a>
            </li>
            <li class="nav-item mx-2">
                <a class="nav-link text-dark" href="aevendas.jsp">Vendas</a>
            </li>
            <li class="nav-item mx-2">
                <a class="nav-link text-dark" href="aeclientes.jsp">Clientes</a>
            </li>
            <li class="nav-item ms-2">
                <form method="POST" action="UsuariosController">
                    <input type="hidden" name="acao" value="logout" required>
                    <button type="submit" class="btn btn-danger">Sair</button>
                </form>
                    
                </a>
            </li>
        </ul>
    </div>
  </div>
</nav>