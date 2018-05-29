package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB_Connector {

	// 데이터베이스 접속
	public static Connection getConnection() throws Exception{
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection(url, "scott", "1234");
		return conn;
	}
	
}
