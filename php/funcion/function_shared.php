<?php

    function check_if_connected() {
        session_start_if_not();

    //     if ($_SESSION['usuario_id'] == null) {
    //         $back_to = $_SERVER['REQUEST_URI'];
    //         if ($back_to != '/conexion.php') {
    //             header('Location: conexion.php?url=' . $back_to);
    //         }else {
    //             header('Location: conexion.php');
    //         }
    //    }
    }

    function informAboutConnectedOrNot() {
        session_start_if_not();
        if (isset($_SESSION['usuario_id']) && $_SESSION['usuario_id'] != null) {
            echo '<script> is_connect('.$_SESSION['usuario_id'].'); </script>';
        } 
    }
    

    function session_start_if_not() {
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
    }

    function monstrarNotif(){
        session_start_if_not();
        if (isset($_SESSION['notif_msg']) && isset($_SESSION['notif_type'])) {
            $msg = $_SESSION['notif_msg'];
            $type = $_SESSION['notif_type'];
            echo "<script>notificationALert('".$msg."', '".$type."');</script>" ;
            unset($_SESSION['notif_msg']);
            unset($_SESSION['notif_type']);
        }
    }

?>