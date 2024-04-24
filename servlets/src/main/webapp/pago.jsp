<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8" %>


<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("conexion.jsp?url="+request.getRequestURI());
    }else {
%>

<!DOCTYPE html>
<html data-bs-theme="light" lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Pedir</title>

    <link rel="stylesheet" href="./css/card_select.css">
    <script src="js/manage_cart.js"></script>
    <script src="js/enviar_cart.js"></script>
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
                            <h2><i class="bi bi-credit-card"> </i><u> Mis tarjetas bancarias </u> <h2>
                        </div>
                        <div class="card-body" id="mis_tarjetas">
                            <div class="card-selection">
                                <form id="form_tarjeta">
                                <%
                                    AccesoBD con=AccesoBD.getInstance();
                                    List<CardBD> cards = con.getAllCard((int)session.getAttribute("usuario"));

                                    if (cards.size() <= 0) {
                                %>
                                    <p class="text-center">
                                        No tienes tarjetas guardadas
                                    </p>
                                <%
                                    } else {
                                %>
                                    <div class="form-group">
                                    <%
                                        boolean first = true;
                                        for (CardBD card : cards) {
                                    %>
                                      <div class="custom-control custom-radio">
                                        <input type="radio" id="<%= card.getCodigo() %>" name="creditCard" class="custom-control-input" value="<%= card.getCodigo() %>" <%= first ? "checked" :"" %>>
                                        <label class="custom-control-label" for="<%= card.getCodigo() %>"> <b> <%= card.getCard_name() %> </b> <%="  |  " + card.getCard_number_masked() %> </label>
                                      </div>
                                      
                                    <%
                                        first = false;
                                        }
                                    %>
                                    </div>
                                <%
                                    }
                                %>
                                </form>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card my-3 mx-3">
                        <div class="card-header">
                            <h2><i class="bi bi-plus"></i><u> Añadir una tarjeta </u></h2>
                        </div>
                        <div class="card-body" id="anadir_tarjeta">
                            <form action="form/nuevatarjeta" method="POST" autocomplete="on" class="mb-2 form-floating mb-3">


                                <div class="row g-3 mb-3">
                                    <div class="col-md-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" id="card_name" name="card_name" placeholder="card_name"  required>
                                            <label for="card_name">Nombre de la tarjeta </label>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control" id="card_number" name="card_number" placeholder="card_number" pattern="\d{16}" required>
                                            <label for="card_number">Número de tarjeta </label>
                                        </div>
                                    </div>
    
                                    
                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">
                                            
                                            <input type="text" class="form-control" id="exp_date" name="exp_date" placeholder="exp_date" pattern="(0[1-9]|1[0-2])\/\d{2}" required>
                                            <label for="exp_date"> Fecha de caducidad </label>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-floating mb-3">

                                            <input type="text" class="form-control" id="cvv" name="cvv" placeholder="cvv"  pattern="\d{3}" required>
                                            <label for="cvv"> CVV </label>
                                        </div>
                                    </div>
                                    
                                </div>
                        
                            <div class="d-grid col-6 mx-auto">
                                <button type="submit" class="btn btn-primary" id="btn_comprar">Añadir</button>
                            </div>
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
                                <button type="button" class="btn btn-success btn-lg" onclick="EnviarCarrito();" id="btn_comprar">Pagar <span class="mx-2"> <i
                                            class="bi bi-lock" ></i></span></button>
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

<% } %>