package testcases;

import org.openqa.selenium.WebDriver;

import pageFlows.BookAFlightValidatePrice;
import pageFlows.FlightConfirmationValidation;
import pageFlows.Flights;
import pageFlows.SelectFlightDepartReturn;
import pageFlows.SignOn;
import utils.ReportUtils;
import pageFlows.Register;
import infrastructure.Setup;

public class TC2_RegisterAndBookFlight_HybridFramework {

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
			
			//Flight Finder
			Flights flights = new Flights();
			flights.flightFinder(driver);
			
			//Select Flight
			new SelectFlightDepartReturn().departFlight(driver);
			new SelectFlightDepartReturn().returnFlight(driver);
			new SelectFlightDepartReturn().continueFlight(driver);
			
			//Book A Flight
			BookAFlightValidatePrice book = new BookAFlightValidatePrice();
			book.validatePrice(driver);
			book.passengersInfo(driver);
			book.creditCardInfo(driver);
		
			//Flight Confirmation
			new FlightConfirmationValidation().validateFlightConfirmation(driver);
			
			//System.out.println("Test case verdict :: "+ "PASS");
			ReportUtils.reportResult("Pass", "Verdict", "Test case is successful!");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			driver.close();
		}

		
		
	}

}
