<?php
    require_once '../funcion/baseDatos.php';
    require_once '../funcion/function_shared.php';

    check_if_connected();

    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $id = filter_input(INPUT_POST, 'codigo');
        $estado = filter_input(INPUT_POST, 'estado');

        
        if ($estado == 4) {
            $status = min (cancelarPedido($id), cambiarEstadoPedido($id, $estado));
        }else{
            $status = cambiarEstadoPedido($id, $estado);
        }


        
        if ($status >= 0 ) {
            session_start_if_not();
            $_SESSION['notif_msg'] = "Estado del pedido actualizado correctamente";
            $_SESSION['notif_type'] = "success";
        }
        else {
            session_start_if_not();
            $_SESSION['notif_msg'] = "Error al actualizar del pedido";
            $_SESSION['notif_type'] = "danger";
        }



    }
    header('Location: ../pedidos.php');
    
    

?>