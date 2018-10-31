package testcases;

import utils.PropertyUtils;
import utils.ScreenshotUtils;

public class TC_Debugging {

	public static void main(String[] args) throws Exception {

		String path = "C:\\Utils\\Data.properties";
		String folderPath = "C:\\Utils\\Screenshots";
/*	PropertyUtils.propertyFile_Write(path, "FirstName", "John");	
	PropertyUtils.propertyFile_Write(path, "LastName", "Walkman");	

	String propValue = PropertyUtils.propertyFile_Read(path, "LastName");
*/	
		
	ScreenshotUtils.screenshot(folderPath, 1);
	Thread.sleep(5000);
	ScreenshotUtils.screenshot(folderPath, 2);
	}

}
