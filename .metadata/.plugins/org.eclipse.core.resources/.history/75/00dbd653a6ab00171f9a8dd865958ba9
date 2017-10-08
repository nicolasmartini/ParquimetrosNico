import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Types;

import javax.swing.DefaultComboBoxModel;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFormattedTextField;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ListSelectionModel;
import javax.swing.SwingUtilities;
import javax.swing.text.MaskFormatter;

import quick.dbtable.DBTable;

import java.awt.Color;


public class UnidadPersonal extends JFrame{

	private JPanel panelInspector;
	private DefaultListModel<String> patentes;
	ConexionMySQL conMySQL;
	Connection conexion;
	private DBTable tabla;  


	private JList<String> list;
	private JComboBox<String> CBUbicaciones;

	private DefaultComboBoxModel<String> ubicaciones,ids;
	private JFormattedTextField txtPatente;
	private JComboBox<String> CBIdP;
	private JLabel lblUbicacion;
	private Component lblNroP;
	private JButton btnAgregar;
	private JButton btnGenerarMultas;
	private Component lblMultasGeneradas;
	private JScrollPane scrollPane;
	private JButton btnBorar;
	private JLabel lblPatente;
	private JLabel lblListaDePatentes;
	
	public UnidadPersonal(String legajo,ConexionMySQL c){
		conMySQL=c;
		conexion= c.getConnection();
		patentes = new DefaultListModel<String>();
		ids = new DefaultComboBoxModel<String>();
		ubicaciones = obtenerUbicaciones(legajo);
		try {


			setSize(800,600);	
			setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			setPreferredSize(new Dimension(800, 600));
			getContentPane().setBounds(0, 0, 800, 600);
			setVisible(true);
			this.setTitle("Panel Inspector");
			getContentPane().setLayout(null);

			panelInspector = new JPanel();
			panelInspector.setBackground(Color.BLACK);
			panelInspector.setForeground(Color.BLACK);
			panelInspector.setVisible(false);
			panelInspector.setPreferredSize(new Dimension(800,600));
			panelInspector.setBounds(0,0,800,562);
			getContentPane().add(panelInspector);
			panelInspector.setLayout(null);


			scrollPane = new JScrollPane();
			scrollPane.setBounds(499, 145, 200, 317);
			panelInspector.add(scrollPane);
			
						list = new JList<String>(patentes);
						scrollPane.setViewportView(list);
						list.setSelectionMode(ListSelectionModel.SINGLE_INTERVAL_SELECTION);
						list.setLayoutOrientation(JList.VERTICAL);
						list.setVisibleRowCount(-1);


			tabla = new DBTable();
			tabla.setBounds(0, 132, 437, 398);
			panelInspector.add(tabla);

			CBUbicaciones = new JComboBox<String>(ubicaciones);
			CBUbicaciones.setToolTipText("Ubicacion");
			CBUbicaciones.setBounds(515, 21, 184, 20);
			CBUbicaciones.addActionListener (new ActionListener () {
				public void actionPerformed(ActionEvent e) {
					actualizarIds(CBUbicaciones.getSelectedItem().toString(),legajo);
				}
			});
			panelInspector.add(CBUbicaciones);

			CBIdP = new JComboBox<String>(ids);
			CBIdP.setToolTipText("Parquimetro");
			CBIdP.setBounds(515, 52, 184, 20);
			panelInspector.add(CBIdP);

			lblUbicacion = new JLabel("Ubicaci\u00F3n:");
			lblUbicacion.setForeground(Color.WHITE);
			//lblUbicacion.setFont(f);
			lblUbicacion.setBounds(438, 21, 107, 20);
			panelInspector.add(lblUbicacion);

			lblNroP = new JLabel("Nro. Parquimetro:");
			lblNroP.setForeground(Color.WHITE);
			lblNroP.setBackground(Color.WHITE);
			//lblNroP.setFont(f);
			lblNroP.setBounds(400, 52, 107, 20);
			panelInspector.add(lblNroP);

			txtPatente = new JFormattedTextField(new MaskFormatter("******"));
			txtPatente.setText("");
			txtPatente.setBounds(515, 489, 86, 20);
			panelInspector.add(txtPatente);
			txtPatente.setColumns(10);

			btnAgregar = new JButton("Agregar");
			btnAgregar.addMouseListener(new MouseAdapter() {
				@Override
				public void mouseReleased(MouseEvent arg0) {
					botonAgregarAccion(txtPatente.getText());
				}
			});
			btnAgregar.setBounds(610, 473, 89, 23);
			panelInspector.add(btnAgregar);

			btnGenerarMultas = new JButton("Generar Multas");
			btnGenerarMultas.addMouseListener(new MouseAdapter() {
				@Override
				public void mouseReleased(MouseEvent arg0) {
					botonGenerarMultasYRegAccesoAccion(legajo);
				}
			});
			btnGenerarMultas.setBounds(158, 40, 200, 54);
			panelInspector.add(btnGenerarMultas);

			btnBorar = new JButton("Borrar");
			btnBorar.addMouseListener(new MouseAdapter() {
				@Override
				public void mouseReleased(MouseEvent arg0) {
					botonBorrarAccion();
				}
			});
			btnBorar.setBounds(610, 507, 89, 23);
			panelInspector.add(btnBorar);


			JButton btnVolver = new JButton("Volver");
			btnVolver.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent evt) {
					btnVolverActionPerformed(evt);
				}
			});
			btnVolver.setBounds(10, 11, 76, 30);
			panelInspector.add(btnVolver);
			
			lblPatente = new JLabel("Patente:");
			lblPatente.setForeground(Color.WHITE);
			lblPatente.setBounds(447, 492, 69, 14);
			panelInspector.add(lblPatente);
			
						lblMultasGeneradas = new JLabel("Multas");
						lblMultasGeneradas.setForeground(Color.WHITE);
						lblMultasGeneradas.setBounds(20, 82, 76, 40);
						panelInspector.add(lblMultasGeneradas);
						lblMultasGeneradas.setFont(new Font("Dialog", Font.PLAIN, 18));
						
						lblListaDePatentes = new JLabel("Lista de Patentes");
						lblListaDePatentes.setForeground(Color.WHITE);
						lblListaDePatentes.setBackground(Color.WHITE);
						lblListaDePatentes.setBounds(559, 115, 125, 14);
						panelInspector.add(lblListaDePatentes);


			panelInspector.setVisible(true);


		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	protected void botonGenerarMultasYRegAccesoAccion(String l) {
		String[] uc = CBUbicaciones.getSelectedItem().toString().split(" ", 2);
		String dia="";
		try
		{
			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			String sql1 = "select dayofweek(curdate());";
			java.sql.ResultSet rs = stmt.executeQuery(sql1);
			String d="";

			if(rs.next())	
				d = rs.getString(1);

			int ndia = Integer.parseInt(d);
			if(ndia==1) {
				dia = "do";
			}
			else if (ndia==2) {
				dia = "lu";
			}
			else if (ndia==3) {
				dia = "ma";
			}
			else if (ndia==4) {
				dia = "mi";
			}
			else if (ndia==5) {
				dia = "ju";
			}
			else if (ndia==6) {
				dia = "vi";
			}
			else {
				dia = "sa";
			}
			String sql2 = "select curtime();";
			rs = stmt.executeQuery(sql2);

			String hora="";
			String min="";
			String seg="";
			if(rs.next())	
				hora = rs.getString(1);

			min = ""+hora.charAt(3)+hora.charAt(4);
			seg = ""+hora.charAt(6)+hora.charAt(7);
			String soloHora = ""+hora.charAt(0)+hora.charAt(1);
			int hora2 = Integer.parseInt(soloHora,10);


			String turno="";
			if(hora2<14 && hora2 >=8) {
				turno="m";
			}
			else if(hora2>=14 && hora2<20) {
				turno="t";
			}


			String fe = "";
			sql1 = "select curdate();";
			rs = stmt.executeQuery(sql1);
			if(rs.next()) {
				fe = rs.getString(1);
			}
			String[] fecha = fe.split("-",3);
			java.sql.Date date = Fechas.convertirStringADateSQL(fecha[2]+"/"+fecha[1]+"/"+fecha[0]);



			String sql = "select * from asociado_con where legajo = '" + l + "' and calle = '"+uc[0]+"' and altura = '" + uc[1] +"' and dia = '" + dia + "' and turno = '" + turno + "';"; 
			// Se ejecuta la sentencia y se recibe un resultado
			rs = stmt.executeQuery(sql);

			String ins = "INSERT INTO accede(legajo, id_parq, fecha, hora) VALUES (?, ?, ?, ?)";
			// Se crea un sentencia preparada
			java.sql.PreparedStatement stmt2 = conexion.prepareStatement(ins);
			// Se ligan los parámetros efectivos
			stmt2.setString(1, l);
			stmt2.setString(2, CBIdP.getSelectedItem().toString());
			stmt2.setDate(3, date);
			stmt2.setString(4, hora);



			if(rs.next())
			{
				stmt2.executeUpdate();
				stmt2.close();
				generarMultas(date,hora,rs.getInt(1),uc[0],uc[1]);
			}


		}

		catch (java.sql.SQLException ex) {
			JOptionPane.showMessageDialog(this,
					"Se produjo un error.\n" + ex.getMessage(),
					"Error",
					JOptionPane.ERROR_MESSAGE);
		}
	}
	
	public void generarMultas(java.sql.Date fecha, String hora, int id , String calle, String altura) {
		try {
			String pat;
			java.sql.Statement stmt;
			String sql1;
			java.sql.ResultSet rs;
			String ins = "INSERT INTO multa(fecha,hora,patente,id_asociado_con) VALUES(?,?,?,?);";
			// Se crea un sentencia preparada
			java.sql.PreparedStatement stmt2 = conexion.prepareStatement(ins);
			for(int i = 0 ; i < patentes.size() ; i++) {
				pat = patentes.elementAt(i).toString();
				
				// Se crea una sentencia jdbc para realizar la consulta
				stmt = conexion.createStatement();
				// Se prepara el string SQL de la consulta
				sql1 = "select * from estacionados where patente= '" +pat+ "' and calle = '"+calle+"' and altura = "+altura+";";
				rs = stmt.executeQuery(sql1);
				if(!rs.next()) {
					// Se ligan los parámetros efectivos
					stmt2.setDate(1, fecha);
					stmt2.setString(2, hora);
					stmt2.setString(3, pat);
					stmt2.setInt(4, id);
					stmt2.executeUpdate();
				}
				
			}
			refrescarTablaMultas(fecha,hora,id);
			stmt2.close();
			
			
		}
		catch (java.sql.SQLException ex) {
			JOptionPane.showMessageDialog(this,
					"Se produjo un error.\n" + ex.getMessage(),
					"Error",
					JOptionPane.ERROR_MESSAGE);
		}
	}
	
	
	private void refrescarTablaMultas(Date fecha, String hora, int id) {
		try	
		{    
			tabla.connectDatabase(conMySQL.getdriver(),conMySQL.uri(),conMySQL.getUser(),conMySQL.getPass());
			conMySQL.Conectar("inspector", "inspector");
			String sql = "select numero, fecha, hora, calle, altura, patente,legajo from multa natural join asociado_con where fecha = '"+
					fecha +"' and hora = '"+hora+"' and id_asociado_con = "+id+";";
			// seteamos la consulta a partir de la cual se obtendr�n los datos para llenar la tabla
			tabla.setSelectSql(sql.trim());

			// obtenemos el modelo de la tabla a partir de la consulta para 
			// modificar la forma en que se muestran de algunas columnas  
			tabla.createColumnModelFromQuery();    	    
			for (int i = 0; i < tabla.getColumnCount(); i++)
			{ // para que muestre correctamente los valores de tipo TIME (hora)  		   		  
				if	 (tabla.getColumn(i).getType()==Types.TIME)  
				{    		 
					tabla.getColumn(i).setType(Types.CHAR);  
				}
				// cambiar el formato en que se muestran los valores de tipo DATE
				if	 (tabla.getColumn(i).getType()==Types.DATE)
				{
					tabla.getColumn(i).setDateFormat("dd/MM/YYYY");
				}
			}  
			// actualizamos el contenido de la tabla.   	     	  
			tabla.refresh();
			// No es necesario establecer  una conexi�n, crear una sentencia y recuperar el 
			// resultado en un resultSet, esto lo hace autom�ticamente la tabla (DBTable) a 
			// patir  de  la conexi�n y la consulta seteadas con connectDatabase() y setSelectSql() respectivamente.



		}
		catch (SQLException ex)
		{	JOptionPane.showMessageDialog(SwingUtilities.getWindowAncestor(this),
					ex.getMessage() + "\n", 
					"Error al ejecutar la consulta.",
					JOptionPane.ERROR_MESSAGE);

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	protected void botonLimpiarAccion() {
		patentes.removeAllElements();
	}
	protected void botonBorrarAccion() {
		patentes.removeElement(list.getSelectedValue());
	}
	
	protected void btnVolverActionPerformed(ActionEvent a){
		
		setVisible(false);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		Inspector i= new Inspector();
	}
	
	protected void actualizarIds(String u, String l) {
		String[] uc = u.split(" ", 2);
		ids.removeAllElements();
		try
		{

			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			String sql = "SELECT id_parq FROM ubicaciones natural join parquimetros WHERE  calle = '" + uc[0] +"' and altura = '" + uc[1]+ "';"; 
			// Se ejecuta la sentencia y se recibe un resultado
			java.sql.ResultSet rs = stmt.executeQuery(sql);


			while(rs.next())
			{
				ids.addElement(rs.getString("id_parq"));
				
			}


		}
		catch (java.sql.SQLException ex) {}



	}
	
	protected void botonAgregarAccion(String p) {	
		
		if(p.trim().length()==6) {
			patentes.addElement(p);
		}
	}
	
	private DefaultComboBoxModel<String> obtenerUbicaciones(String legajo) {
		DefaultComboBoxModel<String> toRet = new DefaultComboBoxModel<String>();

		try
		{

			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			String sql = "SELECT calle, altura FROM asociado_con WHERE legajo = '" + legajo + "';"; 

			// Se ejecuta la sentencia y se recibe un resultado
			java.sql.ResultSet rs = stmt.executeQuery(sql);


			while(rs.next())
			{
				toRet.addElement(rs.getString("calle")+" "+rs.getString("altura"));
				
				
			}


		}
		catch (java.sql.SQLException ex) {}




		return toRet;
	}
}
