


// LOGICA
window.addEventListener("load", cargarCarrito);
window.addEventListener("load", UPDATE_DISPLAY);


var carrito = null;

function cargarCarrito() {
    if (carrito === null) { // Si no hemos cargado todavía el carrito
        // Cargamos el carrito almacenado
        carrito = JSON.parse(localStorage.getItem("mi-carrito-almacenado"));
        if (carrito === null) { // Si no existía carrito almacenado
            carrito = []; // Creamos un array list vacío
        }
    }
}

function guardarCarrito() {
    localStorage.setItem("mi-carrito-almacenado", JSON.stringify(carrito));
}


function crearObjetoCarrito(codigo, nombre, cantidad, precio, url_imagen) {

    return {
        codigo: codigo,
        nombre: nombre,
        cantidad: cantidad,
        precio: precio,
        url_imagen: url_imagen
    };
}

function eliminarProducto(codigo, standalone=true) {
    for (var i = 0; i < carrito.length; i++) {
        if (carrito[i].codigo === codigo) {
            carrito.splice(i, 1);
            break;
        }
    }
    if(standalone){
        guardarCarrito();
        UPDATE_DISPLAY();
    }

}

function agregarProducto(codigo, nombre, cantidad, precio, url_imagen) { //TODO change header to (codigo, cantidad)
    //TODO deal with DB, like get precio, nombre from DB, and check if cantidad is available


    // check if product is already in cart
    var found = false;
    for (var i = 0; i < carrito.length; i++) {
        if (carrito[i].codigo === codigo) {
            carrito[i].cantidad = parseInt(cantidad) + parseInt( carrito[i].cantidad) ;
            cantidad = carrito[i].cantidad;
            if (carrito[i].cantidad < 0) {
                eliminarProducto(codigo, false);
            }
            found = true;
            break;
        }
    }
    if (!found) {
        carrito.push(crearObjetoCarrito(codigo, nombre, cantidad, precio, url_imagen));
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

// VISUAL
function notifPersonalizada(nombre, cantidad) {
    var message = "Se ha añadido " + cantidad + " " + nombre + " al carrito.";
    var type = "secondary";

    // Create notification div
    notificationALert(message, type);
}

function UPDATE_DISPLAY() {
    displayCarrito();
    resumenCarrito_UPDATE();
}

function resumenCarrito_UPDATE() {

    // infomaticion de carrito
    var total_precio_producto = 0;
    var total_cantidad = 0;
    for (var i = 0; i < carrito.length; i++) {
        total_precio_producto += carrito[i].precio * carrito[i].cantidad;
        total_cantidad += carrito[i].cantidad;
    }

    var precio_entrega = 10; //TODO change to dynamic value
    var total = total_precio_producto + precio_entrega;

    // mostrar en pantalla

    document.getElementById("total_precio_producto").innerText = total_precio_producto + "€"   ;
    document.getElementById("total_cantidad").innerText = total_cantidad ; 
    document.getElementById("precio_entrega").innerText = precio_entrega + "€";
    document.getElementById("total_precio").innerText = total + "€";
    document.getElementById("btn_comprar").disabled = total_cantidad === 0 ; //disable button if no products in cart
}


function displayCarrito(){
    function template_producto_en_carrito(codigo, nombre, cantidad, precio, url_imagen) {
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
            </div>` ;
        }

    var carrito_display = "";
    for (var i = 0; i < carrito.length; i++) {
        carrito_display += template_producto_en_carrito(carrito[i].codigo, carrito[i].nombre, carrito[i].cantidad, carrito[i].precio, carrito[i].url_imagen);
    }
    if (carrito.length === 0) {
        carrito_display = "<h2 class=\"text-center\" >Carrito Vacio</h2>";
    }
    document.getElementById("body_carrito_display").innerHTML = carrito_display;
}
