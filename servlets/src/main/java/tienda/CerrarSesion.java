package tienda;


import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CerrarSesion extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);

        if (session != null) {
            // close the session
            session.invalidate();
        }


        // return to the login page
        String url = request.getContextPath() + "/conexion.jsp";
        response.sendRedirect(url);
    }
} 
