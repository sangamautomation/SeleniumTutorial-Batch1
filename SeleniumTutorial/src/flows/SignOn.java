package flows;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import pageObjects.Signin;

public class SignOn {
	
	public void signin(WebDriver driver){
		driver.findElement(By.xpath(Signin.link_Signin)).click();
		driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
		driver.findElement(By.xpath(Signin.textBox_UserName)).sendKeys("Username2");
		driver.findElement(By.xpath(Signin.textBox_Password)).sendKeys("Password123");
		driver.findElement(By.xpath(Signin.button_Signin)).click();


	}

}
