import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.border.BevelBorder;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.JButton;

import com.jgoodies.forms.factories.DefaultComponentFactory;


public class Inspector extends JFrame {

	private JPanel contentPane;
	private JTextField textField;
	private JLabel lblContrasea;
	private JPasswordField textContraseña;
	private JButton btnNewButton,btnVolver;



	/**
	 * Create the frame.
	 */
	public Inspector() {
		this.setVisible(true);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		contentPane.setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setBackground(Color.BLACK);
		panel.setBorder(new BevelBorder(BevelBorder.LOWERED, Color.BLACK, null, null, null));
		panel.setBounds(10, 11, 414, 240);
		contentPane.add(panel);
		panel.setLayout(null);
		
		JLabel lblUsuario = new JLabel("LEGAJO");
		lblUsuario.setForeground(Color.WHITE);
		lblUsuario.setBackground(Color.WHITE);
		lblUsuario.setBounds(183, 11, 65, 14);
		panel.add(lblUsuario);
		
		textField = new JTextField();
		textField.setBounds(141, 36, 134, 20);
		panel.add(textField);
		textField.setColumns(10);
		
		lblContrasea = new JLabel("CONTRASE\u00D1A");
		lblContrasea.setForeground(Color.WHITE);
		lblContrasea.setBounds(170, 67, 80, 14);
		panel.add(lblContrasea);
		
		textContraseña = new JPasswordField();
		textContraseña.setBounds(141, 92, 134, 20);
		panel.add(textContraseña);
		textContraseña.setColumns(10);
		
		btnNewButton = new JButton("INTRO");
		btnNewButton.setBounds(161, 123, 89, 23);
		panel.add(btnNewButton);
		btnNewButton.addActionListener(new Oyente());
		JLabel lblNewJgoodiesLabel = DefaultComponentFactory.getInstance().createLabel("");
		lblNewJgoodiesLabel.setBounds(31, 157, 361, 60);
		panel.add(lblNewJgoodiesLabel);
		
		btnVolver = new JButton("Volver");
		btnVolver.setBounds(159, 194, 89, 23);
		panel.add(btnVolver);
		btnVolver.addActionListener(new Oyente2());
	
	}
	
	
	
	class Oyente implements ActionListener{
		 public void actionPerformed(ActionEvent e)
		 {
			 String u= textField.getText();
			 String p= textContraseña.getText();
		     ConexionMySQL c = new ConexionMySQL ();
		     
		     if (c.Conectar("inspector", "inspector")!= null){
		    	 try
		 		{

		 			java.sql.Statement stmt = c.getConnection().createStatement();

		 			String sql = "SELECT password FROM inspectores WHERE legajo = '" + u + "' and password=md5('" + p +"')" + ";" ; 
		 			
		 			java.sql.ResultSet rs = stmt.executeQuery(sql);

		 		
		 			if(rs.next())
		 			{
		 				setVisible(false);
		 				setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		 				UnidadPersonal d = new UnidadPersonal(u,c);
		 			}

		 			else
		 			{
		 				JOptionPane.showMessageDialog(null, "Password o usuario Invalido");
		 				 textField.setText("");
				    	 textContraseña.setText("");
		 	
		 			}
		    }
				catch (java.sql.SQLException ex){
					System.out.println("El legajo no existe");
					}
		         	    	 
		     	}
		     
		 	}
		}
	
	class Oyente2 implements ActionListener{
		 public void actionPerformed(ActionEvent e)
				 {
					 setVisible(false);
					 setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
					 Usuario u =new Usuario();  
				 }
		}


}
	
	
	

