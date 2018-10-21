package testcases;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class Selenium2Example {

	public static void main(String[] args) throws Exception {

		// Configure Chrome Driver	
		System.setProperty("webdriver.chrome.driver", "C:\\drivers\\chromedriver.exe");

		// Create a new instance of Chrome Driver
		WebDriver driver = new ChromeDriver();

		try {

	         System.out.println("============================ Test case starts ==========================");

			//Launch chrome browser and open URL
			driver.get("https://www.google.com/");
			
			//Maximize the browser
			driver.manage().window().maximize();
			System.out.println("Application opened.");

			//XPath for Search text box
			String searchBox_Xpath = "//input[contains(@name,'q')]";
			String searchTerm = "Flight Bookings in Chicago";

			//Operate on text box
			driver.findElement(By.xpath(searchBox_Xpath)).clear();
			driver.findElement(By.xpath(searchBox_Xpath)).click();
			driver.findElement(By.xpath(searchBox_Xpath)).sendKeys(searchTerm);
			System.out.println("Entered the search term = "+searchTerm);


			driver.findElement(By.xpath("//img[contains(@alt,'Google')]")).click(); // Escape the auto suggestions
			System.out.println("Clicked on image to escape the auto suggestion box");

			
			//Submit the search results
			String button_Xpath = "//div//div[contains(@class,'FPdoLc VlcLAe')]//input[contains(@value,'Google Search') and contains(@name,'btnK')]";
					
			// String button_Xpath1 =	"//div[contains(@jsname,'VlcLAe')]//input[contains(@name,'btnK') and contains(@value,'Google Search')]";
			
			driver.findElement(By.xpath(button_Xpath)).click();
			System.out.println("Clicked on Google search button");


			//Validations
			
			// Capture the text from Page title
			String actualPageTitle = driver.getTitle();
			System.out.println("Title of the page is : "+ actualPageTitle);

			//	driver.wait(1000); //implicit wait
			Thread.sleep(2000); //static wait

			//Validate the Page time

			String expectedPageTitle = searchTerm+" - Google Search";  // Business requirement specification (BRS) & test case 

			// Compare expected and actual values
			if(expectedPageTitle.equals(actualPageTitle))
				System.out.println("PASS - Page title is correct!");
			else
				System.out.println("FAIL - Page title is NOT correct per the expected \n"+ "Expected="+expectedPageTitle +"\n Actual="+actualPageTitle); 

         System.out.println("============================ Test case ends ==========================");

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.toString());
			throw e;
		}

		finally{
			driver.close();
			//driver.quit();
		}

	}

}
