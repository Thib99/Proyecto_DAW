<?php
    require_once '../funcion/baseDatos.php';
    require_once '../funcion/function_shared.php';

    session_start_if_not();
    check_if_connected();

    $path_images = '../img/productos/';
    // $path_images = "../../servlets/target/servlets/img/productos/" ;


    if ($_SERVER['REQUEST_METHOD'] == 'POST') {

        // get string inforamtion
        $nombre = filter_input(INPUT_POST, 'nombre');
        $cantidad = filter_input(INPUT_POST, 'cantidad');
        $precio = filter_input(INPUT_POST, 'precio');
        $categoria = filter_input(INPUT_POST, 'categoria');


        // get image information
        $img1 = $_FILES['img1'];
        $img2 = $_FILES['img2'];
        $img3 = $_FILES['img3'];

        $extensiones_imagenes = array() ;
        // check if images are jpg, jpeg or png
        if ($img1['error'] != 4){ //test if a file have been selected
            $file_extension = strtolower(pathinfo($img1["name"], PATHINFO_EXTENSION));
            array_push($extensiones_imagenes, $file_extension);
        }
        if ($img2['error'] != 4){
            $file_extension = strtolower(pathinfo($img2["name"], PATHINFO_EXTENSION));
            array_push($extensiones_imagenes, $file_extension);
        }
        if ($img3['error'] != 4){
            $file_extension = strtolower(pathinfo($img3["name"], PATHINFO_EXTENSION));
            array_push($extensiones_imagenes, $file_extension);
        }
       

        $extension_allow = array('jpg', 'jpeg', 'png');
        
        for ($i=0; $i < count($extensiones_imagenes); $i++) { 
            if (!in_array($extensiones_imagenes[$i], $extension_allow)){
                $_SESSION['notif_msg'] = "La imagen ".($i+1)." no es un archivo jpg, jpeg o png.";
                $_SESSION['notif_type'] = "danger";
                header('Location: ../productos.php');
                exit();
            }
        }

        $img1_name = strtolower(pathinfo($img1["name"], PATHINFO_EXTENSION));
        $img2_name = strtolower(pathinfo($img2["name"], PATHINFO_EXTENSION));
        $img3_name = strtolower(pathinfo($img3["name"], PATHINFO_EXTENSION));
        if ($img1['size']==0) $img1_name = null ;
        if ($img2['size']==0) $img2_name = null ;
        if ($img3['size']==0) $img3_name = null ;


        // ahora somos seguros de que las imagenes son jpg, jpeg o png

        // vamos a crear el objecto producto en la base de datos
        $producto_id = anadirProducto($nombre, $cantidad, $precio, $categoria, $img1_name, $img2_name, $img3_name);


        // create the  folder for the product
        $path_product = $path_images.$producto_id."/";
        if (!file_exists($path_product)){
            mkdir($path_product);
        }

        // move the images to the folder
        if ($img1['error'] == 0 && $img1['size'] != 0){
            if (! move_uploaded_file($img1["tmp_name"], $path_product."1.".$img1_name)){
                error_ahora();
                exit();
            }
        }
        if ($img2['error'] == 0 && $img2['size'] != 0){
            if (!move_uploaded_file($img2["tmp_name"], $path_product."2.".$img2_name)){
                error_ahora();
                exit();
            }
        }
        if ($img3['error'] == 0 && $img3['size'] != 0){
            if (! move_uploaded_file($img3["tmp_name"], $path_product."3.".$img3_name)){
                error_ahora();
                exit();
            }
        }


        $_SESSION['notif_msg'] = "Producto añadido con éxito";
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