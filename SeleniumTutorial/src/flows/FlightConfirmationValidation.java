package flows;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import pageObjects.FlightConfirmation;

public class FlightConfirmationValidation {
	
	
	public static void validateFlightConfirmation(WebDriver driver){
	
	// Capturing the text
	String departFlightPrice = driver.findElement(By.xpath(FlightConfirmation.text_DepartFlightPrice)).getText();
	String returnFlightPrice = driver.findElement(By.xpath(FlightConfirmation.text_ReturnFlightPrice)).getText();
	String noOfPassengers = driver.findElement(By.xpath(FlightConfirmation.text_NoOfPassenger)).getText();
	String tax = driver.findElement(By.xpath(FlightConfirmation.text_Tax)).getText();
	String totalPrice = driver.findElement(By.xpath(FlightConfirmation.text_TotalPrice)).getText();
	
	System.out.println("departFlightPrice = "+departFlightPrice);
	System.out.println("returnFlightPrice = "+returnFlightPrice);
	System.out.println("noOfPassengers = "+noOfPassengers);
	System.out.println("tax = "+tax);
	System.out.println("totalPrice = "+totalPrice);

	//Extract the required text using regular expressions
	
	//Assert Non-Null 
	boolean departFlightPriceBoolean = departFlightPrice.matches("[$][0-9]*"); // Use Regular Expression like ^$[0-9]*$
	
	if(departFlightPriceBoolean)
		System.out.println("Pass : The depart flight price is displayed!");
	
	// Assert equals (expected = actual)
	
	//Assert Non-Null 
	boolean returnFlightPriceBoolean = returnFlightPrice.matches("dfgdf"); // Use Regular Expression like ^$[0-9]*$
	if(returnFlightPriceBoolean)
		System.out.println("Pass : The return flight price is displayed!");
	
	// Assert equals (expected = actual)

	
	int noOfPassengersIndex = noOfPassengers.indexOf(' ');
	noOfPassengers = noOfPassengers.substring(0, noOfPassengersIndex); //2 passengers
	
	
	int taxIndex = totalPrice.indexOf(' ');
	tax = tax.substring(1, taxIndex); 	//$12 USD = 12
	  
	
	int totalPriceLastIndex = totalPrice.indexOf(' ');
	totalPrice = totalPrice.substring(1, totalPriceLastIndex); // $11243 USD = 11243
 
	//Converting from String integer
	int departFlightPriceInt = Integer.parseInt(departFlightPrice);
	int returnFlightPriceInt = Integer.parseInt(returnFlightPrice);
	int noOfPassengersInt = Integer.parseInt(noOfPassengers);
	int taxInt = Integer.parseInt(tax);;
	int totalPriceInt = Integer.parseInt(totalPrice);;
	
	//TODO Calculations
	
	
	
	driver.findElement(By.xpath(FlightConfirmation.button_Logout)).click();
	
	
	}
}
