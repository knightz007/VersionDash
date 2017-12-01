package com.dash.dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class MySqlConnector {
	
	public static Connection getMySQLConnection()
	        throws ClassNotFoundException, SQLException {
		
		String hostName = "";
	    String dbName = "";
	    String userName = "";
	    String password = "";
	    Properties prop = new Properties();
		InputStream input = null;
		try
		{
		
		
			input = new FileInputStream("config/dbconfig.properties");


		// load a properties file
		 
		 
		 
		 prop.load(input);
/*		 prop.getProperty("hostname");
		 prop.getProperty("database");
		 prop.getProperty("dbuser");
		 prop.getProperty("dbpassword"); */
		 
		   hostName = prop.getProperty("hostName").toString();
		   dbName =  prop.getProperty("dbName").toString();
		   userName = prop.getProperty("dbUserName").toString();
		   password = prop.getProperty("dbPassword").toString();
		    
		}
		catch(IOException  ex)
		{			
			System.out.println(ex.getMessage());
		}
		catch(Exception e)
		{
			System.out.println("There was an issue");
		}finally {
			if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return getMySQLConnection(hostName, dbName, userName, password);
	    // Note: Change the connection parameters accordingly.
/*	    String hostName = "localhost";
	    String dbName = "testdb";
	    String userName = "root";
	    String password = "mysql";*/
	    //return getMySQLConnection(hostName, dbName, userName, password); 
	}
	
	public static Connection getMySQLConnection(String hostName, String dbName,
	        String userName, String password) throws SQLException,
	        ClassNotFoundException {
	    
	    // Declare the class Driver for MySQL DB
	    // This is necessary with Java 5 (or older)
	    // Java6 (or newer) automatically find the appropriate driver.
	    // If you use Java> 5, then this line is not needed.
	    Class.forName("com.mysql.jdbc.Driver");
	 
	 
	    // URL Connection for MySQL
	    // Example: jdbc:mysql://localhost:3306/simplehr
	    String connectionURL = "jdbc:mysql://" + hostName + ":3306/" + dbName;
	 
	    Connection conn = DriverManager.getConnection(connectionURL, userName,
	            password);
	    return conn;
	}
	

}
