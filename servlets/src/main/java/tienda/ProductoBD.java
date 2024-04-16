package tienda;

import java.util.List;

public class ProductoBD {
    private static final String pathImagenes = "img/productos/" ;

    private int codigo;
	private String descripcion;
	private float precio;
	private int stock;
	private String imagen1;
	private String imagen2;
	private String imagen3;

    public int getCodigo() {
        return codigo;
    }
    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }
    public String getDescripcion() {
        return descripcion;
    }
    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    public float getPrecio() {
        return precio;
    }
    public void setPrecio(float precio) {
        this.precio = precio;
    }
    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }
    public String getImagen1() {
        return pathImagenes + imagen1;
    }
    public void setImagen1(String imagen1) {
        this.imagen1 = imagen1;
    }
    public String getImagen2() {
        return  pathImagenes + imagen2;
    }
    public void setImagen2(String imagen2) {
        this.imagen2 = imagen2;
    }
    public String getImagen3() {
        return pathImagenes + imagen3;
    }
    public void setImagen3(String imagen3) {
        this.imagen3 = imagen3;
    }

    
}
