package form;

import tienda.AccesoBD;
import tienda.UsuarioBD;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class NuevoUsuario extends HttpServlet {
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

        String password_1 = request.getParameter("password_1");
        String password_2 = request.getParameter("password_2");

        // url a la que debemos volver
        String url = request.getContextPath() + "/registrar.jsp";

        // comprobamos que las contraseñas coinciden
        if (!password_1.equals(password_2)) {
            session.setAttribute("notification_msg", "Las contraseñas no coinciden");
            session.setAttribute("notification_type", "danger");
           
        }else{
            int status = con.addUsuario(usuario, password_1);
            if (status == 1) {
                session.setAttribute("notification_msg", "Usuario registrado correctamente");
                session.setAttribute("notification_type", "success");
                url = request.getContextPath() + "/conexion.jsp";
            } else if (status == 0) {
                session.setAttribute("notification_msg", "El correo ya está registrado");
                session.setAttribute("notification_type", "danger");
                
            } else {
                session.setAttribute("notification_msg", "Error al registrar el usuario");
                session.setAttribute("notification_type", "danger");
                
            }
        }

        response.sendRedirect(url);
    }
} 
