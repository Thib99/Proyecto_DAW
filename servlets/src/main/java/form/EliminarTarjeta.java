package form;

import tienda.AccesoBD;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class EliminarTarjeta extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();

        // protect for brut force attack with just the url 
        if (session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/conexion.jsp");
            return;
        }

        int codigo_card = Integer.parseInt(request.getParameter("id_card"));
       
        int status = con.deleteTarjeta(codigo_card);

        String msg = ""; 
        String type = "danger" ;
        switch (status) {
            case 1:
                msg = "Tarjeta eliminada correctamente";
                type = "success";
                break;
            default:
                msg = "Error al eliminar la tarjeta, intente de nuevo mas tarde";
                break;
        }

        session.setAttribute("notification_msg", msg);
        session.setAttribute("notification_type", type);


        String url= request.getContextPath() + "/usuario.jsp#tarjetas";
        response.sendRedirect(url);
    }
} 
