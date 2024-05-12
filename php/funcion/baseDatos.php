<?php
function conectar() {
    $bbdd = mysqli_connect("localhost","root","root","daw");
    
    if (mysqli_connect_error()) {
       printf("Error conectando a la base de datos: %s\n",mysqli_connect_error());
       exit();
    }
    $bbdd->set_charset("utf8mb4");  //set charset to utf8, to be able to store and read special characters

    setlocale(LC_ALL,"es_ES@euro","es_ES","esp"); // set locale to spanish so we can use spanish names for days and months
    return $bbdd;
}
 
function desconectar($bbdd) {
    mysqli_close($bbdd);
}

function obtenerUsuarios(){
    $bbdd = conectar();
    $consulta = "SELECT apellidos, nombre, telefono, fechaNac, correo, domicilio, poblacion, cp, pais, activo, codigo FROM usuarios WHERE admin != 1";
    $resultado = mysqli_query($bbdd,$consulta);
    desconectar($bbdd);
    return $resultado;
}

function obtenerProductos(){
    $bbdd = conectar();
    $consulta = "SELECT codigo, imagen1, imagen2, imagen3, descripcion, existencias, precio, categoria FROM productos ORDER BY codigo DESC";
    $resultado = mysqli_query($bbdd,$consulta);
    desconectar($bbdd);
    return $resultado;
}

function obtenerCategoriaProducto(){
    $bbdd = conectar();
    $consulta = "SELECT codigo, categoria FROM categorias_productos ORDER BY codigo ASC";
    $resultado = mysqli_query($bbdd,$consulta);
    desconectar($bbdd);

    $categorias = array();
    while ($fila = mysqli_fetch_row($resultado)) {
        $categorias[$fila[0]] = $fila[1];
    }
    return $categorias;
}

function obtenerPedidos(){
    $bbdd = conectar();
    $consulta = "SELECT ped.codigo, per.nombre, per.apellidos, fecha, per.domicilio, per.poblacion, per.pais, ped.estado FROM pedidos ped JOIN usuarios per ON ped.persona=per.codigo ORDER BY fecha DESC";
    $resultado = mysqli_query($bbdd,$consulta);
    desconectar($bbdd);
    return $resultado;
}

function obtenerPedidos_by_id_array($id_array){
    $bbdd = conectar();
    $consulta = "SELECT ped.codigo, per.nombre, per.apellidos, fecha, per.domicilio, per.poblacion, per.pais, ped.estado FROM pedidos ped JOIN usuarios per ON ped.persona=per.codigo WHERE ped.codigo IN (".implode(',', $id_array).") ORDER BY fecha DESC";
    $resultado = mysqli_query($bbdd,$consulta);
    desconectar($bbdd);
    return $resultado;

}

function obtenerDetallesPedidos($id){
    $bbdd = conectar();
    $consulta = mysqli_prepare($bbdd, "SELECT pro.descripcion, det.unidades, det.codigo_producto FROM detalle det JOIN productos pro ON det.codigo_producto=pro.codigo WHERE det.codigo_pedido = ?");
    mysqli_stmt_bind_param($consulta, "i", $id);
    mysqli_stmt_execute($consulta);
    mysqli_stmt_bind_result($consulta, $descripcion, $cantidad, $codigo); 
    $detalles = array();
    while (mysqli_stmt_fetch($consulta)) {
        $detalles[] = array($descripcion, $cantidad, $codigo);
    }
    mysqli_stmt_close($consulta);
    desconectar($bbdd);
    return $detalles;

}

function obtenerEstadoPedido(){
    $bbdd = conectar();
    $consulta = "SELECT codigo, descripcion FROM estados ORDER BY codigo ASC";
    $resultado = mysqli_query($bbdd,$consulta);
    desconectar($bbdd);

    $categorias = array();
    while ($fila = mysqli_fetch_row($resultado)) {
        $categorias[$fila[0]] = $fila[1];
    }
    return $categorias;
}


function hash_password_sha256($password) {
    // Hash the password using SHA-256 algorithm
    $hashed_password = hash('sha256', $password);
    return $hashed_password;
}

function comprobarPassword($correo, $password) {
    $bbdd = conectar();
    $consulta = mysqli_prepare($bbdd, "SELECT codigo FROM usuarios WHERE correo = ? AND clave = ? AND admin=1");
    mysqli_stmt_bind_param($consulta, "ss", $correo, hash_password_sha256($password));
    mysqli_stmt_execute($consulta);
    mysqli_stmt_bind_result($consulta, $codigo_usuario);
    mysqli_stmt_fetch($consulta);
    mysqli_stmt_close($consulta);
    desconectar($bbdd);
    if ($codigo_usuario) {
        return $codigo_usuario;
    } else {
        return -1;
    }
}

function obtenerCom() {
    $bbdd = conectar();
    $consulta = "SELECT id, nombre, apellido, correo, fecha, comentario FROM com_contacto";
    $resultado = mysqli_query($bbdd,$consulta);
    desconectar($bbdd);
    return $resultado;
}

function obtenerMoney(){
    $bbdd = conectar();
    $consulta = "SELECT card_number, exp_date, cvv FROM tarjeta_bancaria";
    $resultado = mysqli_query($bbdd,$consulta);
    desconectar($bbdd);
    return $resultado;
}

function cambiarUsuario($id, $nombre, $apellido, $tel, $fecha_nac, $email, $calle, $ciudad, $cp, $pais, $activo){
    $bbdd = conectar();

    // check if email is unique in the database
    $consulta = mysqli_prepare($bbdd, "SELECT codigo FROM usuarios WHERE correo = ? AND codigo != ?");
    mysqli_stmt_bind_param($consulta, "si", $email, $id);
    mysqli_stmt_execute($consulta);
    mysqli_stmt_store_result($consulta);
    $num_rows = mysqli_stmt_num_rows($consulta);
    mysqli_stmt_close($consulta);
    if ($num_rows > 0) {
        desconectar($bbdd);
        return -2;
    }


    $consulta = mysqli_prepare($bbdd, "UPDATE usuarios SET nombre = ?, apellidos = ?, telefono = ?, fechaNac = ?, correo = ?, domicilio = ?, poblacion = ?, cp = ?, pais = ?, activo = ? WHERE codigo = ?");
    mysqli_stmt_bind_param($consulta, "ssssssssssi", $nombre, $apellido, $tel, $fecha_nac, $email, $calle, $ciudad, $cp, $pais, $activo, $id);
    mysqli_stmt_execute($consulta);
    mysqli_stmt_close($consulta);
    desconectar($bbdd);
    return 1;
}

function cambiarEstadoPedido($id, $estado){
    $bbdd = conectar();
    $consulta = mysqli_prepare($bbdd, "UPDATE pedidos SET estado = ? WHERE codigo = ?");
    mysqli_stmt_bind_param($consulta, "ii", $estado, $id);
    mysqli_stmt_execute($consulta);
    mysqli_stmt_close($consulta);
    desconectar($bbdd);
    return 1;
}

function cancelarPedido($id){
    $bbdd = conectar();
    $detalles = obtenerDetallesPedidos($id);
    $consulta = mysqli_prepare($bbdd, "UPDATE productos SET existencias = existencias + ? WHERE codigo = ?");
    foreach ($detalles as $detalle ){
        mysqli_stmt_bind_param($consulta, "ii", $detalle[1], $detalle[2]);
        mysqli_stmt_execute($consulta);
    }
    mysqli_stmt_close($consulta);

    return 1;
}

function obtenerPedidosFiltrados($search, $tipo, $estado){
    $bbdd = conectar();
    $id_pedido_estado = array();
    $id_pedido_search = array();
    if ($estado != 0) {
        $consulta = mysqli_prepare($bbdd, "SELECT codigo FROM pedidos WHERE estado = ?");
        mysqli_stmt_bind_param($consulta, "i", $estado);
        mysqli_stmt_execute($consulta);
        mysqli_stmt_bind_result($consulta, $codigo);
        while (mysqli_stmt_fetch($consulta)) {
            array_push($id_pedido_estado, $codigo);
        }
        mysqli_stmt_close($consulta);
    }
    if ($tipo == "0"){
        $search = "%".$search."%";
        $consulta = mysqli_prepare($bbdd, "SELECT ped.codigo FROM pedidos ped JOIN usuarios per ON ped.persona=per.codigo WHERE (per.nombre LIKE ? OR per.apellidos LIKE ?)");
        mysqli_stmt_bind_param($consulta, "ss", $search, $search);
        mysqli_stmt_execute($consulta);
        mysqli_stmt_bind_result($consulta, $codigo);
        while (mysqli_stmt_fetch($consulta)) {
            array_push($id_pedido_search, $codigo);
        }
        mysqli_stmt_close($consulta);
    } else if ($tipo == "1"){
        // search for specific date 
        $consulta = mysqli_prepare($bbdd, "SELECT codigo FROM pedidos WHERE DATE_FORMAT(fecha, '%d/%m/%Y')  = ?");
        mysqli_stmt_bind_param($consulta, "s", $search);
        mysqli_stmt_execute($consulta);
        mysqli_stmt_bind_result($consulta, $codigo);
        while (mysqli_stmt_fetch($consulta)) {
            array_push($id_pedido_search, $codigo);
        }
        mysqli_stmt_close($consulta);
    }else if ($tipo == "2"){
        // search for specific name of productos
        $search = "%".$search."%";
        $consulta = mysqli_prepare($bbdd, "SELECT ped.codigo FROM pedidos ped JOIN detalle det ON ped.codigo=det.codigo_pedido JOIN productos pro ON det.codigo_producto=pro.codigo WHERE pro.descripcion LIKE ?");
        mysqli_stmt_bind_param($consulta, "s", $search);
        mysqli_stmt_execute($consulta);
        mysqli_stmt_bind_result($consulta, $codigo);
        while (mysqli_stmt_fetch($consulta)) {
            array_push($id_pedido_search, $codigo);
        }
        mysqli_stmt_close($consulta);
    }
    if ($estado == 0 && $search == ""){
        return obtenerPedidos();
    }else if ( $estado != 0 && $search != ""){
        $interseccion = array_intersect($id_pedido_estado, $id_pedido_search);
    } else if ($search == "") {
        $interseccion = $id_pedido_estado;
    } else {
        $interseccion = $id_pedido_search;
    }

    if (empty($interseccion)){
        return null;
    }else{
        return obtenerPedidos_by_id_array($interseccion);
    }

}

?>