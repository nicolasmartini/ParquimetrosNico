import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JButton;
import javax.swing.JTextField;
import javax.swing.JMenuBar;
import javax.swing.JLabel;
import javax.swing.ListSelectionModel;
import javax.swing.SwingConstants;
import com.jgoodies.forms.factories.DefaultComponentFactory;
import javax.swing.border.BevelBorder;
import javax.swing.border.LineBorder;
import quick.dbtable.DBTable;
import java.sql.*;
import javax.swing.JList;

public class Gui {

	private JFrame frame;
	private JTextField consulta;
	private ConexionMySQL conexion;
	private DBTable tabla;
	private JTextArea textArea,textArea_1;
	private JList<String> list;

	/**
	 * Create the application.
	 */
	public Gui(ConexionMySQL c) {
		conexion=c;
		initialize();
		
		
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		
		frame = new JFrame();		
		frame.getContentPane().setBackground(Color.BLACK);
		frame.getContentPane().setForeground(Color.BLACK);
		frame.setBounds(100, 100, 800, 600);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(null);
		frame.setVisible(true);
		
		JPanel panel = new JPanel();
		panel.setBorder(new BevelBorder(BevelBorder.LOWERED, Color.BLACK, null, null, null));
		panel.setBounds(252, 197, 502, 84);
		frame.getContentPane().add(panel);
		panel.setLayout(null);
		
		JPanel panel_1 = new JPanel();
		panel_1.setBorder(new LineBorder(new Color(0, 0, 0)));
		panel_1.setBounds(10, 11, 477, 47);
		panel.add(panel_1);
		panel_1.setLayout(null);
		
		JButton btnNewButton = new JButton("INTRO");
		btnNewButton.setBounds(368, 12, 99, 23);
		panel_1.add(btnNewButton);
		
		consulta = new JTextField();
		consulta.setBounds(10, 10, 358, 26);
		panel_1.add(consulta);
		consulta.setColumns(10);
		btnNewButton.addActionListener(new Oyente3());
		
		textArea = new JTextArea();
		textArea.setEditable(false);
		textArea.setBounds(10, 11, 450, 179);
		
		
		JPanel panel_3 = new JPanel();
		panel_3.setBorder(new BevelBorder(BevelBorder.LOWERED, Color.BLACK, null, null, null));
		panel_3.setBounds(10, 11, 217, 125);
		frame.getContentPane().add(panel_3);
		panel_3.setLayout(null);
		
		JButton btnNewButton_1 = new JButton("Cerrar Sesion");
		btnNewButton_1.setBounds(38, 75, 122, 23);
		panel_3.add(btnNewButton_1);
		btnNewButton_1.addActionListener(new Oyente2());
		
		JLabel lblUsuario = DefaultComponentFactory.getInstance().createLabel("Usted esta logueado como");
		lblUsuario.setBounds(23, 11, 180, 23);
		panel_3.add(lblUsuario);
		
		JLabel label = new JLabel(conexion.getUser());
		label.setHorizontalAlignment(SwingConstants.CENTER);
		label.setBounds(23, 36, 167, 28);
		panel_3.add(label);
	
          tabla = new DBTable();
          tabla.setBounds(265, 312, 489, 218);
          frame.getContentPane().add(tabla);
          tabla.getTable().setBounds(3, 28, 300, 0);
          
         tabla.setEditable(false);       
         tabla.setBorder(new BevelBorder(BevelBorder.LOWERED, Color.BLACK, null, null, null));
        textArea = new JTextArea ("");
        textArea.setEditable(false);
         JScrollPane scrollPane = new JScrollPane(textArea, 
                 JScrollPane.VERTICAL_SCROLLBAR_ALWAYS, JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
         scrollPane.setBounds(242, 11, 512, 169);
         frame.getContentPane().add(scrollPane);
         
         
    
         String[] data=conexion.obtenerTablas();
         list = new JList<String>(data);
         list.setBorder(new BevelBorder(BevelBorder.LOWERED, Color.BLACK, null, null, null));
         list.setSelectionMode(ListSelectionModel.SINGLE_INTERVAL_SELECTION);
  		list.setLayoutOrientation(JList.VERTICAL);
  		list.setVisibleRowCount(-1);    
         list.setBounds(10, 197, 115, 333);
         
          textArea_1 = new JTextArea();
          textArea_1.setEditable(false);
         textArea_1.setBounds(133, 197, 109, 333);
         frame.getContentPane().add(textArea_1);
         
         list.addMouseListener(new MouseAdapter() {
				@Override
				public void mouseReleased(MouseEvent arg0) {
					textArea_1.setText("");
					String[] resultado= conexion.atributos(list.getSelectedValue().toString());
					for (int i=0; i<resultado.length & resultado[i]!=null;i++){
						
						textArea_1.setText(textArea_1.getText()+ resultado[i]+'\n');
						
					}
									}
			});
         frame.getContentPane().add(list);
         
         
         
        
         tabla.setVisible(true);
         try {
			tabla.connectDatabase(conexion.getdriver(),conexion.uri(),conexion.getUser(),conexion.getPass());
		} catch (ClassNotFoundException | SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
         		
		JMenuBar menuBar = new JMenuBar();
		frame.setJMenuBar(menuBar);
	
	
	}
	
	class Oyente2 implements ActionListener{
		 public void actionPerformed(ActionEvent e)
		 {
			 frame.setVisible(false);
		     Usuario u= new Usuario();
		    
		     }
		}
	
	class Oyente3 implements ActionListener{
		
		public void actionPerformed(ActionEvent e){
			refrescarTabla();
			consulta.setText("");
			
		}
		
	}
	
	
	private void refrescarTabla()
	   {
	      try
	      {   String con=this.consulta.getText();
	      		if ((con.charAt(0)=='S') || (con.charAt(0)=='s')){
	      		//es consulta 	  
	    	   // seteamos la consulta a partir de la cual se obtendrán los datos para llenar la tabla
	    	  tabla.setSelectSql(this.consulta.getText().trim());

	    	  // obtenemos el modelo de la tabla a partir de la consulta para 
	    	  // modificar la forma en que se muestran de algunas columnas  
	    	  tabla.createColumnModelFromQuery();
	    	  textArea.setText(textArea.getText()+"consulta realizada con éxito\n\n");
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
	      	}else{
	      			java.sql.Statement stm= conexion.getConnection().createStatement();
	      			stm.execute(con);
	      			stm.close();
	      			textArea.setText(textArea.getText()+"insert/update/delete realizado con éxito\n\n");
	      		}
	    	  
	    	  
	       }
	      catch (SQLException ex){ }
	      
	   }
}
