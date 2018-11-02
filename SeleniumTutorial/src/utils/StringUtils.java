package utils;
/**
 * Date: Oct 28, 2018
 * Author: Sangam
 * TestCase: StringUtils.java
 * Description: Reusable String Utility Functions
 */
public class StringUtils {
	
	public static String subString(String text, int beginIndex, int endIndex){
		text = text.substring(beginIndex, endIndex);
		return text;
	}

	public static boolean compare(String expectedValue, String actualValue){
		boolean flag;
		 if(expectedValue.equals(actualValue)){
			flag=true;
			System.out.println("PASS :: expectedValue :"+ expectedValue + " = "+ "actualValue :"+ actualValue );
			ReportUtils.reportResult("Pass", "Validation Successful", actualValue);
		 }
		else{
			flag=false; 
			System.out.println("FAIL :: expectedValue :"+ expectedValue + " != "+ "actualValue :"+ actualValue);
			ReportUtils.reportResult("Fail", "Validation Failed", "Exepcted value = " +expectedValue);

		}
	//	flag=expectedValue.equalsIgnoreCase(actualValue)?true:false;
  		
		
		return flag;
		
	}
	
}
