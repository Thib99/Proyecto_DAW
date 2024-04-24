package form;

import tienda.AccesoBD;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Contacto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();
        
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String apellido = request.getParameter("apellido");
        String comentario = request.getParameter("comentario");

        int status = con.addComContacto(nombre, correo, apellido, comentario) ;

        if (status == 1) {
            session.setAttribute("notification_msg", "Formulario de contacto enviado correctamente");
            session.setAttribute("notification_type", "success");
        } else {
            session.setAttribute("notification_msg", "Error al enviar del formulario de contacto");
            session.setAttribute("notification_type", "danger");
        }


        String url= request.getContextPath() + "/contacto.jsp";
        response.sendRedirect(url);
    }
} 
