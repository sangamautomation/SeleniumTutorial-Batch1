package testcases;

import org.openqa.selenium.WebDriver;

import flows.Register;
import flows.SignOn;
import infrastructure.Setup;

public class TC1_RegisterAndBookFlight {

	public static void main(String[] args) {
		
		WebDriver driver = null;
		try {
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
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
	//		driver.close();
		}

		
		
	}

}
