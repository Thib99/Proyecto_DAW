function nuevaConexion() {
  var xmlhttp = false;
  try {
    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
  } catch (e) {
    try {
      xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (E) {
      xmlhttp = false;
    }
  }
  if (!xmlhttp && typeof XMLHttpRequest != "undefined") {
    xmlhttp = new XMLHttpRequest();
  }
  return xmlhttp;
}

function checkIfCard() {
  var formCard = document.getElementById("form_tarjeta");
  var creditCard = formCard["creditCard"];

  if (creditCard !== undefined) {
    return true;
  } else {
    return false;
  }
}

function EnviarCarrito() {
  if (checkIfCard()) {
    cargarCarrito();
    const carrito_JSON = JSON.stringify(carrito);
    EnviarData("form/NuevoPedido", carrito_JSON); // transforming the object to avoid inteference with the delete function
  } else {
    notificationALert("Por favor ingrese una tarjeta", "danger");
  }
}

function EnviarData(url, valores) {
  conexion = nuevaConexion();
  conexion.open("POST", url, true);
  conexion.onreadystatechange = function () {
    if (conexion.readyState == 4) {
      if (conexion.status == 200) {
        // write responce here
        var responce_json = JSON.parse(conexion.responseText);
        if ("error" in responce_json) {
          notificationALert(responce_json.error, "danger");
        }
        if ("id_pedido" in responce_json) {
          eliminarCarrito();
          sessionStorage.setItem("id_pedido", responce_json.id_pedido);
          window.location.href = "pagorealizado.jsp";
        }
      } else {
        notificationALert("Error al enviar del pedido", "danger");
      }
    }
  };
  conexion.setRequestHeader("Content-Type", "application/json; charset=utf-8");

  conexion.send(valores);
}
