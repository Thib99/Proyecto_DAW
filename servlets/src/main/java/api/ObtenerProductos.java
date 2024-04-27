package api;


import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;
import jakarta.json.JsonReader;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import tienda.AccesoBD;
import tienda.ProductoBD;

public class ObtenerProductos extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        


        AccesoBD con = AccesoBD.getInstance();

        JsonReader jsonReader = Json.createReader(
                new InputStreamReader(
                        request.getInputStream(), "utf-8"));

        JsonArray jobj = jsonReader.readArray();

        List<Integer> productos_id = new ArrayList<>();

        // loop trough the json array
        for (int i = 0; i < jobj.size(); i++) {
            try {
                productos_id.add(jobj.getInt(i));
            } catch (Exception e) {
                System.err.println(e.getMessage());

            }
        }
        
        List<ProductoBD> productos = con.getProductos(productos_id);
        
        // create json object for key value pairs
        
        // create json array for the products
        
        
        
        JsonArrayBuilder  array_json = Json.createArrayBuilder() ;
        
        if (productos == null) {
            JsonObjectBuilder  producto_json = Json.createObjectBuilder() ;
            producto_json.add("error", "Error al obtener los productos") ;
            
            array_json.add(producto_json.build()) ;
        }
        else{
            
            for (ProductoBD producto : productos) {
                try {
                    JsonObjectBuilder  producto_json = Json.createObjectBuilder() ;
                    producto_json.add("codigo", producto.getCodigo());
                    producto_json.add("precio", producto.getPrecio());
                    producto_json.add("nombre", producto.getDescripcion());
                    producto_json.add("cantidad", producto.getStock());
                    producto_json.add("url_imagen", producto.getImagen1());
                    
                    

                    array_json.add(producto_json.build());
                    
                } catch (Exception e) {
                    System.err.println(e.getMessage());
                }
            }

        }
        
        
        // send the json as response
        response.setContentType("application/json");
        response.getWriter().write(array_json.build().toString());

    }
} 
