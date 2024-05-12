<?php 
    // Initialize the session
    session_start();

    session_unset();
    // Unset all of the session variables
    $_SESSION = array();

    // Destroy the session
    session_destroy();

    header('Location: ../conexion.php');
?>