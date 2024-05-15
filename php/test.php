<?php
    session_start() ;
    $_SESSION['notif_msg'] = "Producto añadido correctamente";
    $_SESSION['notif_type'] = "success";
    header('Location: productos.php');
?>