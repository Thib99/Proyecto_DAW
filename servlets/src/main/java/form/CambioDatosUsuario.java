package form;

import tienda.AccesoBD;
import tienda.UsuarioBD;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CambioDatosUsuario extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UsuarioBD usuario = new UsuarioBD();
        usuario.setNombre(request.getParameter("nombre"));
        usuario.setApellidos(request.getParameter("apellido"));
        usuario.setCorreo(request.getParameter("correo"));
        usuario.setFechaNac(request.getParameter("fechaNac"));
        usuario.setTelefono(request.getParameter("telefono"));
        usuario.setDomicilio(request.getParameter("domicilio"));
        usuario.setPoblacion(request.getParameter("poblacion"));
        usuario.setCp(request.getParameter("cp"));
        usuario.setPais(request.getParameter("pais"));


        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();

        int codigo = (int) session.getAttribute("usuario");
        boolean funciona = con.updateUsuario(codigo, usuario);

        if (funciona) {
            session.setAttribute("notification_msg", "Datos actualizados correctamente");
            session.setAttribute("notification_type", "success");
            session.setAttribute("nombre", usuario.getNombre());
        } else {
            session.setAttribute("notification_msg", "Error al actualizar los datos");
            session.setAttribute("notification_type", "danger");
        }

        String url= request.getContextPath() + "/usuario.jsp#datos";
        response.sendRedirect(url);
    }
} 
