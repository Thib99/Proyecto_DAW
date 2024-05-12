<?php 
require_once 'funcion/function_shared.php';
session_start_if_not(); 
?>

<!DOCTYPE html>
<html data-bs-theme="light" lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Conexión</title>

</head>

<body>

    

    <section>
        <div class="container mt-5">

            <div class="col-md-6 mx-auto">
                <div class="shadow p-3 mb-5 bg-white rounded">
                    <h2>Iniciar seción</h2>
                    <br>
                    <form action="form/probarConexion.php" method="POST" class="mb-2">
                        <?php
                        $url = filter_input(INPUT_GET, 'url');
                        if ($url) {
                            echo '<input type="hidden" name="url" value="' . $url . '">';
                        }
                        ?>
                        <div class="form-floating mb-3 mx-5">
                            <input type="text" class="form-control" id="floatingUsario" name="correo" placeholder="Usario" required
                                autofocus>
                            <label for="floatingUsario">Usario</label>
                        </div>
                        <div class="form-floating mb-3 mx-5">
                            <input type="password" class="form-control" id="floatingpassword" placeholder="Contraseña" name="clave"
                                required>
                            <label for="floatingpassword">Contraseña</label>
                        </div>
                        <?php 
                            if (isset($_SESSION['error_con']) && $_SESSION['error_con']) {
                                echo '<p class="text-center"><i class="bi bi-exclamation-triangle m-1"></i>' . $_SESSION['error_con'] . '</p>';
                                unset($_SESSION['error_con']);
                            }
                        ?>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mx-5">
                            <button class="btn btn-primary" type="submit">Iniciar sesión<i
                                    class="bi bi-lock-fill"></i></button>
                        </div>
                    </form>
                    </div>
            </div>
        </div>
    </section>
    <script src="./js/navbar_admin.js"></script>
    <?php 
        require_once 'funcion/function_shared.php';
        informAboutConnectedOrNot() ;
    ?>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>