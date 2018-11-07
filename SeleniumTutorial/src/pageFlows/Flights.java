package pageFlows;

import java.util.HashMap;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.Select;

import infrastructure.Operations;
import pageObjects.FlightFinder;
import utils.ExcelUtils;
import utils.ReportUtils;

public class Flights {
	
	Operations op = new Operations();
	
	
	
public void flightFinder(WebDriver driver) throws Exception{
	System.out.println("\n******************** Flight Finder ********************\n");	

	String filePath = "C:/AutomationProjects/SeleniumTutorial/resource/TestDataPool_Automation.xls";
	String sheetName = "Automation";
	int headerRowNum = 0;
	int tcRowNum = 1;
	
	HashMap<String,String> rowData = ExcelUtils.getTestDataXls(filePath, sheetName, headerRowNum, tcRowNum);
	
	
	// Clicking on Flights link
	op.clickLink(driver, FlightFinder.link_Flights);
	//driver.findElement(By.xpath(FlightFinder.link_Flights)).click();
	op.waitImplicitely(driver, 10);
	//driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
	
	//Flight Finder
	op.clickRadiobutton(driver, FlightFinder.radiobutton_FlightTypeRoundtrip);
	op.selectDropdown(driver, FlightFinder.dropdown_Passengers, rowData.get("noOfPassengers"));
	op.selectDropdown(driver, FlightFinder.dropdown_DepartFrom, rowData.get("departFrom"));
	op.selectDropdown(driver, FlightFinder.dropdown_OnMonth, rowData.get("departMonth"));
	op.selectDropdown(driver, FlightFinder.dropdown_OnDay, rowData.get("departDay"));
	op.selectDropdown(driver, FlightFinder.dropdown_ArrivingIn, rowData.get("arrivingIn"));
	
	
// Preferences
	op.clickRadiobutton(driver, FlightFinder.radiobutton_ServiceClassFirstClass);
	
	ReportUtils.reportResult("Done", "Flight Finder", "Flight Finder is successful!");

	op.clickLink(driver, FlightFinder.button_Continue);
	
}

}
