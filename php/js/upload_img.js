function selectImage(block_img) {
    // console.log(block_img);
    var input = block_img.querySelector('input[type="file"]');
    var image = block_img.querySelector('img');
    input.click();

    input.addEventListener('change', function() {
        displayImage(input, image);
    });
}

function displayImage(input, image) {

    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
            image.src = e.target.result;
        };

        reader.readAsDataURL(input.files[0]);
    } else {
        // Handle case when no file is selected
        image.src = "img/placeholder-img.jpg" ;
    }
    
}