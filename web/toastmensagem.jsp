<!-- Mensagens  -->
                
<div aria-live="polite" aria-atomic="true" class="d-flex justify-content-center w-100 position-absolute top-0 end-0 mt-2">
    <div class="toast-container">
        <div class="toast text-white bg-info" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    <span id="mensagem">
                        <%= request.getAttribute("mensagem") %>
                    </span>
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
</div>