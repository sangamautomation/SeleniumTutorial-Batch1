package testcases;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import utils.PropertyUtils;
import utils.ReportUtils;
import utils.ScreenshotUtils;

public class Alert {

	public static void main(String[] args) throws InterruptedException{ //String[] = String...
		String URL = args[0];
 		//String URL = args[0].toString().toUpperCase();
		//	System.setProperty("webdriver.gecko.driver", "D:/Selenium_Drivers/drivers/geckodriver.exe");
		System.setProperty("webdriver.chrome.driver", "D:/Selenium_Drivers/drivers/chromedriver.exe");

		WebDriver driver = null;
		//	driver = new FirefoxDriver();
		driver = new ChromeDriver();

		driver.manage().window().maximize();
		driver.get(URL);
 		//driver.get("http://output.jsbin.com/usidix/1");

		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

		driver.findElement(By.xpath("//input[contains(@value,'Go')]")).click();

		Thread.sleep(5000);

		//Screenshot
		//ScreenshotUtils.screenshot("D:\\Selenium_Logs\\Screenshots", 1);

		String alertMessage_Expected= "This is alert box";

		//Alert / Popup - Capture text

		String alertMessage = driver.switchTo().alert().getText();
		System.out.println("Alert message is = "+alertMessage);


		if (alertMessage.equals(alertMessage_Expected))  
			ReportUtils.reportResult("Pass", "Alert Message is correct", alertMessage);
		else
			ReportUtils.reportResult("Fail", "Alert Message is wrong", alertMessage);

PropertyUtils.propertyFile_Write("D:/Selenium_Logs/Screenshots/Captions.properties", "Caption0001", "Pass-Medicaid ID : Medicaid ID: 8304720202");

		// ALert - OK
		Thread.sleep(5000);

		driver.switchTo().alert().accept();// Click OK
	//	driver.switchTo().alert().dismiss();// Click on Red X or Cancel
		
	//	driver.switchTo().alert().dismiss();
		 

		Thread.sleep(5000);
		//	driver.close();//closing the single instance of browser
		driver.quit();//close all instances of browser


		
		
		
	}


}
