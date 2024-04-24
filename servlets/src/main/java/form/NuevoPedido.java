package form;

import tienda.AccesoBD;
import tienda.PedidoBD;
import tienda.PedidoBD.DetallePedido;

import jakarta.json.* ;
import java.io.InputStreamReader;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class NuevoPedido extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        

            
        PedidoBD pedido = new PedidoBD();

        JsonReader jsonReader = Json.createReader(
                new InputStreamReader(
                        request.getInputStream(), "utf-8"));

        JsonArray jobj = jsonReader.readArray();

        HttpSession session = request.getSession();
        pedido.setCodigo_usuario((int) session.getAttribute("usuario"));
        pedido.setCodigo_estado(1); // 1 = preparando
        
        

        
        // calculate precio
        float precioTotal = 0;


        for (int i = 0; i < jobj.size(); i++) {
            try {

                JsonObject prod = jobj.getJsonObject(i);
                DetallePedido detalle = pedido.new DetallePedido();
                detalle.setPrecio(Float.parseFloat(prod.get("precio").toString()));
                detalle.setCantidad(prod.getInt("cantidad"));
                detalle.setCodigo_producto(prod.getInt("codigo"));
                pedido.getDetalle().add(detalle);
    
                precioTotal += detalle.getPrecio() * detalle.getCantidad();
    
            } catch (Exception e) {
                System.err.println(e.getMessage());

            }
        }
        pedido.setPrecio(precioTotal); // set precio total

        AccesoBD con = AccesoBD.getInstance();

        int status = con.addPedido(pedido);

        // Create a Json Object
        JsonObjectBuilder jsonBuilder = Json.createObjectBuilder();

        if (status >=1){
            jsonBuilder.add("id_pedido", status);
        }else if (status == -3){
            jsonBuilder.add("error", "No hay suficiente stock");
        }else{
            jsonBuilder.add("error", "Error al realizar el pedido");
        }
        

        JsonObject json = jsonBuilder.build();

        // Set content type to application/json
        response.setContentType("application/json");

        // Write JSON to the response
        response.getWriter().write(json.toString());

        // plutot transformer en reponse pour ajax  
        // if (status == 1) {
        //     session.setAttribute("notification_msg", "Pedido realizado correctamente");
        //     session.setAttribute("notification_type", "success");
        // }else if (status == -3) {
        //     session.setAttribute("notification_msg", "Error al realizar el pedido, no hay suficiente stock");
        //     session.setAttribute("notification_type", "danger");
        // } 
        // else {
        //     session.setAttribute("notification_msg", "Error al realizar el pedido");
        //     session.setAttribute("notification_type", "danger");
        // }
    }
}
