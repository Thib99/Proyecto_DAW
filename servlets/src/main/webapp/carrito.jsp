<%@ page language="java" contentType="text/html; charset=UTF-8" import="tienda.*" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html data-bs-theme="light" lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Carrito</title>
    <script src="js/manage_cart.js"></script>
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

        <div class="container-fluid">
            <div class="row gap-0 ">
                <!-- Main Content -->
                <div class="col-md-8">



                    <div class="card my-3 mx-3">
                        <div class="card-header">
                            <h2><u> Caritto </u></h2>
                        </div>
                        <div class="card-body" id="body_carrito_display">

                            <!-- todos los productos en el carrito -->
                        </div>
                    </div>

                </div>



                <!-- Aside Component -->
                <aside class="col-md-4">
                    <div class="card my-3 ">
                        <div class="card-header text-center">
                            <h3> <u> Resumen del pedido </u></h3>
                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between">
                                        <h6><b>Numero de producto:</b></h6>
                                        <h6 id="total_cantidad">0</h6>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between">
                                        <h6><b>Subtotal:</b></h6>
                                        <h6 id="total_precio_producto">0€</h6>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between">
                                        <h6><b>Envío:</b></h6>
                                        <h6 id="precio_entrega">0€</h6>
                                    </div>
                                </li>
                                <li class="list-group-item">
                                    <div class="d-flex justify-content-between">
                                        <h5><b>Importe total:</b></h5>
                                        <h5 id="total_precio">0€</h5>
                                    </div>
                                </li>
                            </ul>

                        </div>
                        <div class="card-footer">
                            <div class="d-grid col-8 mx-auto">
                                <button type="button" class="btn btn-success btn-lg" onclick="getProductInfo();" id="btn_comprar">Pedir <span class="mx-2"> <i
                                            class="bi bi-box-seam" ></i></span></button>
                            </div>
                        </div>
                    </div>
                </aside>
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