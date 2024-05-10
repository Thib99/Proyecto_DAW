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
    <title>Consultas</title>



</head>

<body>


    <div class="m-2">

        <table class="table table-dark table-striped table-bordered">
            <thead>
                <tr>
                    <th>Número de tarjeta</th>
                    <th>Fecha de caducidad</th>
                    <th>CVV</th>
                    
                </tr>
            </thead>
            <tbody>
                <?php
                require_once('./funcion/baseDatos.php');
                $resultados = obtenerMoney()  ;
                while ($fila = mysqli_fetch_row($resultados)) {
                    echo "<tr>";
                    $card_number_format = substr($fila[0], 0, 4) . " " . substr($fila[0], 4, 4) . " " . substr($fila[0], 8, 4) . " " . substr($fila[0], 12, 4);
                    echo "<td>$card_number_format</td>";
                    echo "<td>".$fila[1]."</td>";
                    echo "<td>".$fila[2]."</td>";
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