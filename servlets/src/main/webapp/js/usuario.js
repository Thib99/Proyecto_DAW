// Need to be call with the direct link to the form
// and optionnal the writable status as a boolean
function change_readonly(form) {
  // get all the input field in this form
  let inputs = form.getElementsByTagName("input");

  for (let i = 0; i < inputs.length; i++) {
    // if writable is true, remove the readonly attribute and add the form-control class to the input
    inputs[i].readOnly = !inputs[i].readOnly;
    if (!inputs[i].readOnly) {
      inputs[i].classList.remove("form-control-plaintext");
      inputs[i].classList.add("form-control");
    } else {
      inputs[i].classList.remove("form-control");
      inputs[i].classList.add("form-control-plaintext");
    }
  }

  if (inputs[0].readOnly) {
    form.getElementsByTagName("button")[0].innerHTML =
      'Cambiar datos <i class="bi bi-lock-fill"></i>';
  } else {
    form.getElementsByTagName("button")[0].innerHTML =
      'Cambiar datos <i class="bi bi-unlock"></i>';
  }
}

// to change the info in the card body, when pressing a tab
function change_data_card(tab) {
  let content = document.getElementById("content_block");

  // get all the tab option
  let nav_option = document
    .getElementById("nav-datos")
    .getElementsByTagName("a");
  let content_section = content.getElementsByTagName("section");

  // remove the active class from all the tab
  for (let i = 0; i < nav_option.length; i++) {
    nav_option[i].classList.remove("active");
    content_section[i].classList.add("d-none");
  }

  //append the content to the card
  switch (tab) {
    case "datos":
      document.getElementById("datos").classList.remove("d-none");
      nav_option[0].classList.add("active");
      break;
    case "pedidos":
      document.getElementById("pedidos").classList.remove("d-none");
      nav_option[1].classList.add("active");
      break;
    case "tarjetas":
      document.getElementById("tarjetas").classList.remove("d-none");
      nav_option[2].classList.add("active");
      break;
    case "contrasena":
      document.getElementById("cambiar_contrasena").classList.remove("d-none");
      nav_option[3].classList.add("active");
      break;
  }

  return;
}

function get_tab() {
  let url = window.location.href;
  let tab = url.split("#")[1];
  if (tab === undefined) {
    tab = "datos";
  }
  change_data_card(tab);
}

// by default show the mis-datos tab
window.addEventListener("load", get_tab);

// pedir de nuevo

function pedir_de_nuevo(idPedido) {
  var table_pedido = document.getElementById("table_" + idPedido);
  var detalle = [];

  for (var i = 1; i < table_pedido.rows.length; i++) {
    var row = table_pedido.rows[i];
    var codigo = row.cells[0].innerText;
    var cantidad = row.cells[3].innerText;
    detalle.push(crearObjetoCarritoSimple(codigo, cantidad));
  }

  carrito = detalle;
  guardarCarrito();
  location.href = "carrito.jsp";

  // inside function
  function crearObjetoCarritoSimple(codigo, cantidad) {
    return {
      codigo: parseInt(codigo),
      cantidad: parseInt(cantidad),
    };
  }
}
