package setup;

import java.util.concurrent.TimeUnit;

import org.openqa.selenium.WebDriver;

public class TestRunSetup {
	
	public static void prerequisites(WebDriver driver, String URL){
		
		driver.get(URL);
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
	}

}
