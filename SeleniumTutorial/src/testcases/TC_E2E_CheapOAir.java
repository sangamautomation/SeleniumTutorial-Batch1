package testcases;
/*package testcases;

import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.interactions.Actions;

import data.Constants;
import infra.SeleniumDescriptive;
import pageObjects_Kayak.PO_Home;
import setup.TestRunSetup;
import setup.TestSetup;
import utils.KeyboardUtils;
import utils.PropertyUtils;

*//**
 * Test Case Description: 
 *//*
public class TC2_E2E_CheapOAir {

	public static void main(String[] args) throws Exception {
		WebDriver driver =null;
		KeyboardUtils k = new KeyboardUtils();
		try {
			//********* Declarations ***********
			
			String URL=PropertyUtils.propertyFile_Read(Constants.path_PropertyFile_config, "URL2"	);
			SeleniumDescriptive sd = new SeleniumDescriptive();
			
		//	System.setProperty("webdriver.gecko.driver", "D:\\Selenium_Drivers\\drivers\\geckodriver.exe");
		//	driver = new FirefoxDriver();
	 		//	driver.manage().window().maximize();

			driver = TestSetup.launchBrowser("Chrome");
 			
			TestRunSetup.prerequisites(driver, URL);
			
			Thread.sleep(20000);
			//Flights
			try {
				sd.clickLink(driver, PO_Home.LINK_POPUP);
			} catch (Exception e) {
 				 System.out.println("POPUP does not occur!");
			}
			sd.selectRadiobutton(driver, PO_Home.RADIO_ONEWAY);
			sd.setText(driver, PO_Home.TEXTBOX_FROM, "Las Vegas");
			k.Key_Enter();
			sd.setText(driver, PO_Home.TEXTBOX_TO, "NYC");
			k.Key_Enter();
			Thread.sleep(10000);
			
			sd.clickLink(driver, PO_Home.DATE_DEPART);
			
			
			
 		} catch (Exception e) {
 			e.printStackTrace();
 			throw e;
		}
		
		
		//driver.quit();

	}

}
*/