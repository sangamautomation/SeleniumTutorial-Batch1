package pageFlows;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import infrastructure.Operations;
import pageObjects.SelectFlight;

public class SelectFlightDepartReturn {

	Operations op = new Operations();

	public void departFlight(WebDriver driver){
		System.out.println("\n******************** departFlight ********************\n");	
		op.clickRadiobutton(driver, SelectFlight.radiobutton_DepartUnitedAirlines);
	}

	public void returnFlight(WebDriver driver){
		System.out.println("\n******************** returnFlight ********************\n");	
		op.clickRadiobutton(driver, SelectFlight.radiobutton_ReturnBlueSkies);
	}

	public void continueFlight(WebDriver driver){
		System.out.println("\n******************** continueFlight ********************\n");	
		op.clickRadiobutton(driver, SelectFlight.button_Continue);
	}

}
