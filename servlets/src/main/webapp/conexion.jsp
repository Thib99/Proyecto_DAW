<%@ page language="java" contentType="text/html; charset=UTF-8" import="tienda.*" pageEncoding="UTF-8" %>

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
                    <form action="form/login" method="POST" class="mb-2">
                        <%
                        String url = request.getParameter("url");
                        if (url != null) {
                        %>
                        <input type="hidden" name="url" value="<%=url%>">
                        <%
                        }
                        %>
                        <div class="form-floating mb-3 mx-5">
                            <input type="text" class="form-control" id="floatingCorreo" placeholder="Correo" required name="correo"
                                autofocus>
                            <label for="floatingCorreo">Correo</label>
                        </div>
                        <div class="form-floating mb-3 mx-5">
                            <input type="password" class="form-control" id="floatingpassword" placeholder="Contraseña" name="clave"
                                required>
                            <label for="floatingpassword">Contraseña</label>
                        </div>

                        <%-- Utilizamos una variable en la sesión para informar de los mensajes de Error --%>
                        <%
                        String mensaje = (String)session.getAttribute("mensaje_conexion");

                        if (mensaje != null) {
                        %>
                        <%-- Eliminamos el mensaje consumido --%>
                        <%
                            session.removeAttribute("mensaje_conexion");
                        %>
                        <p class="text-center"> <%=mensaje%> </p>
                        <%
                        }
                        %>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mx-5">
                            <button class="btn btn-primary" type="submit">Iniciar sesión<i
                                    class="bi bi-lock-fill"></i></button>
                        </div>
                    </form>
                    <p class="mx-5">Si aún no tiene una cuenta, pulse <a href="registrar.html">aqui</a> para registrarse.</p>
                </div>
            </div>
        </div>
    </section>
    
    <script src="./js/navbar_footer.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>