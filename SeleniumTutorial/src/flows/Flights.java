package flows;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import pageObjects.FlightFinder;

public class Flights {
	
public void flightFinder(WebDriver driver){
	
	driver.findElement(By.xpath(FlightFinder.link_Flights)).click();
	driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
	driver.findElement(By.xpath(FlightFinder.radiobutton_FlightType)).click();

	
	
}

}
