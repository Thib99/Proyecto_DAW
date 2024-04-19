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
        

        System.out.println("\nNuevo pedido\n");        
        PedidoBD pedido = new PedidoBD();

        JsonReader jsonReader = Json.createReader(
                new InputStreamReader(
                        request.getInputStream(), "utf-8"));

        JsonArray jobj = jsonReader.readArray();

        HttpSession session = request.getSession();
        pedido.setCodigo_usuario((int) session.getAttribute("usuario"));
        pedido.setCodigo_estado(1); // 1 = preparando
        
        System.out.println("plusloin");

        System.out.println(jobj.toString());
        // calculate precio
        float precioTotal = 0;

        System.out.println("Productos: " + jobj.size());

        for (int i = 0; i < jobj.size(); i++) {
            try {

                JsonObject prod = jobj.getJsonObject(i);
                DetallePedido detalle = pedido.new DetallePedido();
                detalle.setPrecio(Float.parseFloat(prod.get("precio").toString()));
                detalle.setCantidad(Integer.parseInt(prod.get("cantidad").toString()));
                detalle.setCodigo_producto(Integer.parseInt(prod.get("codigo").toString()));
                pedido.getDetalle().add(detalle);
    
                precioTotal += detalle.getPrecio() * detalle.getCantidad();
    
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }
        }
        System.out.println("Precio total: " + precioTotal);
        pedido.setPrecio(precioTotal); // set precio total

        AccesoBD con = AccesoBD.getInstance();

        int status = con.addPedido(pedido);

        if (status == 1) {
            session.setAttribute("notification_msg", "Pedido realizado correctamente");
            session.setAttribute("notification_type", "success");
        } else {
            session.setAttribute("notification_msg", "Error al realizar el pedido");
            session.setAttribute("notification_type", "danger");
        }

        // String url = request.getContextPath() + "/carrito.jsp";
        //response.sendRedirect(url);

    }
}
