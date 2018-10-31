package pageFlows;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

import infrastructure.Operations;
import pageObjects.*;
import utils.ReportUtils;
import utils.StringUtils;

public class Register {
	Operations op = new Operations();

	String expectedNote="",actualVal="";
	String expectedUserName ="Username2";

	public void registration(WebDriver driver) throws Exception{

		System.out.println("\n******************** Registration ********************\n");	
		//Click Register link
		op.clickLink(driver, Registration.link_Register);

		// Contact Information

		op.setText(driver, Registration.textBox_FirstName, "John");
		op.setText(driver, Registration.textBox_LastName, "Doe");
		op.setText(driver, Registration.textBox_Phone, "1231231234");
		//driver.findElement(By.xpath(Registration.textBox_Phone)).sendKeys("122223333");
		op.setText(driver, Registration.textBox_Email, "john@domain.com");


		//Mailing Information
		op.setText(driver, Registration.textBox_Address1, "123 Main St");
		op.setText(driver, Registration.textBox_Address2, "Suite# A");
		op.setText(driver, Registration.textBox_City, "New York City");
		op.setText(driver, Registration.textBox_StateProvince, "New York");
		op.setText(driver, Registration.textBox_PostalCode, "11370");

		//Selecting Dropdown value
		op.selectDropdown(driver, Registration.dropdown_Country, "UNITED STATES");

		//User Information
		op.setText(driver, Registration.textBox_UserName, expectedUserName);
		op.setText(driver, Registration.textBox_Password, "password123");
		op.setText(driver, Registration.textBox_ConfirmPassword, "password123");

		ReportUtils.reportResult("Done", "Registration", "Registration is successful!");

		op.clickLink(driver, Registration.button_Submit);

		//Synchronization methods
		op.waitImplicitely(driver, 20);

		//Confirmation
		String expectedNote = "Note: Your user name is Username2.";

		String actualNote = op.getText(driver, Registration.text_Note);
		String actualUserName = StringUtils.subString(actualNote, 24, 33);
		//String actualUserName = actualNote.substring(24, 33);
		System.out.println("Actual Note: "+ actualNote);
		System.out.println("Actual UserName: "+ actualUserName);


		//Note Validation
		boolean noteValidation = expectedNote.equals(actualNote);

		if(noteValidation)
			ReportUtils.reportResult("Pass", "Note Validation", "The Note : "+ actualNote +" is matching!");

		else
			ReportUtils.reportResult("Fail", "Note Validation", "Note is Not Matching \n"+ "Expected Note: "+expectedNote + "\n Actual Note: "+actualNote);



		//UserName validation
		if(expectedUserName.equals(actualUserName))
			ReportUtils.reportResult("Pass", "UserName Validation", "The expected Username : \n"+ expectedUserName +" is matching!");
		else
			ReportUtils.reportResult("Fail", "UserName Validation", "User name is Not Matching \n"+ "Expected Username: "+expectedUserName +"\n Actual Username: "+actualUserName);

	}

}
