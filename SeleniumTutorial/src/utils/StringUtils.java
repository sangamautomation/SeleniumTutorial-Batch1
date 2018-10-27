package utils;

public class StringUtils {
	
	public static String subString(String text, int beginIndex, int endIndex){
		text = text.substring(beginIndex, endIndex);
		return text;
	}

}
