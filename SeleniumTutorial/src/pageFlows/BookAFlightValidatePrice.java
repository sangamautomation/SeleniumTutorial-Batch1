package pageFlows;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

import infrastructure.Operations;
import pageObjects.BookAFlight;

public class BookAFlightValidatePrice {
	Operations op = new Operations();
	static int totalPriceInt=0;

	//Price Validation
	public void validatePrice(WebDriver driver){
		System.out.println("\n********************* validatePrice *********************\n");

		//Capturing text
		String departFlightPrice = op.getText(driver, BookAFlight.text_DepartFlightPrice);
		//String departFlightPrice = driver.findElement(By.xpath(BookAFlight.text_DepartFlightPrice)).getText();
		String returnFlightPrice = op.getText(driver, BookAFlight.text_ReturnFlightPrice);
		String noOfPassengers = op.getText(driver, BookAFlight.text_NoOfPassengers);
		String tax = op.getText(driver, BookAFlight.text_Tax);
		String totalPrice = op.getText(driver, BookAFlight.text_TotalPrice);

		//Converting String to Integer
		int departFlightPriceInt = Integer.parseInt(departFlightPrice);
		int returnFlightPriceInt = Integer.parseInt(returnFlightPrice);
		int noOfPassengersInt = Integer.parseInt(noOfPassengers);

		//Getting rid of any special character
		tax = tax.substring(1);
		int taxInt = Integer.parseInt(tax);

		totalPrice = totalPrice.substring(1);
		totalPriceInt = Integer.parseInt(totalPrice);

		//Validation

		int departReturnFlightPrice = departFlightPriceInt+returnFlightPriceInt;
		if((departReturnFlightPrice*noOfPassengersInt)+taxInt == totalPriceInt)
			System.out.println("PASS : Total price displayed is correct!");
		else
			System.out.println("FAIL : Total price displayed is NOT correct!");

	}


	//Passenger
	public void passengersInfo(WebDriver driver){
		System.out.println("\n********************* passengersInfo *********************\n");
		op.setText(driver, BookAFlight.textBox_FirstName1, "John");
		op.setText(driver, BookAFlight.textBox_LastName1, "Doe");
		op.setText(driver, BookAFlight.textBox_FirstName2, "Thamina");
		op.setText(driver, BookAFlight.textBox_LastName2, "Alam");

	}

	//Credit Card
	public void creditCardInfo(WebDriver driver){
		System.out.println("\n********************* creditCardInfo *********************\n");

		op.selectDropdown(driver, BookAFlight.dropdown_CreditCardType, "Discover");
		op.setText(driver, BookAFlight.textBox_CreditCardNumber, "1234567890123456");

		op.selectDropdown(driver, BookAFlight.dropdown_CreditCardExpirationMonth, "12");
		op.selectDropdown(driver, BookAFlight.dropdown_CreditCardExpirationYear, "2009");


		//Checkbox Operation
		op.clickCheckbox(driver, BookAFlight.checkbox_TicketlessTravel);

		//Submit
		op.clickLink(driver, BookAFlight.button_SecurePurchase);

	}

}
