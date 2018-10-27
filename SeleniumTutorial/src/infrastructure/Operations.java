package infrastructure;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

import utils.LogUtils;

/**
 * @author Sangam
 * @since 10/27/2018
 * Reusable methods to perform operations on different objects using the WebDriver
 *
 */
public class Operations {
	
	/**
	 * This method will click on Link or Button with the given XPath
	 * @param driver
	 * @param xpathLocator
	 */
	public void clickLink(WebDriver driver, String xpathLocator){
		try {
			driver.findElement(By.xpath(xpathLocator)).click();
			LogUtils.log("Clicked on the link for "+ xpathLocator);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	/**
	 * This method will type text in a textbox with the given XPath
	 * @param driver
	 * @param xpathLocator
	 * @param inputText
	 */
	public void setText(WebDriver driver, String xpathLocator, String inputText){
		try {
			driver.findElement(By.xpath(xpathLocator)).clear();
			driver.findElement(By.xpath(xpathLocator)).sendKeys(inputText);
			LogUtils.log("Set text "+ inputText +" for "+ xpathLocator);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * This method will select a desired value from dropdown for the given xpath
	 * @param driver
	 * @param xpathLocator
	 * @param inputText
	 */
	public void selectDropdown(WebDriver driver, String xpathLocator, String inputText){
		try {
			WebElement we = driver.findElement(By.xpath(xpathLocator));
			Select sel = new Select(we);
			sel.selectByVisibleText(inputText);
			LogUtils.log("Selected value "+inputText+ " for "+ xpathLocator);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * This method will wait implicitly for the specified time in seconds
	 * @param driver
	 * @param maxTimeOutInSecond
	 */
	public void waitImplicitely(WebDriver driver, int maxTimeOutInSecond){
		try {
			driver.manage().timeouts().implicitlyWait(maxTimeOutInSecond, TimeUnit.SECONDS);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * This method will return me text for a given xpath
	 * @param driver
	 * @param xPathLocator
	 * @return
	 */
	public String getText(WebDriver driver, String xPathLocator){
	String text = null;
		try {
		 text = driver.findElement(By.xpath(xPathLocator)).getText();
	} catch (Exception e) {
		e.printStackTrace();
	}
	return text;

	}
	
	

}
