# Proyecto_DAW

Por Thibault Poux

## Una aplicación web en JSP, Servlets y PHP

---

### Usuarios existentes:

* Pierre Dupond :

    **Usuario:** pierre.dupond@gmail.com
    **Contraseña:** Azerty1

* Juan Garcia :

    **Usuario:** juan.garcia@digi.es
    **Contraseña:** MisContrasena2

### Usuario admin :

* Pablo Messi :

    **Usuario:** admin@website.fr   
    **Contraseña:** Azerty1

### Información:

* **Base de datos:**
    * El archivo "struct.sql" contiene todas las órdenes SQL para crear la base de datos.
    * El archivo "struct_+_data.sql" contiene todas las tablas de datos y algunos datos de demostración.
* **Docker:**
    Para iniciar el proyecto con una sola línea de comando, ejecute la siguiente línea en la raíz del proyecto:

        docker-compose up

    URL :
    * El Servelts tiene el url :

        http://localhost:8081/servlets/
    * El php tiene el url :

        http://localhost:3001/

        

    Información:
    * "docker" y "docker-compose" deben estar instalados.
    * Esta comando solo funciona en Linux o WSL (con Docker Desktop Windows)

### Funcionalidades del servlets

* **Productos:**
    * Están organizados por categoría.
    * Tienen 3 imágenes.

* **Pedidos:**
    * Se pueden cancelar.
    * Se pueden volver a pedir.

* **Usuarios:**
    * Se pueden modificar sus datos.
    * Se pueden eliminar sus tarjetas bancarias.
    * Se puede ver el detalle completo de sus pedidos.

* **Carrito:**
    * Permite modificar la cantidad de un producto.
    * Permite eliminar un producto.
    * Al presionar el botón de pedido, se realiza una solicitud al servidor para verificar la disponibilidad y se ajustan las cantidades según sea necesario.

* **Pago:**
    * Permite agregar tarjetas de pago.
    * Permite seleccionar tarjetas ya registradas.
    * Envía el carrito con una solicitud ajax.

* **Contacto:**
    * Los datos del formulario de contacto se agregan a la base de datos.
