package tienda;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public final class AccesoBD {
	private static AccesoBD instanciaUnica = null;
	private Connection conexionBD = null;

	public static AccesoBD getInstance() {
		if (instanciaUnica == null) {
			instanciaUnica = new AccesoBD();
		}
		return instanciaUnica;
	}

	private AccesoBD() {
		abrirConexionBD();
	}

	public void abrirConexionBD() {
		if (conexionBD == null) {
			String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
			// daw es el nombre de la base de datos que hemos creado con anterioridad.
			String DB_URL = "jdbc:mariadb://localhost:3306/daw";
			// El usuario root y su clave son los que se puso al instalar MariaDB.
			String USER = "root";
			String PASS = "root";
			try {
				Class.forName(JDBC_DRIVER);
				conexionBD = DriverManager.getConnection(DB_URL, USER, PASS);
			} catch (Exception e) {
				System.err.println("No se ha podido conectar a la base de datos");
				System.err.println(e.getMessage());
				e.printStackTrace();
			}
		}
	}

	// TODO removoe this method
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
			while (resultado.next()) {
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
		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
		}

		return productos;
	}

	public int comprobarUsuarioBD(String correo, String clave) {
		abrirConexionBD();

		int codigo = -1;

		try {
			// TODO had encryption to the password
			String con = "SELECT codigo FROM usuarios WHERE correo=? AND clave=?";
			PreparedStatement s = conexionBD.prepareStatement(con);
			s.setString(1, correo);
			s.setString(2, clave);

			ResultSet resultado = s.executeQuery();

			// El correo/clave se encuentra en la BD

			if (resultado.next()) {
				codigo = resultado.getInt("codigo");
			}
		} catch (Exception e) {

			// Error en la conexión con la BD
			System.err.println("Error verificando correo/clave");
			System.err.println(e.getMessage());
			e.printStackTrace();
		}

		return codigo;
	}

	public UsuarioBD obtenerUsuarioBD(int codigo) {
		abrirConexionBD();

		UsuarioBD usuario = new UsuarioBD();
		try {
			// hay que tener en cuenta las columnas de la tabla de productos
			String consulta = "SELECT * FROM usuarios WHERE codigo=?";
			PreparedStatement s = conexionBD.prepareStatement(consulta);
			s.setInt(1, codigo);
			ResultSet resultado = s.executeQuery();
			if (!resultado.next()) {
				System.err.println("No se ha encontrado el usuario con código " + codigo);
				return null;
			}
			usuario.setNombre(resultado.getString("nombre"));
			usuario.setApellidos(resultado.getString("apellidos"));
			usuario.setPoblacion(resultado.getString("poblacion"));
			usuario.setPais(resultado.getString("pais"));
			usuario.setCp(resultado.getString("cp"));
			usuario.setTelefono(resultado.getString("telefono"));
			usuario.setFechaNac(resultado.getString("fechaNac"));
			usuario.setCorreo(resultado.getString("correo"));
			usuario.setDomicilio(resultado.getString("domicilio"));

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
		}

		return usuario;
	}

	public boolean updateUsuario(int codigo, UsuarioBD usuario) {
		abrirConexionBD();

		try {
			// hay que tener en cuenta las columnas de la tabla de productos
			String consulta = "UPDATE usuarios SET nombre=?, apellidos=?, poblacion=?, pais=?,cp=?, telefono=?, fechaNac=?, correo=?, domicilio=? WHERE codigo=?";

			PreparedStatement s = conexionBD.prepareStatement(consulta);

			s.setString(1, usuario.getNombre());
			s.setString(2, usuario.getApellidos());
			s.setString(3, usuario.getPoblacion());
			s.setString(4, usuario.getPais());
			s.setString(5, usuario.getCp());
			s.setString(6, usuario.getTelefono());
			s.setString(7, usuario.getFechaNac());
			s.setString(8, usuario.getCorreo());
			s.setString(9, usuario.getDomicilio());
			s.setInt(10, codigo);



			int filas = s.executeUpdate();
			if (filas == 0) {
				System.err.println("No se ha actualizado ningún usuario");
				return false;
			}
			else return true;
			

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
		}

		return false; 
	}
	
	public int updatePassword(int codigo, String password, String newPassword) {
		abrirConexionBD();
		
		int OK = -1;

		try {
			// TODO had encryption to the password
			String con = "SELECT codigo FROM usuarios WHERE codigo=? AND clave=?";
			PreparedStatement s = conexionBD.prepareStatement(con);
			s.setInt(1, codigo);
			s.setString(2, password);

			ResultSet resultado = s.executeQuery();

			// Search if the password is good 
			if (resultado.next()) {
				codigo = resultado.getInt("codigo");
				String con2 = "UPDATE usuarios SET clave=? WHERE codigo=?";
				PreparedStatement s2 = conexionBD.prepareStatement(con2);
				s2.setString(1, newPassword);
				s2.setInt(2, codigo);
				int filas = s2.executeUpdate();
				if (filas == 0) {
					System.err.println("No se ha actualizado ningún usuario");
					OK = -1 ;
				}
				else OK = 1;
			}else OK = 0;
		} catch (Exception e) {

			// Error en la conexión con la BD
			System.err.println("Error en la actualización de la contraseña");
			System.err.println(e.getMessage());
			e.printStackTrace();
			OK = -1;
		}

		return OK;
	}

	public int addUsuario(UsuarioBD usuario, String clave) {
		int status =  -1; // -1 means that the user was not added because of un error in the BD

		abrirConexionBD();

		try {

			String con = "SELECT codigo FROM usuarios WHERE correo=?";
			PreparedStatement s1 = conexionBD.prepareStatement(con);
			s1.setString(1, usuario.getCorreo());

			ResultSet resultado = s1.executeQuery();

			if (resultado.next()) {
				status = 0; // means that a user with the same email already exists
			} else {
				String consulta = "INSERT INTO usuarios (nombre, apellidos, poblacion, pais, cp, telefono, fechaNac, correo, domicilio, clave) VALUES (?,?,?,?,?,?,?,?,?,?)";
				
				// hay que tener en cuenta las columnas de la tabla de productos
				
				PreparedStatement s = conexionBD.prepareStatement(consulta);
				
				s.setString(1, usuario.getNombre());
				s.setString(2, usuario.getApellidos());
				s.setString(3, usuario.getPoblacion());
				s.setString(4, usuario.getPais());
				s.setString(5, usuario.getCp());
				s.setString(6, usuario.getTelefono());
				s.setString(7, usuario.getFechaNac());
				s.setString(8, usuario.getCorreo());
				s.setString(9, usuario.getDomicilio());
				s.setString(10, clave);

				int filas = s.executeUpdate();
				
				
				if (filas == 0) {
					System.err.println("No se ha añadido ningún usuario");
					status = -1;
				}
				else status = 1;
			}
				
			

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
		}

		return status; 
	}

	public int addPedido(PedidoBD pedido){
		abrirConexionBD();
		int status = -1;

		try {
			String con1 = "INSERT INTO pedidos (persona, fecha, importe, estado) VALUES (?,?,?,?)";
			PreparedStatement s1 = conexionBD.prepareStatement(con1, Statement.RETURN_GENERATED_KEYS);
			s1.setInt(1, pedido.getCodigo_usuario());
			s1.setString(2, pedido.getFecha());
			s1.setFloat(3, pedido.getPrecio());
			s1.setInt(4, pedido.getCodigo_estado());

			int filas = s1.executeUpdate();
			ResultSet rs = s1.getGeneratedKeys();

			if (filas == 0) {
				System.err.println("No se ha añadido ningún pedido");
				status = -1;
			}
			else {
				// get the id of the pedido
				rs.next();
				pedido.setCodigo(rs.getInt(1));

				String con2 = "INSERT INTO detalle (codigo_pedido, codigo_producto, unidades, precio_unitario) VALUES (?,?,?,?)";
				PreparedStatement s2 = conexionBD.prepareStatement(con2);
				for (PedidoBD.DetallePedido detalle : pedido.getDetalle()) {
					s2.setInt(1, pedido.getCodigo());
					s2.setInt(2, detalle.getCodigo_producto());
					s2.setInt(3, detalle.getCantidad());
					s2.setFloat(4, detalle.getPrecio());
					filas = s2.executeUpdate();
					if (filas == 0) {
						System.err.println("No se ha añadido un detalle");
						return -1;
					}
					else status = 1;
				}
			}

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
			status = -1;
		}

		return status; 
	}
	

	public List<PedidoBD> getAllPedidos(int codigo_usuario) {

		abrirConexionBD();

		List<PedidoBD> pedidos = new ArrayList<>();
		try {

			// first we will get all the pedidos of the user
			String con1 = "SELECT ped.codigo, ped.fecha, ped.importe, es.descripcion AS estado, ped.estado AS codigo_estado FROM pedidos ped JOIN estados es ON ped.estado=es.codigo WHERE ped.persona=? ORDER BY ped.fecha DESC";


			PreparedStatement s1 = conexionBD.prepareStatement(con1);
			s1.setInt(1, codigo_usuario);
			ResultSet resultado1 = s1.executeQuery();

			// then we will get all the details of each pedido
			String con2 = "SELECT det.unidades, det.precio_unitario, prod.descripcion FROM detalle det JOIN productos prod ON det.codigo_producto=prod.codigo WHERE det.codigo_pedido=?";
			PreparedStatement s2 = conexionBD.prepareStatement(con2);
			ResultSet resultado2;
			PedidoBD pedido;
			PedidoBD.DetallePedido detalle ;
			int nombre_producto = 0 ;


			while(resultado1.next()) {
				System.out.println("codigo pedido: " + resultado1.getInt("codigo"));
				pedido = new PedidoBD();
				nombre_producto = 0 ;
				pedido.setCodigo(resultado1.getInt("codigo"));
				pedido.setCodigo_estado(resultado1.getInt("codigo_estado"));
				pedido.setFecha(resultado1.getString("fecha"));
				pedido.setPrecio(resultado1.getFloat("importe"));
				pedido.setEstado(resultado1.getString("estado"));

				s2.setInt(1, pedido.getCodigo());
				resultado2 = s2.executeQuery();

				while(resultado2.next()) {
					detalle = pedido.new DetallePedido();
					detalle.setCantidad(resultado2.getInt("unidades"));
					detalle.setPrecio(resultado2.getFloat("precio_unitario"));
					detalle.setNombre_producto(resultado2.getString("descripcion"));
					pedido.getDetalle().add(detalle);

					nombre_producto += detalle.getCantidad();
				}
				pedido.setNombre_producto(nombre_producto);
	
				pedidos.add(pedido);
			}

			

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e);
		}

		return pedidos; 
	}

	
}