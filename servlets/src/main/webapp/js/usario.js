


// Need to be call with the direct link to the form 
// and optionnal the writable status as a boolean
function change_readonly(form) {

    // get all the input field in this form
    let inputs = form.getElementsByTagName('input');

    for (let i = 0; i < inputs.length; i++) {
        
        // if writable is true, remove the readonly attribute and add the form-control class to the input
        inputs[i].readOnly = ! inputs[i].readOnly ;
        if ( ! inputs[i].readOnly) {
            inputs[i].classList.remove('form-control-plaintext');
            inputs[i].classList.add('form-control');
        } else {
            inputs[i].classList.remove('form-control');
            inputs[i].classList.add('form-control-plaintext');
        }

    }

    if(inputs[0].readOnly){
        form.getElementsByTagName('button')[0].innerHTML = 'Cambiar datos <i class="bi bi-lock-fill"></i>';
    } else {
        form.getElementsByTagName('button')[0].innerHTML = 'Cambiar datos <i class="bi bi-unlock"></i>';
    }

   
}

// to change the info in the card body, when pressing a tab
function change_data_card(tab){

    let content = document.getElementById('content_block');
    
    // get all the tab option
    let nav_option = document.getElementById('nav-datos').getElementsByTagName('a');

    // remove the active class from all the tab
    for (let i = 0; i < nav_option.length; i++) {
        nav_option[i].classList.remove('active');
    }

    //append the content to the card
    switch(tab){
        case 'datos':
            content.innerHTML = datos();
            nav_option[0].classList.add('active');
            break;
        case 'pedidos':
            content.innerHTML = pedidos();
            nav_option[1].classList.add('active');
            break;
        case 'contrasena':
            content.innerHTML = cambiar_contrasena();
            nav_option[2].classList.add('active');
            break;
    }

    return ;       

}

// by default show the mis-datos tab
window.addEventListener("load", function(){
    change_data_card('datos');
});


// All the html content for the different tab

function pedidos(){
    return `
        <div class="container">
            <div class="accordion" id="accordionMain">
                <div class="accordion-item">
                    <h2 class="accordion-header">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        Encargo en curso
                    </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionMain">
                    <div class="accordion-body">
                    <div class="table-responsive">
                        <table class="table table-bordered w-100 text-center">
                            <tr>
                                <th>Producto</th>
                                <th>Fecha de pedido</th>
                                <th>Estado</th>
                                <th>Precio</th>
                                <th>Nbr products</th>
                                <th>Cancelar</th>
                            </tr>
                            <tr>
                                <td>Producto 1</td>
                                <td>Fecha 1</td>
                                <td>Prepapración</td>
                                <td>200</td>
                                <td>3</td>
                                <td><a href="#" class="rm-base"><i class="bi bi-x-lg"></i></a></td>
                                
                            </tr>
                            <tr>
                                <td>Producto 2</td>
                                <td>Fecha 2</td>
                                <td>Prepapración</td>
                                <td>400</td>
                                <td>6</td>
                                <td><a href="#" class="rm-base"><i class="bi bi-x-lg"></i></a></td>
                                
                            </tr>
                        </table>
                    </div>
                    </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        Pedido entregado
                    </button>
                    </h2>
                    <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionMain">
                    <div class="accordion-body">
                    <div class="table-responsive">
                        <table class="table table-bordered w-100 text-center">
                            <tr>
                                <th>Producto</th>
                                <th>Fecha de entrega</th>
                                <th>Precio</th>
                                <th>Nbr products</th>
                                <th>Volver a pedir</th>
                            </tr>
                            <tr>
                                <td>Producto 1</td>
                                <td>Fecha 1</td>
                                <td>200</td>
                                <td>3</td>
                                <td><a href="#" class="rm-base"><i class="bi bi-arrow-repeat"></i></a></td>
                                
                            </tr>
                            <tr>
                                <td>Producto 2</td>
                                <td>Fecha 2</td>
                                <td>400</td>
                                <td>6</td>
                                <td><a href="#" class="rm-base"><i class="bi bi-arrow-repeat"></i></a></td>
                                
                            </tr>
                        </table>  
                    </div>
                    </div>
                    </div>
                </div>
                
                </div>


`;
}

function cambiar_contrasena(){
    return `
    <div class="row mt-3">
        <div class="col-sm-8 mx-auto">
            <div class="container p-2">
                <form action="" method="POST" class="mb-2">
                    <div class="form-floating mb-3 mx-2">
                        <input type="password" class="form-control" id="floatingpassword"
                            placeholder="Contraseña" required>
                        <label for="floatingpassword">Contraseña anteriore</label>
                    </div>
                    <div class="form-floating mb-3 mx-2">
                        <input type="password" class="form-control" id="floatingpassword_nueva_1"
                            placeholder="Contraseña" required>
                        <label for="floatingpassword_nueva_1">Nueva contraseña</label>
                    </div>
                    <div class="form-floating mb-3 mx-2">
                        <input type="password" class="form-control" id="floatingpassword_nueva_2"
                            placeholder="Contraseña" required>
                        <label for="floatingpassword_nueva_2">Reescribir la nueva contraseña</label>
                    </div>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mx-5">
                        <button class="btn btn-primary" type="submit">Cambiar<i
                                class="bi bi-person-plus-fill"></i></button>
                    </div>
                </form>
            </div>
        </div>
    </div>` ;
}

function datos(){
    return `
    <div class="container p-4">
                    <form action="" method="POST" id="form1">

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="apellido" class="col-form-label"><b> Apellido: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="apellido" name="apellido" readonly
                                    value="Garcia">
                            </div>

                            <div class="col-md-6">
                                <label for="nombre" class="col-form-label"> <b> Nombre: </b> </label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="nombre" name="nombre" readonly
                                    value="Jose">
                            </div>

                            <div class="col-md-6">
                                <label for="tel" class="col-form-label"> <b>Telefono: </b> </label>
                                <input type="tel" class="form-control-plaintext px-1 mx-2" id="tel" name="tel" readonly
                                    value="+123456789">
                            </div>

                            <div class="col-md-6">
                                <label for="fecha_nac" class="col-form-label"> <b>Fecha de nacimiento: </b></label>
                                <input type="date" class="form-control-plaintext px-1 mx-2" id="fecha_nac" name="fecha_nac"
                                    readonly value="2014-02-09">
                            </div>
                        </div>


                        <div class="mb-3 row">
                            <label for="email" class="col-form-label"> <b>Correo: </b></label>
                            <div class="col">
                                <input type="email" class="form-control-plaintext px-1 mx-2" id="email" name="email" readonly
                                    value="jose.garcia@mail.com">
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-12">
                                <label for="calle" class="form-label"><b>Calle y numero: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="calle" readonly placeholder="Av. Peris, 43" 
                                    value="Av. Peris, 43">
                            </div>
                            <div class="col-md-6">
                                <label for="ciudad" class="form-label"><b>Ciudad: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="ciudad" readonly value="Valencia">
                            </div>
                            <div class="col-md-2">
                                <label for="CP" class="form-label"><b>CP:</b></label>
                                <input type="number" class="form-control-plaintext px-1 mx-2" id="CP" readonly value="46000">
                            </div>
                            <div class="col-md-4">
                                <label for="pais" class="form-label"><b>País: </b></label>
                                <input type="text" class="form-control-plaintext px-1 mx-2" id="pais" readonly value="España">

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
                
    `;
}

