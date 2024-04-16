<%@ page language="java" contentType="text/html; charset=UTF-8" import="tienda.*" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html data-bs-theme="light" lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Mi cuenta</title>
    
    <!-- <link rel="stylesheet" href="css/usario.css"> -->

</head>

<body>
    <%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("conexion.jsp?url="+request.getRequestURI());
    }
    %>


    
    <div>
        <div class="container my-3">
            <div class="col-md-8 mx-auto">

                <div class="card">
                    <div class="card-header">
                        <ul class="nav nav-tabs card-header-tabs" id="nav-datos">
                            <li class="nav-item">
                                <a class="nav-link active" onclick="change_data_card('datos')">Mis datos</a>
                            </li>
                            <li class=" nav-item">
                                    <a class="nav-link" onclick="change_data_card('pedidos')">Mis pedidos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" onclick="change_data_card('contrasena')">Cambiar contraseña</a>
                            </li>
                        </ul>
                    </div>
                    <div class="card-body" id="content_block">
                        <section id="datos">
                        <div class="container p-4">
                    <form action="" method="POST" id="form1">

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="apellido" class="col-form-label"><b> Apellido: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="apellido" name="apellido" readonly
                                    value="Garcia">
                            </div>

                            <div class="col-md-6">
                                <label for="nombre" class="col-form-label"> <b> Nombre: </b> </label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="nombre" name="nombre" readonly
                                    value="Jose">
                            </div>

                            <div class="col-md-6">
                                <label for="tel" class="col-form-label"> <b>Telefono: </b> </label>
                                <input type="tel" class="form-control-plaintext px-1 mx-2" id="tel" name="tel" readonly
                                    value="+123456789">
                            </div>

                            <div class="col-md-6">
                                <label for="fecha_nac" class="col-form-label"> <b>Fecha de nacimiento: </b></label>
                                <input type="date" class="form-control-plaintext px-1 mx-2" id="fecha_nac" name="fecha_nac"
                                    readonly value="2014-02-09">
                            </div>
                        </div>


                        <div class="mb-3 row">
                            <label for="email" class="col-form-label"> <b>Correo: </b></label>
                            <div class="col">
                                <input type="email" class="form-control-plaintext px-1 mx-2" id="email" name="email" readonly
                                    value="jose.garcia@mail.com">
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-12">
                                <label for="calle" class="form-label"><b>Calle y numero: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="calle" readonly placeholder="Av. Peris, 43" 
                                    value="Av. Peris, 43">
                            </div>
                            <div class="col-md-6">
                                <label for="ciudad" class="form-label"><b>Ciudad: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="ciudad" readonly value="Valencia">
                            </div>
                            <div class="col-md-2">
                                <label for="CP" class="form-label"><b>CP:</b></label>
                                <input type="number" class="form-control-plaintext px-1 mx-2" id="CP" readonly value="46000">
                            </div>
                            <div class="col-md-4">
                                <label for="pais" class="form-label"><b>País: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="pais" readonly value="España">

                            </div>
                        </div>


                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button class="btn btn-primary me-md-2" id="button_cambiar" type="button"
                                onclick="change_readonly(this.form)">
                                Cambiar datos
                                <i class="bi bi-lock-fill"></i>
                                </button>
                            <button class="btn btn-primary" type="submit">
                                <i class="bi bi-floppy"></i>
                                </button>
                        </div>
                        
                        
                        
                        </form>
    </div>  
                        </section>

                        <section id="pedidos">
                        <div class="container">
            <div class="accordion" id="accordionMain">
                <div class="accordion-item">
                    <h2 class="accordion-header">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        Encargo en curso
                    </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionMain">
                    <div class="accordion-body">
                    <div class="table-responsive">
                        <table class="table table-bordered w-100 text-center">
                            <tr>
                                <th>Producto</th>
                                <th>Fecha de pedido</th>
                                <th>Estado</th>
                                <th>Precio</th>
                                <th>Nbr products</th>
                                <th>Cancelar</th>
                            </tr>
                            <tr>
                                <td>Producto 1</td>
                                <td>Fecha 1</td>
                                <td>Prepapración</td>
                                <td>200</td>
                                <td>3</td>
                                <td><a href="#" class="rm-base"><i class="bi bi-x-lg"></i></a></td>
                                
                            </tr>
                            <tr>
                                <td>Producto 2</td>
                                <td>Fecha 2</td>
                                <td>Prepapración</td>
                                <td>400</td>
                                <td>6</td>
                                <td><a href="#" class="rm-base"><i class="bi bi-x-lg"></i></a></td>
                                
                            </tr>
                        </table>
                    </div>
                    </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        Pedido entregado
                    </button>
                    </h2>
                    <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionMain">
                    <div class="accordion-body">
                    <div class="table-responsive">
                        <table class="table table-bordered w-100 text-center">
                            <tr>
                                <th>Producto</th>
                                <th>Fecha de entrega</th>
                                <th>Precio</th>
                                <th>Nbr products</th>
                                <th>Volver a pedir</th>
                            </tr>
                            <tr>
                                <td>Producto 1</td>
                                <td>Fecha 1</td>
                                <td>200</td>
                                <td>3</td>
                                <td><a href="#" class="rm-base"><i class="bi bi-arrow-repeat"></i></a></td>
                                
                            </tr>
                            <tr>
                                <td>Producto 2</td>
                                <td>Fecha 2</td>
                                <td>400</td>
                                <td>6</td>
                                <td><a href="#" class="rm-base"><i class="bi bi-arrow-repeat"></i></a></td>
                                
                            </tr>
                        </table>  
                    </div>
                    </div>
                    </div>
                </div>
                
                </div>

                        </section>

                        <section id="cambiar_contrasena">
                        <div class="row mt-3">
        <div class="col-sm-8 mx-auto">
            <div class="container p-2">
                <form action="" method="POST" class="mb-2">
                    <div class="form-floating mb-3 mx-2">
                        <input type="password" class="form-control" id="floatingpassword"
                            placeholder="Contraseña" required>
                        <label for="floatingpassword">Contraseña anteriore</label>
                    </div>
                    <div class="form-floating mb-3 mx-2">
                        <input type="password" class="form-control" id="floatingpassword_nueva_1"
                            placeholder="Contraseña" required>
                        <label for="floatingpassword_nueva_1">Nueva contraseña</label>
                    </div>
                    <div class="form-floating mb-3 mx-2">
                        <input type="password" class="form-control" id="floatingpassword_nueva_2"
                            placeholder="Contraseña" required>
                        <label for="floatingpassword_nueva_2">Reescribir la nueva contraseña</label>
                    </div>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mx-5">
                        <button class="btn btn-primary" type="submit">Cambiar<i
                                class="bi bi-person-plus-fill"></i></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
                        </section>

                    </div>
                </div>


            </div>
        </div>

    </div>
    <script src="js/usuario.js"></script>

 

    <script src="./js/navbar_footer.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>