<!-- check if user connected -->
<?php
    require_once 'funcion/function_shared.php';
    check_if_connected();
?>


<!DOCTYPE html>
<html data-bs-theme="light" lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Productos</title>
  
    <link rel="stylesheet" href="css/productos.css">
    <script src="js/change_user_data.js"></script>
    <script src="js/upload_img.js"></script>
    
</head>

<body>
    <?php
        require_once 'funcion/function_shared.php';
        monstrarNotif();
    ?>

    <div class="m-2">

        <table class="table table-dark table-striped table-bordered">
            <thead>
                <tr>
                    <th>Imagen 1</th>
                    <th>Imagen 2</th>
                    <th>Imagen 3</th>
                    <th>Nombre</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Categoría</th>
                    <th></th>

                </tr>
            </thead>
            <tbody class="align-middle text-center">
                <?php
                    require_once('./funcion/baseDatos.php');
                    $categorias = obtenerCategoriaProducto();
                ?>
                <tr >
                    <td>
                            <form action="form/anadirProducto.php" method="POST" id="form-add-product" ></form>
                            <div class="image-container" onclick="selectImage(this)">
                                <input type="file" class="input-invisible" required form="form-add-product" name="img1" >
                                <img class="uploaded-image" src="img/placeholder-img.jpg" alt="Uploaded Image">

                            </div>
                        
                        </td>
                        <td>
                            <div class="image-container" onclick="selectImage(this)">
                                <input type="file" class="input-invisible" form="form-add-product" name="img2">
                                <img class="uploaded-image" src="img/placeholder-img.jpg" alt="Uploaded Image">
                            </div>
                        
                        </td>
                        <td>
                            <div class="image-container" onclick="selectImage(this)">
                                <input type="file" class="input-invisible" form="form-add-product" name="img3">
                                <img class="uploaded-image" src="img/placeholder-img.jpg" alt="Uploaded Image">
                            </div>
                        
                        </td>
                        <td><input type="text" class="form-control-plaintext text-white" name="nombre" required form="form-add-product" 
                                 placeholder="Introducir el nombre"></td>

                        <td><input type="number" class="form-control-plaintext text-white"   required form="form-add-product"   
                                name="cantidad"  placeholder="Introducir la cantidad"></td>

                        <td><input type="number" class="form-control-plaintext text-white"  name="precio" required form="form-add-product"   step="0.01"
                                 placeholder="Introducir el precio" min="0"></td>
                        <td>
                            <select class="form-select" form="form-add-product" name="categoria" required>
                                <option value="" selected>Seleccionar categoría</option>
                                <?php
                                    foreach ($categorias as $key => $value){
                                        echo "<option value='$key'>$value</option>";
                                    }
                                ?>
                            </select>
                        </td>
                        <td>
                            <button class="btn btn-outline-secondary" type="submit"  form="form-add-product" > 
                                <i class="bi bi-plus-circle"></i>
                            </button>
                        </td>
                    
                </tr>
                <?php
                    function enlaceImagen($imagen){
                        $init_path = "img/productos/" ;
                        if ($imagen == null) {
                            echo "img/placeholder-img.jpg";
                        } else {
                            echo $init_path.$imagen;
                        }
                    }

                    
                    $productos = obtenerProductos();
                    while ($fila = mysqli_fetch_row($productos)) {
                        $id_form = "form_".$fila[0];
                ?>
                <tr>
                    <td>
                        <form action="form/anadirProducto.php" method="POST" id="<?php echo $id_form ?>"></form>

                            <input type="hidden" name="codigo" form="<?php echo $id_form ?>" value="<?php echo $fila[0] ?>">
                            <div class="image-container" onclick="selectImage(this)">
                                <input type="file" class="input-invisible" disabled form="<?php echo $id_form ?>" name="img1">
                                <img class="uploaded-image" src="<?php enlaceImagen($fila[1])?>" alt="Uploaded Image">
                            </div>
                        
                        </td>
                        <td>
                            <div class="image-container" onclick="selectImage(this)">
                                <input type="file" class="input-invisible"  disabled form="<?php echo $id_form ?>" name="img2" >
                                <img class="uploaded-image" src="<?php enlaceImagen($fila[2])?>" alt="Uploaded Image">
                            </div>
                        
                        </td>
                        <td>
                            <div class="image-container" onclick="selectImage(this)">
                                <input type="file" class="input-invisible"  disabled form="<?php echo $id_form ?>" name="img3">
                                <img class="uploaded-image" src="<?php enlaceImagen($fila[3])?>" alt="Uploaded Image">
                            </div>
                        
                        </td>
                        <td><input type="text" class="form-control-plaintext text-white" form="<?php echo $id_form ?>"  name="nombre" required
                                disabled value="<?php echo $fila[4] ?>"></td>

                        <td><input type="number" class="form-control-plaintext text-white" form="<?php echo $id_form ?>"    required
                                name="cantidad" disabled value="<?php echo $fila[5] ?>"></td>

                        <td><input type="number" class="form-control-plaintext text-white" form="<?php echo $id_form ?>"   name="precio" required step="0.01"
                                disabled value="<?php echo $fila[6] ?>"></td>
                        <td>
                            <select class="form-control-plaintext text-white" form="<?php echo $id_form ?>"  name="categoria" disabled required>
                                <?php
                                    foreach ($categorias as $key => $value){
                                        if ($key == $fila[7]) {
                                            echo "<option value='$key' selected>$value</option>";
                                        } else {
                                            echo "<option value='$key'>$value</option>";
                                        }
                                    }
                                ?>
                            </select>
                        </td>
                        <td>
                        <div class="input-group">
                            <button class="btn btn-outline-secondary d-none" type="button" onclick="change_disabled(this.form)" form="<?php echo $id_form ?>" name="btn_cancel">
                                <i class="bi bi-x-lg"></i>
                            </button>
                            <button class="btn btn-outline-secondary d-none" type="submit" form="<?php echo $id_form ?>" name="btn_save"> 
                                <i class="bi bi-floppy"></i> 
                            </button>
                        </div>
                        <div class="input-group">
                            <button class="btn btn-outline-secondary" type="button" onclick="change_disabled(this.form)" form="<?php echo $id_form ?>" name="btn_change"> 
                                <i class="bi bi-pencil-square"></i>
                            </button>
                        </div>
                        </td>
                </tr>

                <?php } ?>
                
            </tbody>
        </table>
    </div>



    <script src="./js/navbar_admin.js"></script>
    <?php 
        require_once 'funcion/function_shared.php';
        informAboutConnectedOrNot() ;
    ?>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>