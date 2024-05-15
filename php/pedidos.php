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
    <title>Pedidos</title>

    <link rel="stylesheet" href="css/pedidos.css">
    <script src="js/alert.js"></script>



</head>

<body>
    <?php
        require_once 'funcion/function_shared.php';
        monstrarNotif();
        
        require_once('./funcion/baseDatos.php');
        $estados_name = obtenerEstadoPedido();
    ?>

  
        
        <div class="containe">
            <div class="row justify-content-center">
                <div class="col-md-9 m-2">
            
                    <?php
                        $search = filter_input(INPUT_GET, 'search');
                        $tipo = filter_input(INPUT_GET, 'tipo');
                        $estado = filter_input(INPUT_GET, 'estado');    
                    ?>
                        
                        <form action="pedidos.php" method="GET">
                            
                            <div class="input-group">
                                <select id="tipo" class="form-control" name="tipo" onchange="changePlaceholder();">
                                    <?php 
                                        $all_options = array('Usuario', 'Fecha', 'Producto') ;
                                        foreach ($all_options as $key => $value){
                                            if (isset($tipo) && $tipo == $key)
                                            echo "<option value='$key' selected>$value</option>";
                                        else
                                        echo "<option value='$key'>$value</option>";
                                }
                                ?>                                    
                                </select>
                                <!-- <span class="input-group-text" id="basic-addon1"><i class="bi bi-box-seam"></i></span> -->
                                <input type="text" class="form-control" placeholder="Pedido" aria-label="Pedido" name="search"
                                value="<?php echo $search; ?>"
                                aria-describedby="basic-addon1">
                                <script>
                                    // change the placeholder of the input search based on the selected option
                                    function changePlaceholder(){
                                        var select = document.getElementById('tipo');
                                        var search = document.getElementsByName('search')[0];
                                        const placeholders = ['"nombre" o "apellido"', 'dd/mm/yyy', 'nombre del producto'];
                                        search.placeholder = placeholders[select.selectedIndex];
                                    }
                                    changePlaceholder();
                                    </script>
                                <span class="input-group-text" id="basic-addon1">Estado</span>
                                <select id="estado" name="estado">
                                    <option value='0'>Todos</option>
                                    <?php 
                                        foreach ($estados_name as $key => $value){
                                            if (isset($estado) && $estado == $key)
                                            echo "<option value='$key' selected>$value</option>";
                                        else
                                        echo "<option value='$key'>$value</option>";
                                    
                                }
                                ?>
                                </select>
                                
                                <button class="btn btn-outline-secondary" type="submit" id="button-addon2"><i
                                class="bi bi-search"></i>
                            </button>
                        </div>
                        
                    </form>
                    
                </div>
            </div>
        </div>
                    
                
    <div class="m-2">
        <?php 
            if (isset($_GET['search']) && isset($_GET['tipo']) && isset($_GET['estado'])){
                $search = $_GET['search'];
                $tipo = $_GET['tipo'];
                $estado = $_GET['estado'];
                $pedidos = obtenerPedidosFiltrados($search, $tipo, $estado);
            } else {
                $pedidos = obtenerPedidos();
            }
            if ($pedidos == null){
                echo "<h2 class='text-center'>No hay pedidos</h2>";
            }else{   
            ?>                          
        <table class="table table-dark table-striped table-bordered">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Nombre y appelido</th>
                    <th>Fecha de pedido</th>
                    <th>Numero de productos</th>
                    <th>Dirección</th>
                    <th>Ciudad</th>
                    <th>País</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                
                   
                <?php
                    while ($pedido = mysqli_fetch_row($pedidos)) {
                        $id_dropdown = "flush-collapse_pedido_".$pedido[0];
                        $detalles = obtenerDetallesPedidos($pedido[0]);
                        
                        $nbr_productos = 0;
                        foreach ($detalles as $detalle ){
                            $nbr_productos += $detalle[1];
                        }
                ?>
                <tr>
                <?php
                    echo "<td>$pedido[0]</td>";
                    echo "<td>$pedido[1] $pedido[2]</td>";

                    $datetime = new DateTime($pedido[3]);
                    setlocale(LC_TIME,"es_ES");                        
                    $formattedDate = ucfirst(date('l j \d\e F Y \a \l\a\s H.i', date_timestamp_get($datetime)));
                     // $formattedDate = ucfirst($datetime->format('l j \d\e F Y \a\l H:i'));
                    echo "<td>$formattedDate</td>";
                    echo "<td>$nbr_productos</td>";
                    echo "<td>$pedido[4]</td>";
                    echo "<td>$pedido[5]</td>";
                    echo "<td>$pedido[6]</td>";
                    echo "<td>";
                    $id_form = "form_".$pedido[0];
                    echo "<form action='form/cambiarPedido.php' method='POST' id='$id_form'></form>";
                    echo "<input type='hidden' form='$id_form' name='codigo' value='$pedido[0]'>";
                    echo "<select class='form-control-plaintext text-white' form='$id_form'  name='estado' onchange='this.form.submit();'>" ;
                    $estado_posible = array();
                    if ($pedido[7] == 1){
                        $estado_posible = array(2, 4);
                    } else if ($pedido[7] == 2){
                        $estado_posible = array(3, 4);
                    }
                    echo "<option value=".$pedido[7]."selected>".$estados_name[$pedido[7]]."</option>";
                    foreach ($estado_posible as $estado){
                        echo "<option value='$estado'>".$estados_name[$estado]."</option>";
                    }

                    echo "</select>";
                    echo "</td>";
                ?>


                <tr>
                    
                </tr>
                <tr>
                    <td colspan="8">
                        <div class="accordion accordion-flush" id="accordion_pedido_1">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed color-negro" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#<?php echo $id_dropdown ?>"
                                        aria-expanded="false" aria-controls="<?php echo $id_dropdown ?>">
                                        Pulse aquí para ver el contenido del pedido
                                    </button>
                                </h2>
                                <div id="<?php echo $id_dropdown ?>" class="accordion-collapse collapse"
                                    data-bs-parent="#accordion_pedido_1">
                                    <div class="accordion-body color-body">
                                        <table class="table  table-sm table-dark  table-striped-columns">
                                            <tr>
                                                <th>Nombre</th>
                                                <th>Quantidad</th>
                                            </tr>
                                            <?php 
                                                for ($i = 0; $i < count($detalles); $i++) {
                                                    echo "<tr>";
                                                    echo "<td>".$detalles[$i][0]."</td>";
                                                    echo "<td>".$detalles[$i][1]."</td>";
                                                    echo "</tr>";
                                                }
                                            ?>

                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
                <?php } ?>

            </tbody>
        </table>
        <?php } ?>
    </div>



    <script src="./js/navbar_admin.js"></script>
    <?php 
        require_once 'funcion/function_shared.php';
        informAboutConnectedOrNot() ;
    ?>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>