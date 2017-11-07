import java.awt.BorderLayout;
import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JList;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JComboBox;
import javax.swing.ComboBoxModel;
import javax.swing.DefaultComboBoxModel;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class Simulador extends JFrame {
	
	
	private JList<String> list;
	private JComboBox<String> CBCalles,CBAlturas,CBTarjetas,CBParquimetros;
	private JPanel contentPane;
	private DefaultComboBoxModel<String> calles,alturas,parquimetros,tarjetas;
	ConexionMySQL conMySQL;
	Connection conexion;



	/**
	 * Create the frame.
	 */
	public Simulador(String usuario, String contraseņa) {
		
	     ConexionMySQL c = new ConexionMySQL ();
	     if (c.Conectar(usuario,contraseņa)== null){
	    	 System.out.println("error no se pudo conectar");
	     }
	    conexion= c.getConnection();
	    calles = obtenerCalles();
	    alturas = new DefaultComboBoxModel<String>();
	    parquimetros  = new DefaultComboBoxModel<String>();
	    tarjetas = obtenerTarjetas();
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 513, 339);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JButton btnConectar = new JButton("Conectar");
		btnConectar.setBounds(196, 216, 89, 23);
		contentPane.add(btnConectar);
		this.setVisible(true);
		
		JPanel panel = new JPanel();
		panel.setBounds(343, 24, 144, 117);
		contentPane.add(panel);
		panel.setLayout(null);
		
		
		JLabel lblParquimetros = new JLabel("Parquimetros");
		lblParquimetros.setBounds(26, 11, 85, 14);
		panel.add(lblParquimetros);
		

		
		JPanel panel_1 = new JPanel();
		panel_1.setBounds(165, 25, 155, 160);
		contentPane.add(panel_1);
		panel_1.setLayout(null);
		
	
		
		JPanel panel_2 = new JPanel();
		panel_2.setBounds(10, 24, 144, 104);
		contentPane.add(panel_2);
		panel_2.setLayout(null);
		
		JLabel lblTarjetas = new JLabel("Tarjetas");
		lblTarjetas.setBounds(47, 11, 57, 14);
		panel_2.add(lblTarjetas);
		
		JLabel lblSeleccioneUnaTarjetas = new JLabel("Seleccione una tarjeta");
		lblSeleccioneUnaTarjetas.setBounds(10, 36, 128, 14);
		panel_2.add(lblSeleccioneUnaTarjetas);
		
		CBTarjetas  = new JComboBox<String>(tarjetas);
		CBTarjetas.setBounds(20, 61, 112, 21);
		panel_2.add(CBTarjetas);
		
		JLabel lblNewLabel = new JLabel("Ubicaciones");
		lblNewLabel.setBounds(45, 11, 69, 14);
		panel_1.add(lblNewLabel);
		
		JLabel lblSeleccioneUnaCalle = new JLabel("Seleccione una calle");
		lblSeleccioneUnaCalle.setBounds(10, 30, 128, 14);
		panel_1.add(lblSeleccioneUnaCalle);
		
		CBCalles = new JComboBox<String>(calles);
		CBCalles.setBounds(10, 55, 128, 20);
		panel_1.add(CBCalles);
		CBCalles.setToolTipText("Calle");		

		
				
				
				JLabel lblSeleccioneUnaAltura = new JLabel("Seleccione una altura");
				lblSeleccioneUnaAltura.setBounds(10, 86, 128, 14);
				panel_1.add(lblSeleccioneUnaAltura);				
				
				CBAlturas = new JComboBox<String>(alturas);
				CBAlturas.setToolTipText("Altura");
				CBAlturas.setBounds(10, 110, 122, 20);
				panel_1.add(CBAlturas);
				
				actualizarAlturas(CBCalles.getSelectedItem().toString());
				CBCalles.addActionListener (new ActionListener () {
				public void actionPerformed(ActionEvent e) {					
					
					actualizarAlturas(CBCalles.getSelectedItem().toString());
					actualizarParquimetros(CBCalles.getSelectedItem().toString(),CBAlturas.getSelectedItem().toString());
					
				}
				});
				
				CBAlturas.addActionListener (new ActionListener () {
					public void actionPerformed(ActionEvent e) {					
						System.out.println("entre a alturas");
						actualizarParquimetros(CBCalles.getSelectedItem().toString(),CBAlturas.getSelectedItem().toString());
						
						
					}
				});
			
				
				
				JLabel lblSeleccioneUnParquimetro = new JLabel("Seleccione un parquimetro");
				lblSeleccioneUnParquimetro.setBounds(10, 46, 126, 14);
				panel.add(lblSeleccioneUnParquimetro);
				
				
				actualizarParquimetros(CBCalles.getSelectedItem().toString(),CBAlturas.getSelectedItem().toString());
				CBParquimetros = new JComboBox<String>(parquimetros);
				CBParquimetros.setToolTipText("Parquimetro");
				CBParquimetros.setBounds(10, 71, 112, 21);
				panel.add(CBParquimetros);
				
				
	}
	
	
	
	
	private DefaultComboBoxModel<String> obtenerCalles() {
		DefaultComboBoxModel<String> toRet = new DefaultComboBoxModel<String>();

		try
		{

			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			String sql = "SELECT DISTINCT calle FROM ubicaciones;"; 

			// Se ejecuta la sentencia y se recibe un resultado
			java.sql.ResultSet rs = stmt.executeQuery(sql);


			while(rs.next())
			{
				
				toRet.addElement(rs.getString("calle"));
				
			}

			
		}
		catch (java.sql.SQLException ex) {
			
			System.out.println(ex.getMessage());
		}




		return toRet;
	}
	
	
	
	protected void actualizarAlturas(String calle) {
		
		alturas.removeAllElements();
		try
		{

			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			
			String sql = "SELECT altura FROM ubicaciones WHERE  calle = '" + calle+ "';"; 
			// Se ejecuta la sentencia y se recibe un resultado
			java.sql.ResultSet rs = stmt.executeQuery(sql);


			while(rs.next())
			{
				alturas.addElement(rs.getString("altura"));
				
			}


		}
		catch (java.sql.SQLException ex) {}



	}
	
	protected void  actualizarParquimetros(String calle,String altura) {
		parquimetros.removeAllElements();
		try
		{

			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			
			String sql = "SELECT id_parq FROM parquimetros WHERE  calle = '" + calle+ "' AND altura ="+altura+";"; 
			// Se ejecuta la sentencia y se recibe un resultado
			java.sql.ResultSet rs = stmt.executeQuery(sql);


			while(rs.next())
			{
				parquimetros.addElement(rs.getString("id_parq"));
				
			}


		}
		catch (java.sql.SQLException ex) {
			
			System.out.println(ex.getMessage());
		}

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
}
