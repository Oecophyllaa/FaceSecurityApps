package apps;

import com.mysql.jdbc.Driver;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DB {
    private static Connection conn;
    
    public static Connection getConn() throws SQLException {
        if(conn==null) {
            new Driver();
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_facesecurity","root","");
        }
        
        return conn;
    }
}
