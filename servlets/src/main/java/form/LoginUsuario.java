package form;
import tienda.AccesoBD;
import tienda.UsuarioBD;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class LoginUsuario extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Nombre del correo
        String correo = request.getParameter("correo");  
    
        // Clave
        String clave = request.getParameter("clave");  
    
        // URL a la que debemos volver
        String url = request.getParameter("url"); 
    
        // Accedemos al entorno de sesión y si no está creado lo creamos
    
        HttpSession session = request.getSession(true); 
    
        AccesoBD con = AccesoBD.getInstance(); 

    
        if ((correo != null) && (clave != null)) {
            UsuarioBD usuario = con.comprobarUsuarioBD(correo,clave);
            if (usuario != null) {
                session.setAttribute("usuario",usuario.getCodigo());
                session.setAttribute("nombre",usuario.getNombre());
                if (url==null) {
                    url = request.getContextPath() + "/producto.jsp";
                }
            }
            else {
                session.setAttribute("mensaje_conexion","Correo y/o clave incorrectos");
                url = request.getContextPath() + "/conexion.jsp"+ (url!=null ? "?url="+url : "" );
            }
        }else{
            url = request.getContextPath() + "/conexion.jsp"+ (url!=null ? "?url="+url : "" );
        }

        response.sendRedirect(url);
        
    }
}