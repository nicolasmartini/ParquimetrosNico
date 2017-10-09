import javax.swing.JFrame;
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
		getContentPane().setBackground(Color.BLACK);
		
		
		getContentPane().setLayout(null);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setVisible(true);
		setBounds(100, 100, 450, 300);
		JButton Administrador = new JButton("Administrador");
		Administrador.setBounds(147, 43, 140, 58);
		getContentPane().add(Administrador);
		
		Administrador.addActionListener(new Oyente());
		
		JButton Inspector = new JButton("Inspector");
		Inspector.setBounds(151, 145, 136, 58);
		getContentPane().add(Inspector);
		Inspector.addActionListener(new Oyente2());
		
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
}
