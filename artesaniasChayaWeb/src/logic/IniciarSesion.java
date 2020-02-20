package logic;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;




public class IniciarSesion {
	Connection C=null;

	//Devuelve un boolean si inicia sesion
	public boolean iniciar(String usuario, String contra) {
		try {
			 C = DriverManager.getConnection("jdbc:mysql://localhost:3306/chaya?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC",
					usuario,contra); //"root","adrielcolo"
		
		
				C.close();

	}
		catch (Exception e) {
			return false;
			// TODO: handle exception
		}
		return true;


}
	
}
