import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Types;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTable;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import javax.swing.border.EmptyBorder;


import quick.dbtable.DBTable;

import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JComboBox;
import javax.swing.ComboBoxModel;
import javax.swing.DefaultComboBoxModel;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.border.BevelBorder;

public class Simulador extends JFrame {
	
	
	private JList<String> list;
	private JComboBox<String> CBUbicaciones,CBTarjetas,CBParquimetros;
	private JPanel contentPane;
	private DefaultComboBoxModel<String> ubicaciones,parquimetros,tarjetas;
	private DBTable tabla;
	ConexionMySQL conMySQL,c;
	Connection conexion;



	/**
	 * Create the frame.
	 */
	public Simulador(String usuario, String contrase�a) {
		
		try {
			UIManager.setLookAndFeel("com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel");
		
	      c = new ConexionMySQL ();
	     if (c.Conectar(usuario,contrase�a)== null){
	    	 System.out.println("error no se pudo conectar");
	     }
	    conexion= c.getConnection();


		ubicaciones = obtenerUbicaciones();
	    parquimetros  = new DefaultComboBoxModel<>();

	    tarjetas = obtenerTarjetas();
	    

		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);		
		setSize(513, 340);
		setResizable(false);
		setLocationRelativeTo(null);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JButton btnConectar = new JButton("Conectar");
		btnConectar.setBounds(195, 152, 89, 23);
		contentPane.add(btnConectar);
		this.setVisible(true);
		
		btnConectar.addActionListener (new ActionListener () {
		public void actionPerformed(ActionEvent e) {					
					
			String id_parquiemtro = CBParquimetros.getSelectedItem().toString();
			String id_tarjeta = CBTarjetas.getSelectedItem().toString();
			conectar(id_parquiemtro,id_tarjeta);
					
					
		}		
		});			
		
		JPanel panel = new JPanel();
		panel.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		panel.setBounds(343, 35, 144, 106);
		contentPane.add(panel);
		panel.setLayout(null);
		

		
		JPanel panel_1 = new JPanel();
		panel_1.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		panel_1.setBounds(165, 35, 155, 106);
		contentPane.add(panel_1);
		panel_1.setLayout(null);
		
	
		
		JPanel panel_2 = new JPanel();
		panel_2.setBorder(new BevelBorder(BevelBorder.LOWERED, null, null, null, null));
		panel_2.setBounds(10, 35, 144, 106);
		contentPane.add(panel_2);
		panel_2.setLayout(null);
		
		JLabel lblSeleccioneUnaTarjetas = new JLabel("Seleccione una tarjeta");
		lblSeleccioneUnaTarjetas.setBounds(20, 41, 128, 14);
		panel_2.add(lblSeleccioneUnaTarjetas);
		
		CBTarjetas  = new JComboBox<String>(tarjetas);
		CBTarjetas.setBounds(20, 66, 112, 21);
		panel_2.add(CBTarjetas);
		
		JLabel lblSeleccioneUnaCalle = new JLabel("Seleccione una ubicaci�n");
		lblSeleccioneUnaCalle.setBounds(10, 41, 155, 14);
		panel_1.add(lblSeleccioneUnaCalle);
		
		CBUbicaciones = new JComboBox<String>(ubicaciones);
		CBUbicaciones.setBounds(10, 66, 128, 20);
		panel_1.add(CBUbicaciones);
		CBUbicaciones.setToolTipText("Ubicaci�n");				
				

		actualizarParquimetros(CBUbicaciones.getSelectedItem().toString());
		CBUbicaciones.addActionListener (new ActionListener () {
		public void actionPerformed(ActionEvent e) {					
					
				actualizarParquimetros(CBUbicaciones.getSelectedItem().toString());
					
					
		}
		});				
				
		JLabel lblSeleccioneUnParquimetro = new JLabel("Seleccione un parquimetro");
		lblSeleccioneUnParquimetro.setBounds(10, 42, 126, 14);
		panel.add(lblSeleccioneUnParquimetro);				
				

		CBParquimetros = new JComboBox<String>(parquimetros);
		CBParquimetros.setToolTipText("Parquimetro");
		CBParquimetros.setBounds(10, 66, 122, 21);
		panel.add(CBParquimetros);
				
		JLabel lblTarjetas = new JLabel("Tarjetas");
		lblTarjetas.setBounds(57, 11, 57, 14);
		contentPane.add(lblTarjetas);
				
		JLabel lblNewLabel = new JLabel("Ubicaciones");
		lblNewLabel.setBounds(205, 11, 69, 14);
		contentPane.add(lblNewLabel);
				
				
		JLabel lblParquimetros = new JLabel("Parquimetros");
		lblParquimetros.setBounds(379, 11, 85, 14);
		contentPane.add(lblParquimetros);
		
		JButton btnVolver = new JButton("Volver");
		btnVolver.setBounds(195, 267, 89, 23);
		contentPane.add(btnVolver);
		btnVolver.addActionListener(new Oyente());
		}catch (Exception e) {
			
			JOptionPane.showMessageDialog(this,"No fue posible conectarse a la BD");
			
		}
	 

	}
	
	

	
	private void conectar(String parquimetro,String tarjeta)
	{	String operacion="";
	    String resultado="";
	    String tiempo="";
	    String saldo="";
	  
	
		try
		{

			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			String consulta = "CALL conectar("+tarjeta+","+parquimetro+");";; 

			// Se ejecuta la sentencia y se recibe un resultado
			java.sql.ResultSet rs = stmt.executeQuery(consulta);            
			
			if (rs.next())				
			   operacion = rs.getString("Operacion");			
			
			if (operacion.equals("CIERRE")) {
				   tiempo=rs.getString("Tiempo");
				   saldo=rs.getString("Saldo");
				   JOptionPane.showMessageDialog(this,"ESTUVO "+ tiempo +" MINUTOS ESTACIONADO. SU SALDO ACTUAL "+ saldo +".");
			}
			else if (operacion.equals("APERTURA")) {
			        resultado=rs.getString("Resultado");
			        tiempo=rs.getString("Tiempo");
			        JOptionPane.showMessageDialog(this,"LA APERTURA SE REALIZO CON "+ resultado +". TIENE "+ tiempo +" MINUTOS PARA ESTAR ESTACIONADO.");
			       }	
			    else JOptionPane.showMessageDialog(this,operacion);
		    
		}
		catch (Exception ex) {
			
			System.out.println(ex.getMessage());
		}

	

	}
	

	
	private DefaultComboBoxModel<String> obtenerUbicaciones() {
		DefaultComboBoxModel<String> toRet = new DefaultComboBoxModel<String>();

		try
		{

			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			String sql = "SELECT DISTINCT calle, altura FROM ubicaciones;"; 

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
	
	
	

	
	protected void actualizarParquimetros(String u) {
		String[] uc = u.split(" ", 2);
		parquimetros.removeAllElements();
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
				parquimetros.addElement(rs.getString("id_parq"));
				
			}


		}
		catch (java.sql.SQLException ex) {}



	}
	
	private DefaultComboBoxModel<String> obtenerTarjetas() {
		DefaultComboBoxModel<String> toRet = new DefaultComboBoxModel<String>();

		try
		{

			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			String sql = "SELECT id_tarjeta FROM tarjetas;"; 

			// Se ejecuta la sentencia y se recibe un resultado
			java.sql.ResultSet rs = stmt.executeQuery(sql);


			while(rs.next())
			{
				toRet.addElement(rs.getString("id_tarjeta"));
				
				
			}


		}
		catch (java.sql.SQLException ex) {
			System.out.println(ex.getMessage());
		}




		return toRet;
	}
	
	class Oyente implements ActionListener{
		 public void actionPerformed(ActionEvent e)
				 {
					 setVisible(false);
					 setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
					 Usuario u =new Usuario();  
				 }
		}
	
}
