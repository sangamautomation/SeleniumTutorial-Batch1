package utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

/**
 *Read & Write from/to Property File
 */
public class PropertyUtils {
	
	
	public static String propertyFile_Read(String path, String prop){
		
		
		Properties props = new Properties();
		
		try {
			File file = new File(path);
			FileInputStream fis = new FileInputStream(file);
			props.load(fis);
		} catch (FileNotFoundException e) {
 			e.printStackTrace();
		} catch (IOException e) {
 			e.printStackTrace();
		}
		System.out.println("Property is read for "+prop +"="+props.getProperty(prop));

		return props.getProperty(prop);
		
	}
	
	
	public static void propertyFile_Write(String path, String prop, String value){
		
	Properties props = new Properties();
		
		try {
			File file = new File(path);
			FileInputStream fis = new FileInputStream(file);
			props.load(fis);
		} catch (FileNotFoundException e) {
 	//		e.printStackTrace();
		} catch (IOException e) {
 	//		e.printStackTrace();
		}
		
	 	
		
		try {
			if(value!=null){
				props.setProperty(prop, value);
			props.store(new FileOutputStream(path), "");
			System.out.println("Property is set for "+prop +"="+value);
 			}
			else
				System.out.println("Property NOT set for "+prop);
		} catch (FileNotFoundException e) {
 			e.printStackTrace();
		} catch (IOException e) {
 			e.printStackTrace();
		}
		
		
	}

}
