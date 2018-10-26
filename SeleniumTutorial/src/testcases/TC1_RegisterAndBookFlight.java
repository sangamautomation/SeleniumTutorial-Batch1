package testcases;

import org.openqa.selenium.WebDriver;

import flows.BookAFlightValidatePrice;
import flows.FlightConfirmationValidation;
import flows.Flights;
import flows.Register;
import flows.SelectFlightDepartReturn;
import flows.SignOn;
import infrastructure.Setup;

public class TC1_RegisterAndBookFlight {

	public static void main(String[] args) {
		
		//Variable Declarations
		WebDriver driver = null;
		
		try {
			//Setup
			Setup setup = new Setup();
			String url = "http://www.newtours.demoaut.com/";
			
			//Setup the WebDriver
			 driver = setup.launchBrowser(url);
			
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
	//		driver.close();
		}

		
		
	}

}
