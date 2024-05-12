<?php
    require_once '../funcion/baseDatos.php';
    require_once '../funcion/function_shared.php';

    session_start_if_not();

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
       

    }else{
        $_SESSION['notif_msg'] = "Sólo se aceptan solicitudes POST";
        $_SESSION['notif_type'] = "danger";
    }
    header('Location: ../productos.php');
    
    

?>