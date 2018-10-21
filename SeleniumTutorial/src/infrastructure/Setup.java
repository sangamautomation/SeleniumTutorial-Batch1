package infrastructure;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class Setup {
	
	public WebDriver launchBrowser(String url){
		//Create Static WebDriver
			
		WebDriver driver = null;
		
		try {
			System.setProperty("webdriver.chrome.driver","C:\\drivers\\chromedriver.exe");
			driver = new ChromeDriver();
			
			driver.get(url);
			driver.manage().window().maximize();
		} catch (Exception e) {
 			e.printStackTrace();
		}
		
		return driver;
		
	}

}
