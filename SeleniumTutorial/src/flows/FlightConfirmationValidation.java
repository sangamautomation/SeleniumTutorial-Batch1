package flows;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import pageObjects.FlightConfirmation;

public class FlightConfirmationValidation {
	
	public static void validateFlightConfirmation(WebDriver driver){
	String departFlightPrice = driver.findElement(By.xpath(FlightConfirmation.text_DepartFlightPrice)).getText();
	String returnFlightPrice = driver.findElement(By.xpath(FlightConfirmation.text_ReturnFlightPrice)).getText();
	String noOfPassengers = driver.findElement(By.xpath(FlightConfirmation.text_NoOfPassenger)).getText();
	String tax = driver.findElement(By.xpath(FlightConfirmation.text_Tax)).getText();
	String totalPrice = driver.findElement(By.xpath(FlightConfirmation.text_TotalPrice)).getText();
	
	//Extract the requried text using regular expression
	departFlightPrice = departFlightPrice.substring(26, 30); // Use Regular Expression like ^$[0-9]*$
	returnFlightPrice = returnFlightPrice.substring(26, 30); // Use Regular Expression like ^$[0-9]*$
	noOfPassengers = noOfPassengers.substring(26, 30); // Use Regular Expression like ^$[0-9]*$
	tax = tax.substring(26, 30); // Use Regular Expression like ^$[0-9]*$
	totalPrice = totalPrice.substring(26, 30); // Use Regular Expression like ^$[0-9]*$
 
	//Converting from String integer
	int departFlightPriceInt = Integer.parseInt(departFlightPrice);
	int returnFlightPriceInt = Integer.parseInt(returnFlightPrice);
	int noOfPassengersInt = Integer.parseInt(noOfPassengers);
	int taxInt = Integer.parseInt(tax);;
	int totalPriceInt = Integer.parseInt(totalPrice);;
	
	
	
	driver.findElement(By.xpath(FlightConfirmation.button_Logout)).click();
	
	
	}
}
