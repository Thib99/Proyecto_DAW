<%@ page language="java" contentType="text/html; charset=UTF-8" import="tienda.*" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empresa</title>
    <link rel="stylesheet" href="./css/empressa.css">
</head>

<body>
    <section>
        <div class="container mt-5">
            <div class="col-md-8 mx-auto">
                <div class="shadow p-4 mb-5 bg-white rounded">

                    <h1>Nuestra empresa</h1>
                    <h2>La historia :</h2>

                    <p>Cuando llegué a España, más concretamente a Valencia en agosto de 2023, una cosa que me llamó la
                        atención mientras me fumaba un cigarrillo en el bar fue que no había ceniceros. En ninguna
                        parte. Tras preguntar varias veces por uno, siempre me decían lo mismo: ponlos en el suelo.
                        Esta respuesta no me satisfizo en absoluto, así que se me ocurrió la idea de crear ceniceros con
                        ventosas que se adhirieran a la mesa para que la gente no los dejara caer, y que fueran rápidos
                        y fáciles de vaciar. Así empezó la idea.
                    </p>

                    <h2>Nuestros objetivos : </h2>

                    <h3>Ecología</h3>
                    <p>Una colilla tarda una media de 2 años en degradarse completamente en la naturaleza, lo cual es
                        muchísimo tiempo. nuestro planeta nos es muy querido, y tirar la colilla en un cenicero es
                        rápido y fácil.
                    </p>
                    <h3>Convivencia</h3>
                    <p>Ante todo, fumar es malo para la salud.
                        Aquí hablamos de convivencia, porque fumar un cigarrillo con los amigos en un bar es un momento
                        agradable, un momento para compartir, ¡así que mejor que sea así todo el rato y que una colilla
                        en el suelo no lo estropee todo!
                    </p>
                    <h3>Estilo:
                    </h3>
                    <p>Nuestros ceniceros son discretos y de tamaño medio para que no estorben en la mesa pero tampoco
                        haya que vaciarlos con demasiada frecuencia. Además, con sus ventosas casi invisibles, no se
                        nota la diferencia con otro cenicero, aunque la practicidad marca la diferencia.</p>
                </div>
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