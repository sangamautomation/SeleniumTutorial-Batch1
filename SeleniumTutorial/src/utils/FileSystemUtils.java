package utils;

import java.io.File;
import java.io.IOException;

public class FileSystemUtils {
	
	
	// Create Folder
	
	public static void createFolder(String folderPath){
		
		try {
			File folder = new File(folderPath);
			if(!folder.exists()){
				folder.mkdirs();
			System.out.println("Folder is created successfuly!");
			}
			else
				System.out.println("Folder is NOT created !");
		} catch (Exception e) {
 			e.printStackTrace();
		}
	
	}
	
	// Create File
	
	public static void createFile(String folderPath, String fileName, String extension	 ){
		
		try {
			File myFile = new File(folderPath+fileName+"."+extension);
				
			if(myFile.createNewFile())
				System.out.println("File is created successfully!");
			else
				System.out.println("File is NOT created!!");
		} catch (IOException e) {
 			e.printStackTrace();
		}
		
	}
	

}
