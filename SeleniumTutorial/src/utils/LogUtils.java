package utils;

/**
 * To print logs on to the console
 * @author sangam
 *
 */
public class LogUtils {
	
	public static void log(String message){
		System.out.println(DateUtils.getCurrentTimestamp("MM/dd/yyyy HH:mm:ss")+ " | "  + message);
	}

}
