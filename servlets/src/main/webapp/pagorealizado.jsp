<%@ page language="java" contentType="text/html; charset=UTF-8" import="tienda.*" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gracias</title>
    <script src="js/pagorealizado.js"></script>
</head>

<body>
    <section>
        <div class="container mt-5">
            <div class="col-md-8 mx-auto">
                <div class="shadow p-4 mb-5 bg-white rounded">

                    <h1 class="text-center">Gracias por su pedido </h1>
                    <br>
                    <h2 class="text-center">Su pedido ha sido procesado y recibirá su paquete en unos días. </h2>
                    
                    <br>
                    <h4 class="text-center">
                        Número de pedido : <span id="id_pedido"></span>
                    </h4>
                        
                    <p class="text-center"><a href="index.jsp">Volver a la página de inicio.</a></p>
                    

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