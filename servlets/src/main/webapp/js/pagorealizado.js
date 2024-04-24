window.addEventListener("load", display_idPedido);


function display_idPedido() {
    var idPedido = sessionStorage.getItem("id_pedido");
    if (idPedido !== null) {
        document.getElementById("id_pedido").innerText = idPedido;
    }
}