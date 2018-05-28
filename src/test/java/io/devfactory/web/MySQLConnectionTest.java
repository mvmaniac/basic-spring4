package io.devfactory.web;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MySQLConnectionTest {

	// 5.x
	private static final String DRIVER = "com.mysql.jdbc.Driver";		
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/basic_spring?useSSL=false";
	
	// 8.x
//	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
//	private static final String URL = "jdbc:mysql://127.0.0.1:3306/book_ex?useSSL=false&serverTimeZone=Asia/Seoul";
	
	private static final String USER = "basic";
	private static final String PW = "basic";
	
	@Test
	public void testConnection() throws Exception {
		
		Class.forName(DRIVER);
		
		try (Connection con = DriverManager.getConnection(URL, USER, PW)) {
			System.out.println(con);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
