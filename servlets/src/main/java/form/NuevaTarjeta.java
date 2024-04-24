package form;

import tienda.AccesoBD;
import tienda.CardBD;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class NuevaTarjeta extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();
        
        CardBD card = new CardBD();

        card.setCard_number(request.getParameter("card_number"));
        card.setPersona((int) session.getAttribute("usuario"));
        card.setExp_date(request.getParameter("exp_date"));
        card.setCvv(request.getParameter("cvv"));
        card.setCard_name(request.getParameter("card_name"));


        int status = con.addCard(card) ;

        String msg ="";
        String type = "danger" ;

        if (status >= 1 ){
            msg = "Tarjeta añadida correctamente";
            type = "success";
        }else{
            msg = "Error al añadir la tarjeta";
        }


        session.setAttribute("notification_msg", msg);
        session.setAttribute("notification_type", type);

    
        String url= request.getContextPath() + "/pago.jsp";
        response.sendRedirect(url);
    }
} 
