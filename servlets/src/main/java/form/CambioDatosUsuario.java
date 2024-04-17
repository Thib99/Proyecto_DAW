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
            session.setAttribute("mensaje_CambioDatos", "Datos actualizados correctamente");
        } else {
            session.setAttribute("mensaje_CambioDatos", "Error al actualizar los datos");
        }

        String url= request.getContextPath() + "/usuario.jsp";
        response.sendRedirect(url);
    }
} 
