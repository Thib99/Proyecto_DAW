// guardar datos de form
form_datos = {};

// Need to be call with the direct link to the form 
// and optionnal the writable status as a boolean
function change_disabled(form) {

    // get all the input field in this form
    let inputs = form.elements;
    const id = inputs.namedItem('codigo').value;
    // console.log(id);
    let disabled = ! inputs[1].disabled;

    input_value = [];
    for (let i = 1; i < inputs.length; i++) {
        if (inputs[i].nodeName == 'BUTTON') {
            
            
            if (inputs[i].classList.contains('d-none')) {
                inputs[i].classList.remove('d-none');
                inputs[i].disabled = false;
            }
            else {
                inputs[i].disabled = true;
                inputs[i].classList.add('d-none');
            }
        }
        else if(inputs[i].nodeName == 'INPUT' && inputs[i].type == 'file'){
            let img  = inputs[i].nextElementSibling;
            if (disabled) {
                img.src = form_datos[id][i-1];
            }else {
                input_value.push(img.src);
            }
            inputs[i].disabled =  disabled;
        }
        else if(inputs[i].nodeName == 'INPUT' && inputs[i].type == 'checkbox'){
            if (disabled) {
                inputs[i].checked = form_datos[id][i-1];
            }else {
                input_value.push(inputs[i].checked);
            }
            inputs[i].disabled =  disabled;
        }

        else if (inputs[i].nodeName == 'INPUT' || inputs[i].nodeName == 'SELECT' ){

            if (disabled) {
               inputs[i].value = form_datos[id][i-1];
            }else{
                // guard the value of the input
                input_value.push(inputs[i].value);
            }

            // if disabled is true, remove the disabled attribute from the input
            inputs[i].disabled =  disabled;
        }
    }
    form_datos[id] = input_value;
}


