
window.addEventListener("load", createHeader);
window.addEventListener("load", changeTabsFocus);

function createHeader() {

    var head = `
        
            <!-- bootstrap css -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
        
            <!-- bootstrap icons -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            
            <!-- custom css -->
            <link rel="stylesheet" href="css/common.css">    

        
            <link rel="icon" type="image/svg" href="img/logo_icone.svg">
    `;

    var navbar = `
        <div class="sticky-md-top">

            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">Ceni Shop</a>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbar_tabs">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item">
                                <a class="nav-link" aria-current="page" href="productos.php" name="nav_link_item" >Productos
                                    <i class="bi bi-database"></i>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="usuarios.php" name="nav_link_item"  >Usuarios
                                    <i class="bi bi-person"></i>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="pedidos.php" name="nav_link_item" >Pedidos
                                    <i class="bi bi-box-seam"></i>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="consultas.php" name="nav_link_item" >Consultas
                                    <i class="bi bi-chat-text"></i>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="cuidado.php" name="nav_link_item" >Dinero
                                    <i class="bi bi-currency-euro"></i>
                                </a>
                            </li>
                        </ul>


                        <ul class="navbar-nav ml-auto" id="action_con">
                            <li class="nav-item">
                                <a class="nav-link" href="conexion.php" name="nav_link_item">Iniciar sesión<i class="bi bi-lock"></i></a>
                            </li>
                        </ul>

                    </div>
                </div>
            </nav>
        </div>
        `;


    // modify the body to use flexbox
    // document.body.className = `d-flex flex-column min-vh-100`;


    // add all the element of a standard html page
    document.head.innerHTML += head;
    document.body.innerHTML = navbar + document.body.innerHTML;
    updateNavBar();
}

function changeTabsFocus() {

    // get the name of the html to know which tab to focus
    var url = window.location.pathname;
    var filename = url.substring(url.lastIndexOf('/') + 1);


    const tab_names= ["productos.php", "usuarios.php", "pedidos.php", "consultas.php", "cuidado.php", "conexion.php"] ;


    var tabs  = document.getElementById("navbar_tabs").querySelectorAll("a[name='nav_link_item']");

    for (var i = 0; i < tabs.length; i++) {
        if (filename == tab_names[i]) {
            tabs[i].classList.add("active");
        }
    }
}

function is_connect(id){
    sessionStorage.setItem("usuario_id", id);
}

function cerrarSesion() {
    sessionStorage.clear();
    window.location.href = "form/desconexion.php";
}

function updateNavBar() {

    if (sessionStorage.getItem("usuario_id") != null && document.getElementById("action_con") != null ) { //check if a user appears has login in the session and if the navbar is present
      var cerrar_session = `
            <li class="nav-item">
                <a class="nav-link" onclick="cerrarSesion();" name="nav_link_item">Cerrar sesión&nbsp;</a>
            </li>
          `;
  
      document.getElementById("action_con").innerHTML = cerrar_session;
      sessionStorage.removeItem("usuario_id");
    }
  }