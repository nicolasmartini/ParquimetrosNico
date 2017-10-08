import java.sql.*;

import javax.swing.JOptionPane;


public class ConexionMySQL  {

    private String db = "parquimetros";
    private String url = "jdbc:mysql://localhost/"+db;
    private String user ;
    private String pass;
    private Connection conexion;

   public Connection Conectar(String u,String p ){

       Connection link = null;

       try{
    	   
           Class.forName("org.gjt.mm.mysql.Driver");
           user = u;
           pass = p;

           link = DriverManager.getConnection(this.url, this.user, this.pass);

       }catch(Exception ex){

           JOptionPane.showMessageDialog(null, ex);

       }

       conexion=link;
       return link;

   }
   
   public String getUser(){
	   
	   return user;
	   
   }
   
   public String getPass(){
	   return pass;
	   
   }
   
   public String getdriver(){
	   
	   return "com.mysql.jdbc.Driver";
   }
   
   public String uri(){
	   
	   return url;
   }
   
   public Connection getConnection(){
	   return conexion;
   }
   
   public String[] obtenerTablas(){
	 String[] toReturn=null;
	 try{	
			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();
			toReturn= new String[12];
			// Se prepara el string SQL de la consulta
			String sql = "SHOW TABLES;" ; 
		
			// Se ejecuta la sentencia y se recibe un resultado
			java.sql.ResultSet rs = stmt.executeQuery(sql);
			int pos=0;
			while(rs.next())
			{
				toReturn[pos++]=(rs.getString("Tables_in_parquimetros"));
			}
	 }
		catch (java.sql.SQLException ex) {System.out.println("Error");}

	 return toReturn;
   }
   public String[] atributos(String s){
	   String[] toReturn=null; 
	   try
		{	
			// Se crea una sentencia jdbc para realizar la consulta
			java.sql.Statement stmt = conexion.createStatement();

			// Se prepara el string SQL de la consulta
			String sql = "describe " + s + ";"; 
			toReturn=new String[20];

			// Se ejecuta la sentencia y se recibe un resultado
			java.sql.ResultSet rs = stmt.executeQuery(sql);
			int pos=0;
			while(rs.next())
			{
				toReturn[pos++]=(rs.getString("Field"));
			}
		}
		catch (java.sql.SQLException ex) {System.out.println("Error");}
	   return toReturn;
   }

}