<?php
function conectar() {
    $hostname = "localhost";
    $username = "root";
    $password = "root";
    $database = "daw";

    // put correct host if it run from a docker 
    if (getenv('DB_HOST') != null) {
        $hostname = getenv('DB_HOST');
    }

    $bbdd = mysqli_connect($hostname, $username, $password, $database);
    
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

function anadirProducto($nombre, $cantidad, $precio, $categoria, $img1, $img2, $img3){
    $bbdd = conectar();
    // first create an empty product and save the id of the product
    $consulta = mysqli_prepare($bbdd, "INSERT INTO productos (descripcion, existencias, precio, categoria) VALUES (?, ?, ?, ?)");
    mysqli_stmt_bind_param($consulta, "sisi", $nombre, $cantidad, $precio, $categoria);
    mysqli_stmt_execute($consulta);
    $id_producto = mysqli_insert_id($bbdd);
    mysqli_stmt_close($consulta);
    
    // then add the images to the product
    $consulta = mysqli_prepare($bbdd, "UPDATE productos SET imagen1 = ?, imagen2 = ?, imagen3 = ? WHERE codigo = ?");
    if ($img1 != null) $img1 = $id_producto."/1.".$img1;
    if ($img2 != null) $img2 = $id_producto."/2.".$img2;
    if ($img3 != null) $img3 = $id_producto."/3.".$img3;

    mysqli_stmt_bind_param($consulta, "sssi", $img1, $img2, $img3, $id_producto);
    mysqli_stmt_execute($consulta);
    mysqli_stmt_close($consulta);   

    desconectar($bbdd);
    return $id_producto;
}

function cambiarProducto($id, $nombre, $cantidad, $precio, $categoria, $img1, $img2, $img3){
    $bbdd = conectar();
    // first update the product
    $consulta = mysqli_prepare($bbdd, "UPDATE productos SET descripcion = ?, existencias = ?, precio = ?, categoria = ? WHERE codigo = ?");
    mysqli_stmt_bind_param($consulta, "siiii", $nombre, $cantidad, $precio, $categoria, $id);
    mysqli_stmt_execute($consulta);
    mysqli_stmt_close($consulta);

    // if the image is not null, update the image
    if ($img1 != null){
        $consulta = mysqli_prepare($bbdd, "UPDATE productos SET imagen1 = ? WHERE codigo = ?");
        $img1 = $id."/1.".$img1;
        mysqli_stmt_bind_param($consulta, "si", $img1, $id);
        mysqli_stmt_execute($consulta);
        mysqli_stmt_close($consulta);
    }
    if ($img2 != null){
        $consulta = mysqli_prepare($bbdd, "UPDATE productos SET imagen2 = ? WHERE codigo = ?");
        $img2 = $id."/2.".$img2;
        mysqli_stmt_bind_param($consulta, "si", $img2, $id);
        mysqli_stmt_execute($consulta);
        mysqli_stmt_close($consulta);
    }
    if ($img3 != null){
        $consulta = mysqli_prepare($bbdd, "UPDATE productos SET imagen3 = ? WHERE codigo = ?");
        $img3 = $id."/3.".$img3;
        mysqli_stmt_bind_param($consulta, "si", $img3, $id);
        mysqli_stmt_execute($consulta);
        mysqli_stmt_close($consulta);
    }

    desconectar($bbdd);
    return 1;
}

?>