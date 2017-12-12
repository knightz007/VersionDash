package com.dash.dbutil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
 

public class MySqlConnector {
	
	public static Connection getMySQLConnection()
	        throws ClassNotFoundException, SQLException {
	  
	    // Note: Change the connection parameters accordingly.
/*	    String hostName = "localhost";
	    String dbName = "testdb";
	    String userName = "root";
	    String password = "mysql";*/
	    
	    String connectionURL = "";
	    String userName = "";
	    String password = "";
	   
	 // that's everything from the context.xml and from the global configuration
	    try
	    {
/*	     InitialContext ic = new InitialContext();
	     Context xmlContext = (Context) ic.lookup("java:comp/env");	    	
	     String hostNametemp = (String) xmlContext.lookup("dbConnection");*/
	    	InitialContext initialContext = new InitialContext();
	    	Context environmentContext = (Context) initialContext.lookup("java:/comp/env");
	    	connectionURL = (String) environmentContext.lookup("myConnectionURL");
	    	//System.out.println("connectionURL:" + connectionURL);
	        userName= (String) environmentContext.lookup("dbUserName");
	        password=(String) environmentContext.lookup("dbPassword");
	       // System.out.println(username + ":" + pass);
	     
	    }
	    catch(Exception e)
	    {
	    	System.out.println(e.getMessage());
	    }
	    // DataSource myDatasource = (DataSource) xmlContext.lookup("jdbc/testdb");
    
	    // return getMySQLConnection(hostName, dbName, userName, password);
	    return getMySQLConnection(connectionURL, userName, password);	    
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
	
	public static Connection getMySQLConnection(String connectionUrl, String userName, String password) throws SQLException,
	        ClassNotFoundException {
	    
	    // Declare the class Driver for MySQL DB
	    // This is necessary with Java 5 (or older)
	    // Java6 (or newer) automatically find the appropriate driver.
	    // If you use Java> 5, then this line is not needed.
	    Class.forName("com.mysql.jdbc.Driver");
	 
	 
	    // URL Connection for MySQL
	    // Example: jdbc:mysql://localhost:3306/simplehr
	    String connectionURL = connectionUrl;
	 
	    Connection conn = DriverManager.getConnection(connectionURL, userName,
	            password);
	    return conn;
	}
	

}