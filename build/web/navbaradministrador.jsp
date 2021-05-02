<!-- Barra de navaga��o da �rea restrita - Usu�rio administrador -->
<nav class="navbar navbar-expand-lg mb-4 navbar-light">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="assets/imagens/logo.png" alt="Logo OrangePDV" width="92" class="d-inline-block align-top">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navmenu" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navmenu">
            <ul class="navbar-nav ms-auto d-flex mb-2 mb-lg-0">
                <li class="nav-item mx-2">
                    <a class="nav-link text-dark" href="UsuariosController?acao=mostrar_usuarios">Usu�rios</a>
                </li>
                <li class="nav-item mx-2">
                    <a class="nav-link text-dark" href="ProdutosController?acaoRestrito=mostrar_produtos_restrito_adm">Relat�rio de estoque</a>
                </li>
                <li class="nav-item mx-2">
                    <a class="nav-link text-dark" href="VendasController?acao=mostrar_vendas_adm">Relat�rio de vendas</a>
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