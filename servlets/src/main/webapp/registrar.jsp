<%@ page language="java" contentType="text/html; charset=UTF-8" import="tienda.*" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html data-bs-theme="light" lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar</title>

    <script src="js/alert.js"></script>
</head>

<body>
    <%
    String notif = (String)session.getAttribute("notification_msg");
    String type = (String)session.getAttribute("notification_type");

    if (notif != null) { 
    %>
    <%-- Eliminamos el mensaje consumido --%>
    <%
        session.removeAttribute("notification_msg");
        session.removeAttribute("notification_type");
    %>
    
    <script>
        notificationALert('<%=notif%>', '<%=type%>') ;
    </script>
    <%
    }
    %>

    <section>
        <div class="container mt-5">
            <div class="col-md-8 mx-auto">
                <div class="shadow p-3 mb-5 bg-white rounded">
                    <h2>Crear una cuenta</h2>
                    <br>
                    <div class="container">


                        <form action="form/nuevoUsuario" method="POST" autocomplete="on" class="mb-2 form-floating mb-3">


                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="apellido" name="apellido" placeholder="apellido" required>
                                        <label for="apellido">Apellido</label>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating mb-3">

                                        <input type="text" class="form-control" id="nombre" name="nombre" placeholder="nombre" required>
                                        <label for="nombre"> Nombre </label>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="tel" class="form-control" id="telefono" name="telefono" placeholder="telefono" pattern="\d{9}" required>
                                        <label for="telefono"> Telefono </label>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="date" class="form-control" id="fechaNac" name="fechaNac" required >
                                        <label for="fechaNac">Fecha de nacimiento</label>
                                    </div>
                                </div>
                            </div>


                            <div class="mb-3 row">
                                <div class="col">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="correo" name="correo" placeholder="correo" pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" required>
                                        <label for="correo">Correo</label>
                                    </div>
                                </div>
                            </div>


                            <div class="row g-3 mb-3">
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="domicilio" name="domicilio" placeholder="Calle y numero" required>
                                        <label for="domicilio" class="form-label">Calle y numero</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="poblacion" name="poblacion" placeholder="poblacion" required>
                                        <label for="poblacion" class="form-label">Ciudad</label>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="cp" placeholder="cp" name="cp" pattern="\d{5}" required>
                                        <label for="cp" class="form-label">CP</label>

                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="pais" name="pais" placeholder="País" required>
                                        <label for="pais" class="form-label">País</label>
                                    </div>
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <p class="text-center">Por favor, usa una contraseña con al menos 6 caracteres,
                                    incluyendo una letra mayúscula y un número.</p>
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" id="password_1" name="password_1" pattern="^(?=.*[A-Z])(?=.*\d).{6,}$" required 
                                            placeholder="Contraseña" required>
                                        <label for="password_1">Contraseña</label>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" id="password_2" name="password_2" required
                                            placeholder="Contraseña" required>
                                        <label for="password_2">Reescribir lacontraseña</label>
                                    </div>
                                </div>
                            </div>


                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mx-5">
                                <button class="btn btn-primary" type="submit">Registrarse <i
                                        class="bi bi-person-plus-fill"></i></button>
                            </div>

                        </form>

                        <p class="text-center">Si tiene una cuenta, haga clic <a href="conexion.jsp">aquí</a> para
                            conectarse
                        </p>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <script src="./js/navbar_footer.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>