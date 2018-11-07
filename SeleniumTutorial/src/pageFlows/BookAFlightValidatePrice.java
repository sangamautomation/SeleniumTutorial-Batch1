package pageFlows;

import java.util.HashMap;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.Select;

import infrastructure.Operations;
import pageObjects.BookAFlight;
import utils.ExcelUtils;
import utils.ReportUtils;

public class BookAFlightValidatePrice {
	Operations op = new Operations();
	static int totalPriceInt=0;

	
	
	//Price Validation
	public void validatePrice(WebDriver driver) throws Exception{
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

		//Book Flight - Validation

		int departReturnFlightPrice = departFlightPriceInt+returnFlightPriceInt;

		if((departReturnFlightPrice*noOfPassengersInt)+taxInt == totalPriceInt)
			ReportUtils.reportResult("Pass", "Book A Flight - Total Price", "Total price displayed is correct!");

		else
			ReportUtils.reportResult("Fail", "Book A Flight - Total Price", "Total price displayed is NOT correct!");

	}


	//Passenger
	public void passengersInfo(WebDriver driver) throws Exception{
		System.out.println("\n********************* passengersInfo *********************\n");
		
		String filePath = "C:/AutomationProjects/SeleniumTutorial/resource/TestDataPool_Automation.xls";
		String sheetName = "Automation";
		int headerRowNum = 0;
		int tcRowNum = 1;
		
		HashMap<String,String> rowData = ExcelUtils.getTestDataXls(filePath, sheetName, headerRowNum, tcRowNum);
		
		
		op.setText(driver, BookAFlight.textBox_FirstName1, rowData.get("firstName1"));
		op.setText(driver, BookAFlight.textBox_LastName1, rowData.get("lastName1"));
		op.setText(driver, BookAFlight.textBox_FirstName2, rowData.get("firstName2"));
		op.setText(driver, BookAFlight.textBox_LastName2, rowData.get("lastName2"));

	}

	//Credit Card
	public void creditCardInfo(WebDriver driver) throws Exception{
		

		String filePath = "C:/AutomationProjects/SeleniumTutorial/resource/TestDataPool_Automation.xls";
		String sheetName = "Automation";
		int headerRowNum = 0;
		int tcRowNum = 1;
		
		HashMap<String,String> rowData = ExcelUtils.getTestDataXls(filePath, sheetName, headerRowNum, tcRowNum);
		
		System.out.println("\n********************* creditCardInfo *********************\n");

		op.selectDropdown(driver, BookAFlight.dropdown_CreditCardType, rowData.get("creditCardType"));
		op.setText(driver, BookAFlight.textBox_CreditCardNumber, rowData.get("creditCardNumber"));

		op.selectDropdown(driver, BookAFlight.dropdown_CreditCardExpirationMonth, rowData.get("CreditCardExpirationMonth"));
		op.selectDropdown(driver, BookAFlight.dropdown_CreditCardExpirationYear, rowData.get("CreditCardExpirationYear"));


		//Checkbox Operation
		op.clickCheckbox(driver, BookAFlight.checkbox_TicketlessTravel);

		ReportUtils.reportResult("Done", "Book A Flight", "Book A Flight is successful!");

	
		//Submit
		op.clickLink(driver, BookAFlight.button_SecurePurchase);

	}

}
