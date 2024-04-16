package tienda;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class LoginUsario extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Nombre del usuario
        String usuario = request.getParameter("usuario");  
    
        // Clave
        String clave = request.getParameter("clave");  
    
        // URL a la que debemos volver
        String url = request.getParameter("url"); 
    
        // Accedemos al entorno de sesión y si no está creado lo creamos
    
        HttpSession session = request.getSession(true); 
    
        AccesoBD con = AccesoBD.getInstance(); 

    
        if ((usuario != null) && (clave != null)) {
            int codigo = con.comprobarUsuarioBD(usuario,clave);
            if (codigo>0) {
                session.setAttribute("usuario",codigo);
                session.setAttribute("nombre_usario",usuario);
            }
            else {
                session.setAttribute("mensaje_conexion","Usuario y/o clave incorrectos");
                url = request.getContextPath() + "/conexion.jsp"+ (url!=null ? "?url="+url : "" );
            }
        }else{
            url = request.getContextPath() + "/conexion.jsp"+ (url!=null ? "?url="+url : "" );
        }

        response.sendRedirect(url);
        
    }
}
