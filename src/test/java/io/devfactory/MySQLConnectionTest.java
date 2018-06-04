package io.devfactory;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MySQLConnectionTest {

	private static final Logger logger = LoggerFactory.getLogger(MySQLConnectionTest.class);

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
			logger.debug("{}", con);

		} catch (Exception e) {
			logger.error("{}", e);
		}
	}
}
