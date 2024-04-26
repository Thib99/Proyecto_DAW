window.addEventListener("load", cargarCarrito);
window.addEventListener("load", UPDATE_DISPLAY);

// LOGICA

var carrito = null;

function cargarCarrito() {
  if (carrito === null) {
    // Si no hemos cargado todavía el carrito
    // Cargamos el carrito almacenado
    carrito = JSON.parse(localStorage.getItem("mi-carrito-almacenado"));
    if (carrito === null) {
      // Si no existía carrito almacenado
      carrito = []; // Creamos un array list vacío
    }
  }
}

function guardarCarrito() {
  localStorage.setItem("mi-carrito-almacenado", JSON.stringify(carrito));
}

function crearObjetoCarrito(codigo, nombre, cantidad, precio, url_imagen) {
  return {
    codigo: parseInt(codigo),
    nombre: nombre,
    cantidad: parseInt(cantidad),
    precio: parseFloat(precio),
    url_imagen: url_imagen,
  };
}

function eliminarProducto(codigo, standalone = true) {
  for (var i = 0; i < carrito.length; i++) {
    if (carrito[i].codigo === codigo) {
      carrito.splice(i, 1);
      break;
    }
  }
  if (standalone) {
    guardarCarrito();
    UPDATE_DISPLAY();
  }
}

function agregarProducto(codigo, nombre, cantidad, precio, url_imagen) {
  // check if product is already in cart
  var found = false;
  for (var i = 0; i < carrito.length; i++) {
    if (carrito[i].codigo === codigo) {
      carrito[i].cantidad = parseInt(
        parseInt(cantidad) + parseInt(carrito[i].cantidad)
      );
      cantidad = carrito[i].cantidad;
      if (carrito[i].cantidad < 0) {
        eliminarProducto(codigo, false);
      }
      found = true;
      break;
    }
  }
  if (!found) {
    carrito.push(
      crearObjetoCarrito(codigo, nombre, cantidad, precio, url_imagen)
    );
  }
  guardarCarrito();

  notifPersonalizada(nombre, cantidad);
}

function handleSelectChangeProducto(event, codigo) {
  var cantidad = parseInt(event.target.value);
  for (var i = 0; i < carrito.length; i++) {
    if (carrito[i].codigo === codigo) {
      carrito[i].cantidad = cantidad;
      break;
    }
  }
  guardarCarrito();
  UPDATE_DISPLAY();
}

function eliminarCarrito() {
  carrito = [];
  guardarCarrito();
}

function modifiedData(responce, anadir_data = false) {
  var change_carrito = false;
  var to_remove = [];

  for (product_carrito of carrito) {
    var found = false;
    for (product_BD of responce) {
      if (product_carrito.codigo == product_BD.codigo) {
        found = true;
        if (product_BD.cantidad <= 0) {
          to_remove.push(product_BD.codigo);
          change_carrito = true;
          found = true;
          break;
        } else if (product_BD.cantidad < product_carrito.cantidad) {
          product_carrito.cantidad = product_BD.cantidad;
          change_carrito = true;
        }

        product_carrito.precio = product_BD.precio;

        if (anadir_data) {
          product_carrito.nombre = product_BD.nombre;
          product_carrito.url_imagen = product_BD.url_imagen;
        }
        break;
      }
    }
    // if it arrive here, the product is not in the database anymore
    if (!found) {
      to_remove.push(product_carrito.codigo);
      change_carrito = true;
    }
  }
  for (var i = 0; i < to_remove.length; i++) {
    eliminarProducto(to_remove[i], false);
  }
  guardarCarrito();

  if (change_carrito) {
    notificationALert(
      "Algunos productos no estan disponibles en la cantidad deseada",
      "warning",
      5
    );
  }
  if (!anadir_data && !change_carrito) {
    //means that all is go and we are going to payment
    goToPayment();
  }

  UPDATE_DISPLAY();
}

function getProductInfo(anadir_data = false) {
  const url = "api/obtenerproductos";
  conexion = nuevaConexion();
  conexion.open("POST", url, true);
  conexion.onreadystatechange = function () {
    if (conexion.readyState == 4) {
      if (conexion.status == 200) {
        // write responce here
        var responce = JSON.parse(conexion.responseText);
        modifiedData(responce, anadir_data);
      } else {
        notificationALert("Error al recuperar los productos", "danger");
      }
    }
  };
  conexion.setRequestHeader("Content-Type", "application/json; charset=utf-8");

  var id_productos = [];
  for (product of carrito) {
    id_productos.push(product.codigo);
  }

  conexion.send(JSON.stringify(id_productos));
}

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

// VISUAL
function notifPersonalizada(nombre, cantidad) {
  var message = "Se ha añadido " + cantidad + " " + nombre + " al carrito.";
  var type = "info";

  // Create notification div
  notificationALert(message, type);
}

function UPDATE_DISPLAY() {
  if (document.getElementById("body_carrito_display") !== null) {
    //otherwise means that we are not in the code page
    displayCarrito();
  }
  if (document.getElementById("total_precio_producto") !== null) {
    resumenCarrito_UPDATE();
  }
}

function resumenCarrito_UPDATE() {
  // infomaticion de carrito
  var total_precio_producto = 0;
  var total_cantidad = 0;
  for (var i = 0; i < carrito.length; i++) {
    total_precio_producto += carrito[i].precio * carrito[i].cantidad;
    total_cantidad += parseInt(carrito[i].cantidad);
  }

  var precio_entrega = 0; //Envio Gratis
  var total = total_precio_producto + precio_entrega;

  // mostrar en pantalla

  document.getElementById("total_precio_producto").innerText =
    total_precio_producto + "€";
  document.getElementById("total_cantidad").innerText = total_cantidad;
  document.getElementById("precio_entrega").innerText = precio_entrega + "€";
  document.getElementById("total_precio").innerText = total + "€";
  document.getElementById("btn_comprar").disabled = total_cantidad === 0; //disable button if no products in cart
}

function displayCarrito() {
  function template_producto_en_carrito(
    codigo,
    nombre,
    cantidad,
    precio,
    url_imagen
  ) {
    var option = "";
    for (let i = 1; i <= Math.max(cantidad, 10); i++) {
      if (i === cantidad) {
        option += `<option value="${i}" selected>${i}</option>`;
      } else {
        option += `<option value="${i}">${i}</option>`;
      }
    }

    return `
            <div class="card border-dark my-2">
                <div class="row g-0">
                    <div class="col-4 d-flex align-content-around">
                        <img src="${url_imagen}" class="img-fluid rounded-start" alt="...">
                    </div>
                    <div class="col-8">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <h4 class="card-title">${nombre}</h4>

                            <div class="d-flex justify-content-start">
                                <h6 class="card-text">Precio : </h6>
                                <h6 class="card-text" id="price">${precio}€</h6>
                            </div>
                    

                                <div class="row d-flex justify-content-end" style="display: inline-block;">
                                    <div class="input-group">
                                        
                                        <span class="input-group-text">Cantidad</span>
                                        <select class="form-select form-select-sm text-center" name="select_quantidad" onchange="handleSelectChangeProducto(event, ${codigo})" >
                                            ${option}
                                        </select>
                                    
                                        <button type="button" class="btn btn-danger" name="delete_item" onclick=" eliminarProducto(${codigo});"><span
                                            class="p-1"><i class="bi bi-trash"></i></span>
                                        </button>
                                    </div>
                                    
                                
                                </div>


                        </div>
                    </div>
                </div>
            </div>`;
  }
  var carrito_display = "";
  if (carrito.length === 0) {
    carrito_display = '<h2 class="text-center" >Carrito Vacio</h2>';
  } else {
    if (carrito[0].nombre === undefined) {
      getProductInfo(true);
    }

    for (var i = 0; i < carrito.length; i++) {
      carrito_display += template_producto_en_carrito(
        carrito[i].codigo,
        carrito[i].nombre,
        carrito[i].cantidad,
        carrito[i].precio,
        carrito[i].url_imagen
      );
    }
  }
  document.getElementById("body_carrito_display").innerHTML = carrito_display;
}

function goToPayment() {
  // add some test or other things

  window.location.href = "pago.jsp";
}

// to unsure that the cart is updated in all tabs
window.addEventListener("storage", procesar, false);

function procesar(event) {
  event = event || window.event; // para IE8
  var modifiedValueName = event.key;
  if (modifiedValueName === "mi-carrito-almacenado") {
    carrito = JSON.parse(event.newValue);
    UPDATE_DISPLAY();
  }
}
