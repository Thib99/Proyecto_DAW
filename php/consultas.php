<?php
    // check if user connected
    require_once 'funcion/function_shared.php';
    check_if_connected();
?>



<!DOCTYPE html>
<html data-bs-theme="light" lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Consultas</title>



</head>

<body>


    <div class="m-2">

        <table class="table table-dark table-striped table-bordered">
            <thead>
                <tr>
                    <th>Nombre y apellido</th>
                    <th>Correo</th>
                    <th>Fecha</th>
                    <th>Commentario</th>
                    
                </tr>
            </thead>
            <tbody>
                <?php
                require_once('./funcion/baseDatos.php');
                $resultados = obtenerCom()  ;
                while ($fila = mysqli_fetch_row($resultados)) {
                    echo "<tr>";
                    echo "<td>$fila[1] $fila[2]</td>";
                    echo "<td>".$fila[3]."</td>";
                    echo "<td>".$fila[4]."</td>";
                    echo "<td>".$fila[5]."</td>";
                    echo "</tr>" ;
                 } ?>
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