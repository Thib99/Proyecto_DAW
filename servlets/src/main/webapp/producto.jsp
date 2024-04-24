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
	List<ProductoBD> productos = con.obtenerProductosBD();
    %>
        

    <div class="container mx-auto my-3">
        <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="producto.jsp">Productos</a></li>
            <li class="breadcrumb-item active" aria-current="page">Type</li>
        </ol>
        </nav>

        <div class="row">
            <div class="col-md-2 offset-10">
                <select class="form-select" aria-label="Default select example">
                    <option selected>Todos</option>
                    <option value="1">One</option>
                    <option value="2">Two</option>
                    <option value="3">Three</option>
                </select>
            </div>
        </div>

        <div class="row gx-2 gy-3">


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
            
    <!-- Pagina -->
    <nav class="mt-3">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                </a>
            </li>
            <li class="page-item active" aria-current="page">
                <a class="page-link" href="#">1</a>
            </li>
            <li class="page-item">
                <a class="page-link" href="#">2</a>
            </li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                </a>
            </li>
        </ul>
    </nav>

    <script src="./js/navbar_footer.js"></script>

    <% if (session.getAttribute("nombre") != null) { %>
    <script> updateNameUser("<%=session.getAttribute("nombre") %>") ; </script>
    <% } %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>