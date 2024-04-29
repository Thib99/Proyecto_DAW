<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List,tienda.*" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Producto</title>
    
    <script src="js/manage_cart.js"></script>
    <script src="js/alert.js"></script>
</head>

<body>
    <%
	AccesoBD con=AccesoBD.getInstance();
    List<String> categorias = con.getAllCategoria();
    List<ProductoBD> productos ;
    String categoria = request.getParameter("categoria");
    if (categoria != null && !categoria.equals("todos")){
        productos = con.obtenerProductosBD(categoria);
    }else{
        productos = con.obtenerProductosBD();
    }


    %>
    
    <div class="container mx-auto my-3">
        <div class="m-4">

            <form method="GET" action="producto.jsp">
                <label for="categoria">Categoría:</label>
                <select name="categoria" id="categoria" onchange="this.form.submit();">
                    <option value="todos" selected>Todos</option>
                    <% for (int i = 0 ; i < categorias.size() ; i++){
                        if (categoria != null && categoria.equals(categorias.get(i))){ %>
                            <option value="<%= categorias.get(i) %>" selected ><%= categorias.get(i) %></option>
                    <% }else{ %>
                            <option value="<%= categorias.get(i) %>" ><%= categorias.get(i) %></option>
                    <% }
                    } %>
                </select>
            </form>
        </div>
        

        

        <div class="row gx-2 gy-3">

    <% if (productos.size() == 0){ %>
        <div>
            <h1 class="text-center">No hay productos en esta categoría</h1>
        </div>
    <% } %>

    <% for (int i = 0 ; i < productos.size() ; i++){ 
        ProductoBD producto = productos.get(i);
    %>

        <div class="col-6 col-md-3 col-xxl-2">
                <div class="card">
                    <div class="card-img-top">
                        <div id="carousel_<%= i %>" class="carousel slide" data-bs-pause="true" data-bs-touch="true">
                            <div class="carousel-indicators">
                                <button type="button" data-bs-target="#carousel_<%= i %>" data-bs-slide-to="0" class="active"
                                    aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#carousel_<%= i %>" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                                <button type="button" data-bs-target="#carousel_<%= i %>" data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                            </div>
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="<%= producto.getImagen1() %>" class="d-block w-100" alt="<%= producto.getDescripcion() %>">
                                </div>
                                <% if (producto.getImagen2() != null){ %>
                                    <div class="carousel-item">
                                        <img src="<%= producto.getImagen2() %>" class="d-block w-100" alt="<%= producto.getDescripcion() %>">
                                    </div>
                                <% } %>
                                <% if (producto.getImagen3() != null){ %>
                                    <div class="carousel-item">
                                        <img src="<%= producto.getImagen3() %>" class="d-block w-100" alt="<%= producto.getDescripcion() %>">
                                    </div>
                                <% } %>
                               
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carousel_<%= i %>"
                                data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carousel_<%= i %>"
                                data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                    <div class="card-body">

                        <h4 class="text-center card-title" ><%= producto.getDescripcion() %> </h4>
                        <p class="text-center card-text" > <%= producto.getPrecio() %>€ </p>
                    </div>
                    <div class="card-footer">
                        <% if (producto.getStock() <= 0){ %>
                            <p class="text-center card-text" >Producto agotado</p>
                        <% } else{%>
                        <div class="input-group justify-content-center">
                            <form >
                                <input class="form-control-sm text-center" type="number" value="1" min="1" max="<%= Math.max(producto.getStock(), 10) %>"
                                name="nbr_prod" >
                                <button class="btn btn-primary" type="button"
                                onclick="agregarProducto(<%= producto.getCodigo()%>, ' <%= producto.getDescripcion()%> ' , this.form[0].value,  <%= producto.getPrecio()%>, '<%= producto.getImagen1()%>');">
                                                    Comprar
                                                </button>
                            </form>
                        </div>
                        <% } %>
                    </div>


                </div>
            </div>

    <% } %>

        </div>
    </div>
            
    

    <script src="./js/navbar_footer.js"></script>

    <% if (session.getAttribute("nombre") != null) { %>
    <script> updateNameUser("<%=session.getAttribute("nombre") %>") ; </script>
    <% } %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>