package flows_ModularizedFramework;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import pageObjects.SelectFlight;

public class SelectFlightDepartReturn {

	public void departFlight(WebDriver driver){
		
		driver.findElement(By.xpath(SelectFlight.radiobutton_DepartUnitedAirlines)).click();
		
	}
	
	public void returnFlight(WebDriver driver){
		
		driver.findElement(By.xpath(SelectFlight.radiobutton_ReturnBlueSkies)).click();
		
	}
	
	public void continueFlight(WebDriver driver){
		driver.findElement(By.xpath(SelectFlight.button_Continue)).click();

	}
	
}
