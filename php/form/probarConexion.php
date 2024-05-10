<?php
    require_once '../funcion/baseDatos.php';
    require_once '../funcion/function_shared.php';


    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $clave = filter_input(INPUT_POST, 'clave');
        $correo = filter_input(INPUT_POST, 'correo');
        $url =  filter_input(INPUT_POST, 'url');

        $usuario_id = comprobarPassword($correo, $clave);

        session_start_if_not();

        if ($usuario_id >0 ){
            $_SESSION['usuario_id'] = $usuario_id;
            if ($url) {
                header('Location: ' . $url);
            } else {
                header('Location: ../productos.php');
            }
        }else {
            $_SESSION['error_con'] =  "Usuario o contraseña incorrectos";
            header('Location: ../conexion.php');
        }

    }else{
        header('Location: ../conexion.php');
    }

?>