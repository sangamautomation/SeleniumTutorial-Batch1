package pageFlows;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.Select;

import infrastructure.Operations;
import pageObjects.FlightFinder;
import utils.ReportUtils;

public class Flights {
	
	Operations op = new Operations();
	
public void flightFinder(WebDriver driver){
	System.out.println("\n******************** Flight Finder ********************\n");	

	// Clicking on Flights link
	op.clickLink(driver, FlightFinder.link_Flights);
	//driver.findElement(By.xpath(FlightFinder.link_Flights)).click();
	op.waitImplicitely(driver, 10);
	//driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
	
	//Flight Finder
	op.clickRadiobutton(driver, FlightFinder.radiobutton_FlightTypeRoundtrip);
	op.selectDropdown(driver, FlightFinder.dropdown_Passengers, "2");
	op.selectDropdown(driver, FlightFinder.dropdown_DepartFrom, "New York");
	op.selectDropdown(driver, FlightFinder.dropdown_OnMonth, "November");
	op.selectDropdown(driver, FlightFinder.dropdown_OnDay, "25");
	op.selectDropdown(driver, FlightFinder.dropdown_ArrivingIn, "Paris");
	
	
// Preferences
	op.clickRadiobutton(driver, FlightFinder.radiobutton_ServiceClassFirstClass);
	
	ReportUtils.reportResult("Done", "Flight Finder", "Flight Finder is successful!");

	op.clickLink(driver, FlightFinder.button_Continue);
	
}

}
