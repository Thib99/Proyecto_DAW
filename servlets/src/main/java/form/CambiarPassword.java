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



        if (!password_nueva_1.equals(password_nueva_2)) {
            session.setAttribute("mensaje_CambiarPassword", "Las nuevas contraseñas no coinciden");
        } else {
            int state  = con.updatePassword(codigo, password, password_nueva_1) ;
            if (state == 1) {
                session.setAttribute("notification_msg", "Contraseña actualizada correctamente");
                session.setAttribute("notification_type", "success");
            } else if (state == 0) {
                session.setAttribute("mensaje_CambiarPassword", "Contraseña incorrecta");
            } else {
                session.setAttribute("mensaje_CambiarPassword", "Error al actualizar la contraseña");
            }
        }
        




        String url= request.getContextPath() + "/usuario.jsp#contrasena";
        response.sendRedirect(url);
    }
} 
