package form;

import tienda.AccesoBD;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class CambiarPassword extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();
        
        String password_nueva_1 = request.getParameter("password_nueva_1");
        String password_nueva_2 = request.getParameter("password_nueva_2");
        String password = request.getParameter("password");
        int codigo = (int) session.getAttribute("usuario");

        String mensaje = "";
        String type = "danger";

        if (!password_nueva_1.equals(password_nueva_2)) {
            mensaje = "Las nuevas contraseñas no coinciden";
        } else {
            int state  = con.updatePassword(codigo, password, password_nueva_1) ;
            if (state == 1) {
                mensaje = "Contraseña actualizada correctamente";
                type = "success";
            } else if (state == 0) {
                mensaje = "Contraseña incorrecta";
            } else {
                mensaje = "Error al actualizar la contraseña";
            }
        }

        session.setAttribute("notification_msg", mensaje);
        session.setAttribute("notification_type", type);
        




        String url= request.getContextPath() + "/usuario.jsp#contrasena";
        response.sendRedirect(url);
    }
} 
