function invokeScript(divid) {
	var scriptObj = divid.getElementsByTagName("SCRIPT");
	var len = scriptObj.length;
	for (var i = 0; i < len; i++) {
		var scriptText = scriptObj[i].text;
		var scriptFile = scriptObj[i].src
		var scriptTag = document.createElement("SCRIPT");
		if ((scriptFile != null) && (scriptFile != "")) {
			scriptTag.src = scriptFile;
		}
		scriptTag.text = scriptText;
		if (!document.getElementsByTagName("HEAD")[0]) {
			document.createElement("HEAD").appendChild(scriptTag)
		}
		else {
			document.getElementsByTagName("HEAD")[0].appendChild(scriptTag);
		}
	}
}

function nuevaConexion() {
	var xmlhttp = false;
	try {
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	}
	catch (e) {
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		catch (E) {
			xmlhttp = false;
		}
	}
	if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
		xmlhttp = new XMLHttpRequest();
	}
	return xmlhttp;
}

function prepCarrito(){
    for (var i = 0; i < carrito.length; i++) {
        if (carrito[i].codigo === codigo) {
            carrito.splice(i, 1);
            break;
        }
    }
}


function EnviarCarrito(){
    cargarCarrito() ;
    
    EnviarData("form/NuevoPedido", carrito);
    console.log("Carrito enviado");
    console.log(carrito);
}


function EnviarData(url, valores) {
	conexion = nuevaConexion();
	conexion.open("POST", url, true);
	conexion.onreadystatechange = function () {
		if ((conexion.readyState == 4) && (conexion.status == 200)) {
            // write responce here
            notificationALert("Producto send", "success");
		}else{
            notificationALert("Error al enviar el producto", "danger");
        }
	}
    conexion.setRequestHeader('Content-Type', 'application/json; charset=utf-8');



	conexion.send(JSON.stringify(valores));
}