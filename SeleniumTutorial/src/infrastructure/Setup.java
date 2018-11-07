package infrastructure;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

public class Setup {
	
	
	public WebDriver launchBrowser(String url, String browser){
		//Create Static WebDriver
			
		WebDriver driver = null;
		try {
		if(browser.equals("chrome")){
		
			System.setProperty("webdriver.chrome.driver","C:\\drivers\\chromedriver.exe");
			driver = new ChromeDriver();
			
			driver.get(url);
			driver.manage().window().maximize();
		}
		else if(browser.equals("firefox")){
			
			System.setProperty("webdriver.gecko.driver","C:\\drivers\\geckodriver.exe");
			driver = new FirefoxDriver();
			
			driver.get(url);
			driver.manage().window().maximize();
		}
		} catch (Exception e) {
 			e.printStackTrace();
		}
		
		return driver;
		
	}

}
