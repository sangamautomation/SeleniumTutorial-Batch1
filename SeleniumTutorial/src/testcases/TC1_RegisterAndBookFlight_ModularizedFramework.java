package testcases;

import org.openqa.selenium.WebDriver;

import flows_ModularizedFramework.BookAFlightValidatePrice;
import flows_ModularizedFramework.FlightConfirmationValidation;
import flows_ModularizedFramework.Flights;
import flows_ModularizedFramework.Register;
import flows_ModularizedFramework.SelectFlightDepartReturn;
import flows_ModularizedFramework.SignOn;
import infrastructure.Setup;

public class TC1_RegisterAndBookFlight_ModularizedFramework {

	public static void main(String[] args) {
		
		//Variable Declarations
		WebDriver driver = null;
		
		try {
			//Setup
			Setup setup = new Setup();
			String url = "http://www.newtours.demoaut.com/";
			
			//Setup the WebDriver
			 driver = setup.launchBrowser(url, null);
			
			//Registration
			Register register = new Register();
			register.registration(driver);
			
			/*//SignIn
			SignOn signin = new SignOn();
			signin.signin(driver);
			*/
			
			//Flight Finder
			Flights flights = new Flights();
			flights.flightFinder(driver);
			
			//Select Flight
			new SelectFlightDepartReturn().departFlight(driver);
			new SelectFlightDepartReturn().continueFlight(driver);
			
			//Book A Flight
			BookAFlightValidatePrice.validatePrice(driver);
			BookAFlightValidatePrice.passengersInfo(driver);
			BookAFlightValidatePrice.creditCardInfo(driver);
			
			//Flight Confirmation
			FlightConfirmationValidation.validateFlightConfirmation(driver);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			driver.close();
		}

		
		
	}

}
