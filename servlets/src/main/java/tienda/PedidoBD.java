package tienda;

import java.util.ArrayList;
import java.util.List;

public class PedidoBD {
    String fecha ;
    String estado ;
    String precio ;
    int codigo ;
    int codigo_usuario ;
    int nombre_producto ;
    
    List<DetallePedido> detalle ;
    
    public int getNombre_producto() {
        return nombre_producto;
    }

    public void setNombre_producto(int nombre_producto) {
        this.nombre_producto = nombre_producto;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getPrecio() {
        return precio;
    }

    public void setPrecio(String precio) {
        this.precio = precio;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public int getCodigo_usuario() {
        return codigo_usuario;
    }

    public void setCodigo_usuario(int codigo_usuario) {
        this.codigo_usuario = codigo_usuario;
    }

    public List<DetallePedido> getDetalle() {
        return detalle;
    }

    public void setDetalle(List<DetallePedido> detalle) {
        this.detalle = detalle;
    }

    PedidosBD() {
        detalle = new ArrayList<DetallePedido>();
    }

    public class DetallePedido {
        int codigo_producto ;
        int cantidad ;
        String nombre_producto ;
        String precio ;
        public int getCodigo_producto() {
            return codigo_producto;
        }
        public void setCodigo_producto(int codigo_producto) {
            this.codigo_producto = codigo_producto;
        }
        public int getCantidad() {
            return cantidad;
        }
        public void setCantidad(int cantidad) {
            this.cantidad = cantidad;
        }
        public String getNombre_producto() {
            return nombre_producto;
        }
        public void setNombre_producto(String nombre_producto) {
            this.nombre_producto = nombre_producto;
        }
        public String getPrecio() {
            return precio;
        }
        public void setPrecio(String precio) {
            this.precio = precio;
        }

    }
}
