<!-- Mensagens -->
            
<div class="toast align-items-center my-3" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
        <div class="toast-body">
            <span id="mensagem">
                <%= request.getAttribute("mensagem") %>
            </span>
        </div>
        <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
</div>