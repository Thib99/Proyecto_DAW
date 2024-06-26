<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="./js/alert.js"></script>

<title>Contacto</title>
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

            <h1>Contacto</h1>

            <div class="row aligns-items-center">
                <div class="col-md-6 mx-auto">
                    <div class="card mb-3">
                        <div class="card-header">
                            <h2>Información de contacto</h2>
                        </div>
                        <div class="card-body" style="height: 200px;">
                            <p><strong>Teléfono:</strong>
                                <a href="tel:+3412345678907" class="rm-base">+34 (123) 456-7890</a>
                            </p>
                            <p><strong>Horario:</strong> Lunes a Viernes, 9:00 - 14:00 y 17:00 - 20:00</p>
                            <p><strong>Dirección:</strong> <a href="https://maps.app.goo.gl/VR7Pww63RcEGFFQN6"
                                    target="_blank" class="rm-base">Avinguda de l'Universitat, 46100 Burjassot,
                                    Valencia</a></p>
                        </div>
                    </div>
                </div>

                

                <div class="col-md-6 text-md-right mx-auto">
                    <div class="card">
                        <div class="card-header">
                            <h2>Ubicación en el mapa</h2>

                        </div>
                        <div class="card-body text-center"  style="height: 200px;">
                            <iframe
                                src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d72884.58264358477!2d-0.4843666684750985!3d39.49316111902775!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd60450d03d31e81%3A0xb2d49176f911a805!2sETSE%20-%20Escuela%20T%C3%A9cnica%20Superior%20de%20Ingenier%C3%ADa%20(Universidad%20de%20Valencia)!5e0!3m2!1ses!2ses!4v1709121179467!5m2!1ses!2ses"
                                style="border:0;" allowfullscreen="" loading="lazy"
                                referrerpolicy="no-referrer-when-downgrade">
                            </iframe>
                        </div>
                        
                    </div>
                </div>

            </div>
        </div>
    </section>

    <section>
        <div class="container mt-5">
            <div class="shadow p-3 mb-5 bg-white rounded">
                <h2>Formulario de contacto</h2>

                <div class="container">

                    <p>Si tienes alguna duda, sugerencia o comentario, no dudes en ponerte en contacto con nosotros.</p>
                    
                    <form action="form/contacto" method="POST">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="floatingNombre" placeholder="Nombre" name="nombre" required>
                            <label for="floatingNombre">Nombre</label>
                        </div>
                        <div class="form-floating  mb-3">
                            <input type="text" class="form-control" id="floatingApellido" placeholder="apellido" name="apellido" required>
                            <label for="floatingApellido">Apellido</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="floatingMail" placeholder="name@example.com" name="correo" required pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" >
                            <label for="floatingMail">Correo electronico</label>
                        </div>
                        <div class="form-floating mb-3">
                            <textarea class="form-control" placeholder="describe el problemaaqui" id="floatingCom" name="comentario" required
                            style="height: 100px"></textarea>
                            <label for="floatingCom">Describe el problema</label>
                        </div>
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mx-5">
                            <button class="btn btn-primary" type="submit"> <i class="bi bi-envelope"></i> Enviar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </section>




    <script src="./js/navbar_footer.js"></script>


   <% if (session.getAttribute("nombre") != null) { %>
    <script> updateNameUser("<%=session.getAttribute("nombre") %>") ; </script>
    <% } %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>