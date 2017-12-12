package com.dash.apputil;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class LoadProp {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Properties prop = new Properties();
		InputStream input = null;
		String propFileName="dbConfig.properties";
		
		
		try {
				
			input = LoadProp.class.getClassLoader().getResourceAsStream(propFileName);
			
			//input = new FileInputStream("C:\\Users\\anupk\\workspace\\VersionDash\\config\\dbConfig.properties");
			
			//input = new FileInputStream("dbConfig.properties");
			
			// load a properties file
			//prop.load(input);
			

			if (input != null) {
				prop.load(input);
			} else {
				throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
			}

			// get the property value and print it out
			System.out.println(prop.getProperty("dbName"));
			System.out.println(prop.getProperty("dbUserName"));
			System.out.println(prop.getProperty("dbPassword"));
			System.out.println(System.getProperty("user.dir"));

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
		if (input != null) {
				try {
					input.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

}
