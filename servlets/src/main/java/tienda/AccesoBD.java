package tienda;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

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

	public static String hashPassword(String password) {
		try { //show never fail because we are using SHA-256 as a fixed value

			MessageDigest digest = MessageDigest.getInstance("SHA-256");

			// Calculate the hash of the password
			byte[] hashedBytes = digest.digest(password.getBytes());

			// convet the byte to hex format so we can put it to the database
			StringBuilder sb = new StringBuilder();
			for (byte b : hashedBytes) {
				sb.append(String.format("%02x", b));
			}

			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			System.err.println("Error en la encriptación de la contraseña");
			System.err.println(e.getMessage());
			
		}
		return null;
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

	public UsuarioBD comprobarUsuarioBD(String correo, String clave) {
		abrirConexionBD();

		UsuarioBD usuario = new UsuarioBD();

		try {

			String con = "SELECT codigo, nombre, clave  FROM usuarios WHERE correo=?";
			PreparedStatement s = conexionBD.prepareStatement(con);
			s.setString(1, correo);

			ResultSet resultado = s.executeQuery();

			// El correo/clave se encuentra en la BD

			if (resultado.next() && resultado.getString("clave").equals(hashPassword(clave))) {
				usuario.setNombre(resultado.getString("nombre"));
				usuario.setCodigo(resultado.getInt("codigo"));
			} else {
				usuario = null;
			}
		} catch (Exception e) {

			// Error en la conexión con la BD
			System.err.println("Error verificando correo/clave");
			System.err.println(e.getMessage());
			e.printStackTrace();
			usuario = null;
		}

		return usuario;
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
			} else
				return true;

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

			String con = "SELECT codigo, clave FROM usuarios WHERE codigo=?";
			PreparedStatement s = conexionBD.prepareStatement(con);
			s.setInt(1, codigo);

			ResultSet resultado = s.executeQuery();

			// Search if the password is good
			if (resultado.next() && resultado.getString("clave").equals(hashPassword(password))) {
				codigo = resultado.getInt("codigo");
				String con2 = "UPDATE usuarios SET clave=? WHERE codigo=?";
				PreparedStatement s2 = conexionBD.prepareStatement(con2);
				s2.setString(1, hashPassword(newPassword));
				s2.setInt(2, codigo);
				int filas = s2.executeUpdate();
				if (filas == 0) {
					System.err.println("No se ha actualizado ningún usuario");
					OK = -1;
				} else
					OK = 1;
			} else
				OK = 0;
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
		int status = -1; // -1 means that the user was not added because of un error in the BD

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
				s.setString(10, hashPassword(clave));

				int filas = s.executeUpdate();

				if (filas == 0) {
					System.err.println("No se ha añadido ningún usuario");
					status = -1;
				} else
					status = 1;
			}

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
		}

		return status;
	}

	public int addPedido(PedidoBD pedido) {
		abrirConexionBD();
		int status = -1;

		try {
			conexionBD.setAutoCommit(false);
			String con1 = "INSERT INTO pedidos (persona, fecha, importe, estado) VALUES (?,?,?,?)";
			PreparedStatement s1 = conexionBD.prepareStatement(con1, Statement.RETURN_GENERATED_KEYS);
			s1.setInt(1, pedido.getCodigo_usuario());
			s1.setString(2, pedido.getFecha());
			s1.setFloat(3, pedido.getPrecio());
			s1.setInt(4, pedido.getCodigo_estado());

			int filas = s1.executeUpdate();
			ResultSet rs = s1.getGeneratedKeys();

			if (filas == 0) {
				status = -1;
				throw new Exception("No se ha añadido ningún pedido");
			} else {
				// get the id of the pedido
				rs.next();
				pedido.setCodigo(rs.getInt(1));
				status = rs.getInt(1); // return the id of the pedido

				String con2 = "SELECT existencias FROM productos WHERE codigo=?";
				PreparedStatement checkExist = conexionBD.prepareStatement(con2);

				String con3 = "UPDATE productos SET existencias=? WHERE codigo=?";
				PreparedStatement updateExist = conexionBD.prepareStatement(con3);

				String con4 = "INSERT INTO detalle (codigo_pedido, codigo_producto, unidades, precio_unitario) VALUES (?,?,?,?)";
				PreparedStatement insertDetalle = conexionBD.prepareStatement(con4);

				// first check if the product exists in sufficient quantity

				for (PedidoBD.DetallePedido detalle : pedido.getDetalle()) {
					// check if the product exists in sufficient quantity
					checkExist.setInt(1, detalle.getCodigo_producto());
					ResultSet resultado = checkExist.executeQuery();
					if (!resultado.next()) {
						status = -1;
						throw new Exception(
								"No se ha encontrado el producto con código " + detalle.getCodigo_producto());
					} else {
						if (resultado.getInt("existencias") < detalle.getCantidad()) {
							status = -3;
							throw new Exception(
									"No hay suficiente stock del producto con código " + detalle.getCodigo_producto());
						} else {
							updateExist.setInt(1, resultado.getInt("existencias") - detalle.getCantidad());
							updateExist.setInt(2, detalle.getCodigo_producto());
							filas = updateExist.executeUpdate();
							if (filas == 0) {
								status = -1;
								throw new Exception("Error en la actualización del stock");
							}

							insertDetalle.setInt(1, pedido.getCodigo());
							insertDetalle.setInt(2, detalle.getCodigo_producto());
							insertDetalle.setInt(3, detalle.getCantidad());
							insertDetalle.setFloat(4, detalle.getPrecio());
							filas = insertDetalle.executeUpdate();
							if (filas == 0) {
								status = -1;
								throw new Exception("Error en la inserción de un detalle");
							}
						}
					}

				}
			}

			conexionBD.commit();

		} catch (Exception e) {

			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
			status = -1;
		}

		if (status <= -1) {
			try {
				// roolback if there is an error or number of products is not enough or any
				// other fail
				conexionBD.rollback();
			} catch (SQLException e) {
				System.err.println("Error en el rollback");
				System.err.println(e.getMessage());
			}
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
			String con2 = "SELECT det.unidades, det.precio_unitario, prod.descripcion, prod.codigo FROM detalle det JOIN productos prod ON det.codigo_producto=prod.codigo WHERE det.codigo_pedido=?";
			PreparedStatement s2 = conexionBD.prepareStatement(con2);
			ResultSet resultado2;
			PedidoBD pedido;
			PedidoBD.DetallePedido detalle;
			int nombre_producto = 0;

			while (resultado1.next()) {
				pedido = new PedidoBD();
				nombre_producto = 0;
				pedido.setCodigo(resultado1.getInt("codigo"));
				pedido.setCodigo_estado(resultado1.getInt("codigo_estado"));
				pedido.setFecha(resultado1.getString("fecha"));
				pedido.setPrecio(resultado1.getFloat("importe"));
				pedido.setEstado(resultado1.getString("estado"));

				s2.setInt(1, pedido.getCodigo());
				resultado2 = s2.executeQuery();

				while (resultado2.next()) {
					detalle = pedido.new DetallePedido();
					detalle.setCantidad(resultado2.getInt("unidades"));
					detalle.setPrecio(resultado2.getFloat("precio_unitario"));
					detalle.setNombre_producto(resultado2.getString("descripcion"));
					detalle.setCodigo_producto(resultado2.getInt("codigo"));
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

	public int addComContacto(String nombre, String correo, String apellido, String comentario) {
		int status = -1;

		abrirConexionBD();

		try {
			String consulta = "INSERT INTO com_contacto (nombre, correo, apellido, comentario) VALUES (?,?,?,?)";

			// hay que tener en cuenta las columnas de la tabla de productos

			PreparedStatement s = conexionBD.prepareStatement(consulta);

			s.setString(1, nombre);
			s.setString(2, correo);
			s.setString(3, apellido);
			s.setString(4, comentario);

			int filas = s.executeUpdate();

			if (filas == 0) {
				status = -1;
				throw new Exception("No se ha añadido ningún comentario");
			} else
				status = 1;

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
		}

		return status;
	}

	public int addCard(CardBD card) {
		int status = -1;

		abrirConexionBD();

		try {
			String consulta = "INSERT INTO tarjeta_bancaria (card_number, persona, exp_date, cvv, card_name) VALUES (?,?,?,?,?)";
			PreparedStatement s = conexionBD.prepareStatement(consulta, Statement.RETURN_GENERATED_KEYS);

			s.setString(1, card.getCard_number());
			s.setInt(2, card.getPersona());
			s.setString(3, card.getExp_date());
			s.setString(4, card.getCvv());
			s.setString(5, card.getCard_name());

			int filas = s.executeUpdate();
			if (filas == 0) {
				status = -1;
				throw new Exception("No se ha añadido ninguna tarjeta");
			} else {
				ResultSet rs = s.getGeneratedKeys();
				rs.next();
				status = rs.getInt(1);
			}

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
		}

		return status;
	}

	public List<CardBD> getAllCard(int persona) {
		abrirConexionBD();

		List<CardBD> cards = new ArrayList<>();
		try {
			String con = "SELECT * FROM tarjeta_bancaria WHERE persona=? ORDER BY codigo DESC";
			PreparedStatement s = conexionBD.prepareStatement(con);
			s.setInt(1, persona);
			ResultSet resultado = s.executeQuery();
			while (resultado.next()) {
				CardBD card = new CardBD();
				card.setCard_number(resultado.getString("card_number"));
				card.setPersona(resultado.getInt("persona"));
				card.setExp_date(resultado.getString("exp_date"));
				card.setCvv(resultado.getString("cvv"));
				card.setCard_name(resultado.getString("card_name"));
				card.setCodigo(resultado.getInt("codigo"));

				cards.add(card);
			}
		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
		}

		return cards;
	}

	public int cancelarPedido(int id_pedido) {
		int status = -1;

		abrirConexionBD();

		try {

			// test if the pedido is in state 1 (preparing)
			String con0 = "SELECT estado FROM pedidos WHERE codigo=?";
			PreparedStatement s0 = conexionBD.prepareStatement(con0);
			s0.setInt(1, id_pedido);
			ResultSet resultado0 = s0.executeQuery();
			if (!resultado0.next()) {
				status = -2;
				throw new Exception("No se ha encontrado el pedido con código " + id_pedido);
			}

			if (resultado0.getInt("estado") != 1) {
				status = -3;
				throw new Exception("El pedido no se puede cancelar porque no está en estado 'preparando'");

			}

			// put the command in state 4 (canceled)
			String con = "UPDATE pedidos SET estado=4 WHERE codigo=?";
			PreparedStatement s = conexionBD.prepareStatement(con);

			s.setInt(1, id_pedido);

			int filas = s.executeUpdate();
			if (filas == 0) {
				status = -4;
				throw new Exception("No se ha cancelado ningún pedido");
			} else
				status = 1;

			// put back all the products in stock
			String con2 = "SELECT codigo_producto, unidades FROM detalle WHERE codigo_pedido=?";
			PreparedStatement s2 = conexionBD.prepareStatement(con2);
			s2.setInt(1, id_pedido);
			ResultSet resultado = s2.executeQuery();

			String con3 = "UPDATE productos SET existencias=existencias+? WHERE codigo=?";
			PreparedStatement s3 = conexionBD.prepareStatement(con3);

			while (resultado.next()) {
				s3.setInt(1, resultado.getInt("unidades"));
				s3.setInt(2, resultado.getInt("codigo_producto"));
				filas = s3.executeUpdate();
				if (filas == 0) {
					status = -5;
					throw new Exception("Error en la actualización del stock");
				}
			}

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
			status = -1;
		}

		return status;
	}

	public int deleteTarjeta(int id_card){
		int status = -1;

		abrirConexionBD();

		try {

			String con = "DELETE FROM tarjeta_bancaria WHERE codigo=?";

			PreparedStatement s = conexionBD.prepareStatement(con);

			s.setInt(1, id_card);

			int filas = s.executeUpdate();

			if (filas == 0) {
				status = -1;
				throw new Exception("No se ha eliminado ninguna tarjeta");
			} else
				status = 1;
		

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
			status = -1;

		}

		return status;
	}

	public List<ProductoBD> getProductos(List<Integer> id_productos) {
		List<ProductoBD> productos = new ArrayList<>();
		abrirConexionBD();

		try {
			String con = "SELECT codigo,descripcion,precio,existencias,imagen1 FROM productos WHERE codigo=?";
			PreparedStatement s = conexionBD.prepareStatement(con);

			for (int id : id_productos) {
				s.setInt(1, id);
				ResultSet resultado = s.executeQuery();
				if (resultado.next()) {
					ProductoBD producto = new ProductoBD();
					producto.setCodigo(resultado.getInt("codigo"));
					producto.setDescripcion(resultado.getString("descripcion"));
					producto.setPrecio(resultado.getFloat("precio"));
					producto.setStock(resultado.getInt("existencias"));
					producto.setImagen1(resultado.getString("imagen1"));
					productos.add(producto);
				}
				
			}

			
		

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
			productos = null;

		}

		return productos;
	}


	public List<String> getAllCategoria(){
		List<String> categorias = new ArrayList<>();
		abrirConexionBD();

		try {
			String con = "SELECT DISTINCT categoria, codigo FROM categorias_productos ORDER BY codigo DESC";
			PreparedStatement s = conexionBD.prepareStatement(con);

			ResultSet resultado = s.executeQuery();

			while (resultado.next()) {
				categorias.add(resultado.getString("categoria"));
			}

			
		

		} catch (Exception e) {
			System.err.println("Error ejecutando la consulta a la base de datos");
			System.err.println(e.getMessage());
			categorias = null;

		}

		return categorias;
	
	}

	public List<ProductoBD> obtenerProductosBD(String categoria){
		List<ProductoBD> productos = new ArrayList<>();
		abrirConexionBD();

		try {
			String con = "SELECT * FROM productos WHERE categoria=(SELECT codigo FROM categorias_productos WHERE categoria=?)";
			
			PreparedStatement s = conexionBD.prepareStatement(con);
			s.setString(1, categoria);

			ResultSet resultado = s.executeQuery();

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
			productos = null;

		}

		return productos;
	
	}

}