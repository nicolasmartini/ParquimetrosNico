import javax.swing.JFrame;
import javax.swing.UIManager;
import javax.swing.JButton;

import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Color;


public class Usuario extends JFrame {
	
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		try {
			UIManager.setLookAndFeel("com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel");
		} catch (Exception e) {
			e.printStackTrace();
		}
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					Usuario frame = new Usuario();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	public Usuario(){
		getContentPane().setBackground(Color.white);		
		getContentPane().setLayout(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setVisible(true);
		setSize(450, 300);
		setResizable(false);
		setLocationRelativeTo(null);
		JButton Administrador = new JButton("Administrador");
		Administrador.setBounds(147, 50, 140, 58);
		getContentPane().add(Administrador);
		
		Administrador.addActionListener(new Oyente());
		
		
		JButton Inspector = new JButton("Inspector");
		Inspector.setBounds(147, 110, 140, 58);
		getContentPane().add(Inspector);
		Inspector.addActionListener(new Oyente2());
		
		JButton Simulador = new JButton("Usuario");
		Simulador.setBounds(147, 170, 140, 58);
		getContentPane().add(Simulador);
		Simulador.addActionListener(new Oyente3());
		
		
		
	}
	
	
	
	private class Oyente implements ActionListener{
		 public void actionPerformed(ActionEvent e)
		 {
			 setVisible(false);
		     Login l= new Login();   
		     }
		}
	
	 private class Oyente2 implements ActionListener{
		 public void actionPerformed(ActionEvent e)
		 {
			 setVisible(false);
		     Inspector l= new Inspector();   
		     }
		}
	 
	 private class Oyente3 implements ActionListener{
		 public void actionPerformed(ActionEvent e)
		 {
			 setVisible(false);			 
			 Simulador l= new Simulador("parquimetro","parq");   
		     }
		}
}
