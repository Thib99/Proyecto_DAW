<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8" %>

<%  
    // to remove
    
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("conexion.jsp?url="+request.getRequestURI());
    }else {
%>

<!DOCTYPE html>
<html data-bs-theme="light" lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Mi cuenta</title>
    
    <!-- <link rel="stylesheet" href="css/usario.css"> -->
    <script src="./js/navbar_footer.js"></script>
    <script src="./js/usuario.js"></script>
    <script src="./js/alert.js"></script>


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
                                    <a class="nav-link"  onclick="change_data_card('pedidos')">Mis pedidos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" onclick="change_data_card('contrasena')">Cambiar contraseña</a>
                            </li>
                        </ul>
                    </div>
                    <div class="card-body" id="content_block">
                        <section id="datos">
                        <%
                        AccesoBD con=AccesoBD.getInstance();
	                    UsuarioBD usuario = con.obtenerUsuarioBD( (int)session.getAttribute("usuario")); ;
                        %>
                        <div class="container p-4">
                        
                        
                    <form action="form/cambiardatos" method="POST" id="form1">

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="apellido" class="col-form-label"><b> Apellido: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="apellido" name="apellido" readonly
                                    value="<%= usuario.getApellidos() %>">
                            </div>

                            <div class="col-md-6">
                                <label for="nombre" class="col-form-label"> <b> Nombre: </b> </label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="nombre" name="nombre" readonly
                                    value="<%= usuario.getNombre() %>">
                            </div>

                            <div class="col-md-6">
                                <label for="telefono" class="col-form-label"> <b>Telefono: </b> </label>
                                <input type="telefono" class="form-control-plaintext px-1 mx-2" id="telefono" name="telefono" readonly
                                    value="<%= usuario.getTelefono() %>">
                            </div>

                            <div class="col-md-6">
                                <label for="fechaNac" class="col-form-label"> <b>Fecha de nacimiento: </b></label>
                                <input type="date" class="form-control-plaintext px-1 mx-2" id="fechaNac" name="fechaNac"
                                    readonly value="<%= usuario.getFechaNac() %>">
                            </div>
                        </div>


                        <div class="mb-3 row">
                            <label for="correo" class="col-form-label"> <b>Correo: </b></label>
                            <div class="col">
                                <input type="correo" class="form-control-plaintext px-1 mx-2" id="correo" name="correo" readonly
                                    value="<%= usuario.getCorreo() %>">
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-12">
                                <label for="domicilio" class="form-label"><b>Calle y número: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="domicilio" name="domicilio" readonly placeholder="Av. Peris, 43" 
                                    value="<%= usuario.getDomicilio() %>">
                            </div>
                            <div class="col-md-6">
                                <label for="poblacion" class="form-label"><b>Ciudad: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="poblacion" name="poblacion" readonly value="<%= usuario.getPoblacion() %>">
                            </div>
                            <div class="col-md-2">
                                <label for="cp" class="form-label"><b>CP:</b></label>
                                <input type="number" class="form-control-plaintext px-1 mx-2" id="cp" name="cp" readonly value="<%= usuario.getCp() %>">
                            </div>
                            <div class="col-md-4">
                                <label for="pais" class="form-label"><b>Provincia: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="pais" name="pais" readonly value="<%= usuario.getPais() %>">

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
                        <%
                        List<PedidoBD> pedidos = con.getAllPedidos((int)session.getAttribute("usuario"));
                        %>
                        <div class="container">
                        <div class="accordion" id="accordion_div">
                        <% if (pedidos.size() == 0) { %>
                           <p class="text-center"> No hay pedidos ! </p>
                        <% } %>
                        <% for (int i = 0 ; i < pedidos.size() ; i++) { 
                            PedidoBD pedido = pedidos.get(i);
                            boolean boolean_first = (i==0) ;
                            String id = "accordion_"+i;
                        %>
                        
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#<%= id %>" aria-expanded="<%= boolean_first ? "true" :"false" %>" aria-controls="<%= id %>">
                                        <div class="d-flex justify-content-between">
                                          <div class="p-2">Pedido del <%= pedido.getFecha() %></div>
                                          <div class="p-2"> <b> <%= pedido.getEstado() %> </b> </div>
                                        </div>
                                    </button>
                                </h2>
                                <div id="<%= id %>" class="accordion-collapse collapse <%= boolean_first ? "show" :"" %>" data-bs-parent="#accordion_div">
                                    <div class="accordion-body">
                                        <div class="d-flex justify-content-around align-items-center">
                                            <div class="p-2"><b> Precio: </b> <%= pedido.getPrecio() %> €</div>
                                            <div class="p-2"> <b> Cantidad de productos: </b> <%= pedido.getNombre_producto() %></div>
                                            <div class="p-2">
                                                
                                                <% if (pedido.getCodigo_estado()== 1) { %>
                                                    <form action="form/cancelarpedido" method="GET">
                                                        <input type="hidden" name="id_pedido" value="<%= pedido.getCodigo() %>">
                                                        <button type="submit" class="btn btn-danger">Cancelar pedido <i class="bi bi-trash"></i> </button>
                                                    </form>
                                                <% }else { %>
                                                    <form action="form/recomendarpedido" method="GET">
                                                        <input type="hidden" name="id_pedido" value="<%= pedido.getCodigo() %>">
                                                        <button type="submit" class="btn btn-success">Volver a recomendar <i class="bi bi-arrow-repeat"></i> </button>
                                                    </form>
                                                <% } %>
                                            </div>
                                        </div>
                                

                                        <div class="table-responsive">

                                            <table class="table table-bordered w-100 text-center">
                                                <tr>
                                                    <th>Producto</th>
                                                    <th>Precio unitario</th>
                                                    <th>Nbr products</th>
                                                    <th>Precio total</th>
                                                </tr>
                                                <% for(PedidoBD.DetallePedido detalle : pedido.getDetalle()){ %>
                                                <tr>
                                                    <td><%= detalle.getNombre_producto() %></td>
                                                    <td><%= detalle.getPrecio() %></td>
                                                    <td><%= detalle.getCantidad() %></td>
                                                    <td><%= detalle.getCantidad()* detalle.getPrecio() %></td>
                                                    
                                                    
                                                </tr>
                                                <% } %>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        <% } %>    
                    
                        </div>
                        </div>
                

                        </section>

                        <section id="cambiar_contrasena">
                        <%
                        String mensaje = (String)session.getAttribute("mensaje");

                        if (mensaje != null) {
                        %>
                        <%-- Eliminamos el mensaje consumido --%>
                        <%
                            session.removeAttribute("mensaje");
                        %>
                        <p class="text-center"> <%=mensaje%> </p>
                        <%
                        }
                        %>
                            <div class="row mt-3">
                                <div class="col-sm-8 mx-auto">
                                    <div class="container p-2">
                                        <form action="form/cambiarcontrasena" method="POST" class="mb-2">
                                            <div class="form-floating mb-3 mx-2">
                                                <input type="password" class="form-control" id="password" name="password"
                                                    placeholder="Contraseña" required>
                                                <label for="password">Contraseña anteriore</label>
                                            </div>
                                            <div class="form-floating mb-3 mx-2">
                                                <input type="password" class="form-control" id="password_nueva_1" name="password_nueva_1"
                                                    placeholder="Contraseña" required>
                                                <label for="password_nueva_1">Nueva contraseña</label>
                                            </div>
                                            <div class="form-floating mb-3 mx-2">
                                                <input type="password" class="form-control" id="password_nueva_2" name="password_nueva_2"
                                                    placeholder="Contraseña" required>
                                                <label for="password_nueva_2">Reescribir la nueva contraseña</label>
                                            </div>
                                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mx-5">
                                                <button class="btn btn-primary" type="submit">Cambiar</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <section id="mis_tarjetas">
                            
                        </section>

                    </div>
                </div>


            </div>
        </div>

    </div>

   <% if (session.getAttribute("nombre") != null) { %>
    <script> updateNameUser("<%=session.getAttribute("nombre") %>") ; </script>
    <% } %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
    <%
    }
    %>