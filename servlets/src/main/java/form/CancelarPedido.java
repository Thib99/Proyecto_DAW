package form;

import tienda.AccesoBD;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CancelarPedido extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();

        if (session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/conexion.jsp");
            return;
        }
       
        int codigo_pedido = Integer.parseInt(request.getParameter("id_pedido"));

        int status = con.cancelarPedido(codigo_pedido);

        String msg = ""; 
        String type = "danger" ;
        switch (status) {
            case 1:
                msg = "Pedido cancelado correctamente";
                type = "success";
                break;
            case -2 :
                msg = "No se ha encontrado el pedido en la base de datos";
                break;
            case -3 :
                msg = "El pedido no se encuentra en estado preparando";
                break;
            default:
                msg = "Error al cancelar el pedido";
                break;
        }

        session.setAttribute("notification_msg", msg);
        session.setAttribute("notification_type", type);


        String url= request.getContextPath() + "/usuario.jsp#pedidos";
        response.sendRedirect(url);
    }
} 
