package testcases;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import utils.ReportUtils;

public class Frames {
	
	public static void main(String[] args) throws InterruptedException{ //String[] = String...
		//	System.setProperty("webdriver.gecko.driver", "D:/Selenium_Drivers/drivers/geckodriver.exe");
		System.setProperty("webdriver.chrome.driver", "D:/Selenium_Drivers/drivers/chromedriver.exe");

		WebDriver driver = null;
		//	driver = new FirefoxDriver();
		driver = new ChromeDriver();

		driver.manage().window().maximize();

		driver.get("http://way2automation.com/way2auto_jquery/frames-windows/frameset.html");

		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

		String expectedText = "Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text. Demo text.";
		
		//Switch to Frame:
		
		WebElement we = driver.findElement(By.xpath("//frame[@name='topFrame']"));
		driver.switchTo().frame(we);
		
		//Operation
		String text =  driver.findElement(By.xpath("//p[contains(text(),'Demo')]")).getText();
		System.out.println("Text captured inside a frame: "+text);
		
		driver.switchTo().defaultContent();
		
		if(expectedText.equals(text))
			ReportUtils.reportResult("Pass", "Captured text is correct!", text);
		else
			ReportUtils.reportResult("Fail", "Captured text is NOT correct!", text);

	//	Thread.sleep(5000);
 		
		driver.quit();
		
		
	}
	
	
	

}
