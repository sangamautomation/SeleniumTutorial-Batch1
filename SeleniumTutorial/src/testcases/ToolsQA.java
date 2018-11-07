/*package testcases;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.interactions.Actions;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

import infra.SeleniumDescriptive;
import pageObjects.PO_ToolsQA;
 
public class ToolsQA {

	public static void main(String[] args) throws InterruptedException{ 
		
		WebDriver driver = null;
		
		try {
		//String[] = String...

			SeleniumDescriptive sd = new SeleniumDescriptive();


			//	System.setProperty("webdriver.gecko.driver", "D:/Selenium_Drivers/drivers/geckodriver.exe");
			System.setProperty("webdriver.chrome.driver", "D:/Selenium_Drivers/drivers/chromedriver.exe");

			
			//	driver = new FirefoxDriver();
			driver = new ChromeDriver();

			driver.manage().window().maximize();

			driver.get("http://toolsqa.com/automation-practice-form/");

			driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
			
			
			// Actions::
			
			Actions actions = new Actions(driver);
			WebElement we = driver.findElement(By.xpath(""));
			actions.moveToElement(we).contextClick().click().doubleClick().build().perform();
			 
			
			

			sd.setText(driver, "//input[@name='firstname']", "selenium");
			sd.setText(driver, "//input[@name='lastname']", "automation");

			sd.selectRadiobutton(driver, "//input[@value='Male']");
			sd.selectRadiobutton(driver, "//input[@value='3']");


			sd.selectCheckbox(driver, "//input[@value='Automation Tester']");


			sd.clickLink(driver, "//a[text()='Test File to Download']");

			sd.selectDropdown(driver, "//select[@id='continents']", "North America");

			sd.selectDropdown(driver, "//select[@id='selenium_commands']", "Wait Commands");

			sd.clickLink(driver, "//button[text()='Button']");

			String text = sd.getWidgetText(driver, "//span[@class='bcd']");

			System.out.println(text);

			Thread.sleep(5000);


			// Web Table


			sd.clickLink(driver, "//a[contains(@title,'Automation Practice Table')]");

			sd.wait(driver,10);

			//String tableText=	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr[1]/td[1]"); 

		 	String[][] tableData = new String[10][10]; //max rows = 10, max cols = 10
			for (int i = 1; i <= 4; i++) {
				for (int j = 1; j <= 6; j++) {
  			 	tableData[i][j] =  	sd.getWidgetText(driver, PO_ToolsQA.text_Table(i, j)); 
 				  //	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr["+i+"]/td["+j+"]"); 
  			 //	sd.clickLink(driver, "//div[@id='content']//table//tbody/tr[1]/td[6]");
			 	System.out.print(tableData[i][j] +"	");
				}
				System.out.println();
			}
 
			String tableData1 =	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr[1]/td[1]"); 
			String tableData2 =	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr[1]/td[2]"); 
			String tableData3 =	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr[1]/td[3]"); 
			String tableData4 =	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr[2]/td[1]"); 
			String tableData5 =	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr[2]/td[2]"); 
			String tableData6 =	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr[3]/td[1]"); 
			String tableData7 =	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr[3]/td[3]"); 
			String tableData8 =	sd.getWidgetText(driver, "//div[@id='content']//table//tbody/tr[4]/td[4]"); 


			
	} catch (Exception e) {
		 
		e.printStackTrace();
	}
	
	finally{
		
		driver.quit();	
	}

	}
}
*/