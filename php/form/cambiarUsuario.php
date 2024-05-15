<?php
    require_once '../funcion/baseDatos.php';
    require_once '../funcion/function_shared.php';

    check_if_connected();   

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $id = filter_input(INPUT_POST, 'codigo');
        $nombre = filter_input(INPUT_POST, 'nombre');
        $apellido = filter_input(INPUT_POST, 'apellido');
        $tel = filter_input(INPUT_POST, 'tel');
        $fecha_nac = filter_input(INPUT_POST, 'fecha_nac');
        $email = filter_input(INPUT_POST, 'email');
        $calle = filter_input(INPUT_POST, 'calle');
        $ciudad = filter_input(INPUT_POST, 'ciudad');
        $cp = filter_input(INPUT_POST, 'cp');
        $pais = filter_input(INPUT_POST, 'pais');
        $activo = filter_input(INPUT_POST, 'activo');

        if ($activo == "true") {
            $activo = 1;
        } else {
            $activo = 0;
        }

        $status = cambiarUsuario($id, $nombre, $apellido, $tel, $fecha_nac, $email, $calle, $ciudad, $cp, $pais, $activo);

        if ($status == -2) {
            session_start_if_not();
            $_SESSION['notif_msg'] = "El correo ya está en uso";
            $_SESSION['notif_type'] = "danger";
        }
        else if ($status >= 0 ) {
            session_start_if_not();
            $_SESSION['notif_msg'] = "Usuario actualizado correctamente";
            $_SESSION['notif_type'] = "success";
        }
        else {
            session_start_if_not();
            $_SESSION['notif_msg'] = "Error al actualizar el usuario";
            $_SESSION['notif_type'] = "danger";
        }



    }
    header('Location: ../usuarios.php');
    
    

?>
