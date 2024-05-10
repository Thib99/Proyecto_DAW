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
    <title>Usarios</title>



    <script src="js/change_user_data.js"></script>
    <script src="js/alert.js"></script>

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
                    <th>Apellido</th>
                    <th>Nombre</th>
                    <th>Telefono</th>
                    <th>Fecha de nac.</th>
                    <th>Correo</th>
                    <th>Dirección</th>
                    <th>Ciudad</th>
                    <th>CP</th>
                    <th>País</th>
                    <th>Activo</th>
                    <th>Modifiar</th>
                </tr>
            </thead>
            <tbody>
                <?php
                require_once('./funcion/baseDatos.php');
                $resultados = obtenerUsuarios();
                while ($fila = mysqli_fetch_row($resultados)) {
                $id_form = "form_".$fila[10];
                ?>
                <tr>
                    <td>
                        <form action="form/cambiarUsuario.php" method="POST" id="<?php echo $id_form ?>"></form>
                        <input type="hidden" form="<?php echo $id_form ?>" name="codigo" value="<?php echo $fila[10];?>">
                        <input type="text" class="form-control-plaintext text-white" form="<?php echo $id_form ?>" id="apellido"
                            name="apellido" disabled value="<?php echo $fila[0];?>">
                    </td>
                    <td><input type="text" class="form-control-plaintext text-white" form="<?php echo $id_form ?>" id="nombre"
                            name="nombre" disabled value="<?php echo $fila[1];?>"></td>
                    <td><input type="tel" class="form-control-plaintext text-white" form="<?php echo $id_form ?>" id="tel" name="tel"
                            disabled value="<?php echo $fila[2];?>"></td>
                    <td><input type="date" class="form-control-plaintext text-white" form="<?php echo $id_form ?>" id="fecha_nac"
                            name="fecha_nac" disabled value="<?php echo $fila[3];?>"></td>
                    <td><input type="email" class="form-control-plaintext text-white" form="<?php echo $id_form ?>" id="email"
                            name="email" disabled value="<?php echo $fila[4];?>"></td>
                    <td><input type="text" class="form-control-plaintext text-white" form="<?php echo $id_form ?>" id="calle" disabled
                            name="calle" placeholder="Av. Peris, 43" value="<?php echo $fila[5];?>"></td>
                    <td><input type="text" class="form-control-plaintext text-white" form="<?php echo $id_form ?>" id="ciudad" disabled
                            name="ciudad" value="<?php echo $fila[6];?>">
                    </td>
                    <td><input type="text" class="form-control-plaintext text-white" form="<?php echo $id_form ?>" id="cp" name="cp" disabled
                            value="<?php echo $fila[7];?>">
                    </td>
                    <td><input type="text" class="form-control-plaintext text-white" form="<?php echo $id_form ?>" id="pais" disabled
                            name="pais" value="<?php echo $fila[8];?>">
                    </td>
                    <td>
                        <input class="form-check-input" type="checkbox" form="<?php echo $id_form ?>" id="activo" value="true" disabled
                            name="activo" <?php if($fila[9]==1)echo "checked";?>>
                    </td>
                    <td>
                        <div class="input-group">
                            <button class="btn btn-outline-secondary invisible" type="button" onclick="change_disabled(this.form)" form="<?php echo $id_form ?>" name="btn_cancel">
                                <i class="bi bi-x-lg"></i>
                            </button>
                            <button class="btn btn-outline-secondary invisible" type="submit" form="<?php echo $id_form ?>" name="btn_save"> 
                                <i class="bi bi-floppy"></i> 
                            </button>
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