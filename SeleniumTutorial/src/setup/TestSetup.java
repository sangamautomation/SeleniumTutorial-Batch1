
package setup;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.ie.InternetExplorerDriver;
import org.openqa.selenium.opera.OperaDriver;
import org.openqa.selenium.safari.SafariDriver;
//import org.uiautomation.ios.setup.IOSDeviceManagerFactory;

public class TestSetup {
	
//	private static WebDriver driver = null;
	public TestSetup(){/*
		  driver = new ChromeDriver();
		//private static WebDriver driver_Firefox = new FirefoxDriver();

		System.setProperty("webdriver.chrome.driver", "D:\\Selenium_Drivers\\drivers\\chromedriver.exe");
 	*/}
	
	public static WebDriver getDriver(){
 		WebDriver driver = null;
 		return driver;
		 
	}
	
	
	/**
	 * launchBrowser - with Browser Type 
	 * @param browserType
	 * @return
	 */
	public static WebDriver launchBrowser(String browserType){
		
		WebDriver driver = null;
		
		switch (browserType) {
		case "Chrome":
			System.setProperty("webdriver.chrome.driver", "D:/Selenium_Drivers\\drivers/chromedriver.exe");
			driver = new ChromeDriver();
			break;
		case "Firefox":
			System.out.println("Entered Firefox.....");
			System.setProperty("webdriver.gecko.driver", "D:/Selenium_Drivers\\drivers/geckodriver.exe");
			driver = new FirefoxDriver();
			//driver = new MarionetteDriver();
			break;
		case "IE":
			System.setProperty("webdriver.ie.driver", "D:/Selenium_Drivers\\drivers/IEDriverServer_x64.exe");
			driver = new InternetExplorerDriver();
 			break;
		case "Edge":
			System.setProperty("webdriver.edge.driver", "D:/Selenium_Drivers\\drivers/MicrosoftWebDriver.exe");
			driver = new EdgeDriver();
 			break;
		case "Safari":
			System.setProperty("webdriver.safari.driver", "D:/Selenium_Drivers\\drivers/SafariDriver.safariextz");
			driver = new SafariDriver();
 			break;
		case "Opera":
			System.setProperty("webdriver.opera.driver", "D:/Selenium_Drivers\\drivers/operadriver.exe");
			driver = new OperaDriver();
 			break;	
 		default:
 			System.setProperty("webdriver.chrome.driver", "D:/Selenium_Drivers\\drivers/chromedriver.exe");
			driver = new ChromeDriver();
			break;
 		}
		
		driver.manage().window().maximize(); // Maximize the Browser window
 	
		return driver;
		
		
	}

}
