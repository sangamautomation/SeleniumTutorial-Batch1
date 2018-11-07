/*package testcases;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import infra.SeleniumDescriptive;
import infrastructure.Operations;

public class Dropdown {
	
	public static void main(String[] args) throws InterruptedException{ //String[] = String...
		
		Operations sd = new Operations();

		
		//	System.setProperty("webdriver.gecko.driver", "D:/Selenium_Drivers/drivers/geckodriver.exe");

		
		System.setProperty("webdriver.chrome.driver", "D:/Selenium_Drivers/drivers/chromedriver.exe");

		WebDriver driver = null;
		//	driver = new FirefoxDriver();
		driver = new ChromeDriver();

		driver.manage().window().maximize();

		driver.get("http://way2automation.com/way2auto_jquery/dropdown.php");

		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		
		Thread.sleep(25000);
		//Switch to frame
		//driver.switchTo().frame(driver.findElement(By.xpath("//*[@id='example-1-tab-1']/div/iframe")));
		sd.switchToFrame(driver, "//*[@id='example-1-tab-1']/div/iframe");
		Thread.sleep(2000);
		
		//Dropdown
		sd.selectDropdown(driver, "/html/body/select", "India");
		Thread.sleep(8000);
		driver.quit();
		
	}
	

}
*/