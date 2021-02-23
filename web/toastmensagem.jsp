<!-- Mensagens  -->
                
<div aria-live="polite" aria-atomic="true" class="position-relative">
    <div class="toast-container position-absolute top-0 end-0">
        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <span id="mensagem">
                        <%= request.getAttribute("mensagem") %>
                    </span>
                </div>
                <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
</div>