package com.dash.apputil;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class LoadProp {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Properties prop = new Properties();
		InputStream input = null;
		
		try {

			input = new FileInputStream("config/dbconfig.properties");

			// load a properties file
			prop.load(input);

			// get the property value and print it out
			System.out.println(prop.getProperty("dbName"));
			System.out.println(prop.getProperty("dbUserName"));
			System.out.println(prop.getProperty("dbPassword"));

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
