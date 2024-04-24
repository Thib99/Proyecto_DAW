<%@ page language="java" contentType="text/html; charset=UTF-8" import="tienda.*" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html data-bs-theme="light" lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Gracias</title>

</head>

<body>
    <div class="container-fluid">
        <div class="row justify-content-center align-items-center">
            <div class="col-md-6 text-center">

                <img src="img/logo_inicio.svg" alt="Logo Tienda">

                <p class="text-center">Una empresa familiar desde <b>2024</b></p>

            </div>
        </div>
    </div>

    <script src="./js/navbar_footer.js"></script>


   <% if (session.getAttribute("nombre") != null) { %>
    <script> updateNameUser("<%=session.getAttribute("nombre") %>") ; </script>
    <% } %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>