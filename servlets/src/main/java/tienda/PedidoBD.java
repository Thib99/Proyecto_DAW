package tienda;

import java.util.ArrayList;
import java.util.List;

public class PedidoBD {
    private String fecha ;
    private String estado ;
    private int codigo_estado ;
    
    private float precio ;
    private int codigo ;
    private int codigo_usuario ;
    private int nombre_producto ;
    
    private List<DetallePedido> detalle ;
    
    public int getCodigo_estado() {
        return codigo_estado;
    }

    public void setCodigo_estado(int codigo_estado) {
        this.codigo_estado = codigo_estado;
    }
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

    public float getPrecio() {
        return precio;
    }

    public void setPrecio(float precio) {
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

    public PedidoBD() {
        detalle = new ArrayList<DetallePedido>();
    }

    public class DetallePedido {
        private int codigo_producto ;
        private int cantidad ;
        private String nombre_producto ;
        private float precio ;
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
        public float getPrecio() {
            return precio;
        }
        public void setPrecio(float precio) {
            this.precio = precio;
        }

    }
}
