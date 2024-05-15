<?php
    require_once '../funcion/baseDatos.php';
    require_once '../funcion/function_shared.php';

    session_start_if_not();
    check_if_connected();

    // $path_images = "../../servlets/target/servlets/img/productos/" ;
    $path_images = '../img/productos/';


    if ($_SERVER['REQUEST_METHOD'] == 'POST') {

        // get string inforamtion
        $nombre = filter_input(INPUT_POST, 'nombre');
        $cantidad = filter_input(INPUT_POST, 'cantidad');
        $precio = filter_input(INPUT_POST, 'precio');
        $categoria = filter_input(INPUT_POST, 'categoria');
        $producto_id = filter_input(INPUT_POST, 'codigo');


        // get image information
        $img1 = $_FILES['img1'];
        $img2 = $_FILES['img2'];
        $img3 = $_FILES['img3'];

      
       
        //  all the extension allowed for the images
        $extension_allow = array('jpg', 'jpeg', 'png');
         
      

        $img1_name = strtolower(pathinfo($img1["name"], PATHINFO_EXTENSION));
        $img2_name = strtolower(pathinfo($img2["name"], PATHINFO_EXTENSION));
        $img3_name = strtolower(pathinfo($img3["name"], PATHINFO_EXTENSION));

        // test if their is an image in the input
        if ($img1['size']==0) $img1_name = null ;
        if ($img2['size']==0) $img2_name = null ;
        if ($img3['size']==0) $img3_name = null ;
        
        if  ($img1['error'] != 4 && $img1_name != null && ! in_array($img1_name, $extension_allow)){
            $_SESSION['notif_msg'] = "La imagen 1 no es un archivo jpg, jpeg o png.";
            $_SESSION['notif_type'] = "danger";
            header('Location: ../productos.php');
            exit();
        }

        if  ($img2['error'] != 4 && $img2_name != null && ! in_array($img2_name, $extension_allow)){
            $_SESSION['notif_msg'] = "La imagen 2 no es un archivo jpg, jpeg o png.";
            $_SESSION['notif_type'] = "danger";
            header('Location: ../productos.php');
            exit();
        }

        if  ($img3['error'] != 4 && $img3_name != null && ! in_array($img3_name, $extension_allow)){
            $_SESSION['notif_msg'] = "La imagen 3 no es un archivo jpg, jpeg o png.";
            $_SESSION['notif_type'] = "danger";
            header('Location: ../productos.php');
            exit();
        }

        // ahora somos seguros de que las imagenes son jpg, jpeg o png


        
        // vamos a modifiar el objecto producto en la base de datos
        cambiarProducto($producto_id, $nombre, $cantidad, $precio, $categoria, $img1_name, $img2_name, $img3_name);



        $path_product = $path_images.$producto_id."/";

        // move the images to the folder if they are not empty
        if ($img1['error'] == 0 && $img1_name != null){
            if (! move_uploaded_file($img1["tmp_name"], $path_product."1.".$img1_name)){
                error_ahora();
                exit();
            }
        }
        if ($img2['error'] == 0 && $img2_name != null){
            if (!move_uploaded_file($img2["tmp_name"], $path_product."2.".$img2_name)){
                error_ahora();
                exit();
            }
        }
        if ($img3['error'] == 0 && $img3_name != null){
            if (! move_uploaded_file($img3["tmp_name"], $path_product."3.".$img3_name)){
                error_ahora();
                exit();
            }
        }


        $_SESSION['notif_msg'] = "Producto cambiado con éxito";
        $_SESSION['notif_type'] = "success";


    }else{
        $_SESSION['notif_msg'] = "Sólo se aceptan solicitudes POST";
        $_SESSION['notif_type'] = "danger";
    }
    header('Location: ../productos.php');
    

    function error_ahora(){
        $_SESSION['notif_msg'] = "Ha ocurrido un error inesperado";
        $_SESSION['notif_type'] = "danger";
        header('Location: ../productos.php');
    }
?>