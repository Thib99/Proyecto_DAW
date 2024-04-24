function createHeaderAndFooter() {
  var head = `
            <<!-- custom css -->
            <link rel="stylesheet" href="./css/footer.css">
        
            <!-- bootstrap css -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        
            <!-- bootstrap icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            
        
            <link rel="icon" type="image/svg" href="./img/logo_icone.svg">
    `;

  var navbar = `
        <div class="sticky-md-top">
            <nav class="navbar navbar-expand-md py-3 color-grey-custom">
                <div class="container">  
                    
                    <a class="navbar-brand d-flex align-items-center" href="index.jsp">
                    <img src="./img/logo_icone.svg" alt="logo" height="60" width="60">
                        
                        <span>Ceni Shop</span>
                    </a>
                        
                    <button data-bs-toggle="collapse" class="navbar-toggler" data-bs-target="#navcol-3" ><span class="visually-hidden">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
                
                    <div class="collapse navbar-collapse" id="navcol-3">
                        <ul class="navbar-nav mx-auto">
                            <li class="nav-item"><a class="nav-link active" href="producto.jsp">Producto</a></li>
                            <li class="nav-item"><a class="nav-link" href="empresa.jsp">Empresa</a></li>
                            <li class="nav-item"><a class="nav-link" href="contacto.jsp">Contacto</a></li>
                            <li class="nav-item"><a class="nav-link" href="usuario.jsp" id="usuario_tab">Usuario</a></li>
                        </ul>

                        <ul class="navbar-nav mx-auto">


                            <li class="nav-item">
                                <a  href="carrito.jsp">
                                    <span class="m-sm-2">
                                        <button type="button" class="btn btn-outline-secondary">Carrito<span class="p-1"><i class="bi bi-cart3"></i></span></button>
                                    </span>
                                </a>
                            </li>
                            
                            <li class="nav-item" id="action_con">
                                <a  href="conexion.jsp">
                                    <span class="my-2 mt-md-0">
                                        <button class="btn btn-primary">Iniciar sesión&nbsp;
                                        <i class="bi bi-lock-fill"></i></button>
                                    </span>
                                </a>
                            </li>
                        </ul>
                        </div>
                </div>
            </nav>
        </div>
        `;

  var footer = `
        <footer class="footer mt-auto text-center" >
            <div class="container text-muted py-4 py-lg-5">

                <div class="row ">

                    <div class="col-md-6">

                        <h5>Información de contacto</h5>

                        <ul class="list-unstyled">

                            <li class="mt-1">
                                <p> 
                                    <span class="mr-1"> <i class="bi bi-telephone"></i></span>
                                    <a href="tel:+3412345678907" class="rm-base">+34 (123) 456-7890</a>
                                </p>
                            </li>
                            
                            <li class="mt-1">
                                <p>
                                    <span class="mr-1"> <i class="bi bi-geo-alt"></i></span>
                                    <a href="https://maps.app.goo.gl/VR7Pww63RcEGFFQN6" target="_blank" class="rm-base">Burjasot, España</a>
                                </p>
                            </li>
                            
                            <li class="mt-1">
                                <a href="contacto.html"> <p>Más información</p></a>
                            </li>
                            
                        </ul>
                    </div>
                    
                    
                    <div class="col-md-6 text-md-right">
                        
                            <h5>Follow Us</h5>

                            <ul class="list-inline">
                                <li class="list-inline-item mx-4">
                                    <a href="https://facebook.com" class="rm-base dark-text">
                                        <i class="bi bi-facebook fs-2"></i>
                                    </a>
                                </li>
                                <li class="list-inline-item mx-4">
                                    <a href="https://x.com" class="rm-base dark-text">
                                        <i class="bi bi-twitter fs-2"></i>
                                    </a>
                                </li>
                                
                                <li class="list-inline-item mx-4">
                                    <a href="https://instagram.com" class="rm-base dark-text">
                                        <i class="bi bi-instagram fs-2"></i>
                                    </a>
                                </li>
                                    
                            </ul>
                    </div>

                </div>
                        
                <p class="mb-0">Copyright © Thibault POUX</p>
            </div>
        </footer>
        `;

  // modify the body to use flexbox
  document.body.className = `d-flex flex-column min-vh-100`;

  // add all the element of a standard html page
  document.head.innerHTML += head;

  document.body.innerHTML = navbar + document.body.innerHTML + footer;

  // update the navbar to show the user name
  updateNavBar();
}

window.addEventListener("load", function () {
  createHeaderAndFooter();
});

function cerrarSesion() {
  sessionStorage.clear();
  window.location.href = "api/desconexion";
}

function updateNameUser(nombre_usuario) {
    sessionStorage.setItem("nombre_usuario", nombre_usuario);
    
    // if the navbar is already loaded, update it, ortherwise it will be updated when the navbar is loaded
    updateNavBar(); 
}

function updateNavBar() {

  if (sessionStorage.getItem("nombre_usuario") != null && document.getElementById("usuario_tab") != null ) { //check if a usuer appears has login in the session and if the navbar is present
    var cerrar_session = `
        <a  href="javascript:cerrarSesion()">
            <span class="m-2">
                <button class="btn btn-primary">Cerrar sesión&nbsp;</button>
            </span>
        </a>
        `;

    document.getElementById("usuario_tab").innerText = sessionStorage.getItem("nombre_usuario");
    document.getElementById("action_con").innerHTML = cerrar_session;
    sessionStorage.removeItem("nombre_usuario");
  }
}
