package tienda;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public final class AccesoBD {
	private static AccesoBD instanciaUnica = null;
	private Connection conexionBD = null;

	public static AccesoBD getInstance(){
		if (instanciaUnica == null){
			instanciaUnica = new AccesoBD();
		}
		return instanciaUnica;
	}

	private AccesoBD() {
		abrirConexionBD();
	}

	public void abrirConexionBD() {
		if (conexionBD == null)
		{
			String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
			// daw es el nombre de la base de datos que hemos creado con anterioridad.
			String DB_URL = "jdbc:mariadb://localhost:3306/daw";
			// El usuario root y su clave son los que se puso al instalar MariaDB.
			String USER = "root";
			String PASS = "root";
			try {
				Class.forName(JDBC_DRIVER);
				conexionBD = DriverManager.getConnection(DB_URL,USER,PASS);
			}
			catch(Exception e) {
				System.err.println("No se ha podido conectar a la base de datos");
				System.err.println(e.getMessage());
                e.printStackTrace();
			}
		}
	}
	//TODO removoe this method
	public boolean comprobarAcceso() {
		abrirConexionBD();
		return (conexionBD != null);
	}

	public List<ProductoBD> obtenerProductosBD() {
        abrirConexionBD();
    
        ArrayList<ProductoBD> productos = new ArrayList<>();
    
        try {
            // hay que tener en cuenta las columnas de la tabla de productos
        String con = "SELECT codigo,descripcion,precio,existencias,imagen1, imagen2, imagen3 FROM productos";
		
            Statement s = conexionBD.createStatement();
            ResultSet resultado = s.executeQuery(con);
            while(resultado.next()){
                ProductoBD producto = new ProductoBD();
                producto.setCodigo(resultado.getInt("codigo"));
                producto.setDescripcion(resultado.getString("descripcion"));
                producto.setPrecio(resultado.getFloat("precio"));
                producto.setStock(resultado.getInt("existencias"));
                producto.setImagen1(resultado.getString("imagen1"));
				producto.setImagen2(resultado.getString("imagen2"));
				producto.setImagen3(resultado.getString("imagen3"));
				
                productos.add(producto);
            }
        }
        catch(Exception e) {
            System.err.println("Error ejecutando la consulta a la base de datos");
            System.err.println(e.getMessage());
        }
    
        return productos;
    }

	public int comprobarUsuarioBD(String usuario, String clave) {
		abrirConexionBD();
	
		int codigo = -1;
	
		try{
			// TODO had encryption to the password
			String con = "SELECT codigo FROM usuarios WHERE usuario=? AND clave=?";
			PreparedStatement s = conexionBD.prepareStatement(con);
			s.setString(1,usuario);
			s.setString(2,clave);
	
			ResultSet resultado = s.executeQuery();
	
			// El usuario/clave se encuentra en la BD
	
			if ( resultado.next() ) {
				codigo =  resultado.getInt("codigo");
			}
		}
		catch(Exception e) {
	
			// Error en la conexión con la BD
			System.err.println("Error verificando usuario/clave");
			System.err.println(e.getMessage());
			e.printStackTrace();
		}
	
		return codigo;
	}
}