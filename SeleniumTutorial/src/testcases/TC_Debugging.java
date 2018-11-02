package testcases;

import java.util.HashMap;

import org.apache.commons.io.FileSystemUtils;

import utils.ExcelUtils;
import utils.PropertyUtils;
import utils.ScreenshotUtils;

public class TC_Debugging {

	public static void main(String[] args) throws Exception {

		String folderPath = "C:\\Utils";
		String path = "C:\\Utils\\Data.properties";

	PropertyUtils.propertyFile_Write(path, "FirstName", "John");	
	PropertyUtils.propertyFile_Write(path, "LastName", "Walkman");	

	String propValue = PropertyUtils.propertyFile_Read(path, "LastName");
	
		
	ScreenshotUtils.screenshot(folderPath, 1);
	Thread.sleep(5000);
	ScreenshotUtils.screenshot(folderPath, 2);
	
	utils.FileSystemUtils.createFolder("C:\\Selenium_Logs\\Screenshots\\MyFolder");
	utils.FileSystemUtils.createFile("C:\\Selenium_Logs\\Screenshots\\MyFolder\\", "MyFile", "txt");

	
	String datapoolPath = "C:\\AutomationProjects\\SeleniumTutorial\\resource\\TestDataPool_Automation.xls";
	String sheetName = "Automation";
	int header=0;
	int tc=1;
	
	HashMap<String, String> rowData = ExcelUtils.getTestDataXls(datapoolPath, sheetName, header, tc);
	
	String firstName1 = rowData.get("firstName1");
	
	System.out.println("First name = "+ firstName1);
	}

}
