package utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.joda.time.DateTime;
import org.joda.time.DateTimeZone;
import org.joda.time.Hours;
import org.joda.time.LocalDate;
import org.joda.time.LocalDateTime;
import org.joda.time.Minutes;
import org.joda.time.Seconds;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;



/**
 * DateUtils - Date and Time related utility functions
 * @author sangam
 *
 */
public class DateUtils {


	public static String getCurrentDate(String desiredDateFormat){
		String dateString = null;
		try {
			LocalDate date = LocalDate.now();
			DateTimeFormatter format = DateTimeFormat.forPattern(desiredDateFormat);
			dateString = format.print(date);
			System.out.println("Current Date = "+ dateString);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dateString;


	}

	
	 // desiredDateTimeFormat - Returns current timestamp
 	
	public static String getCurrentTimestamp(String desiredDateTimeFormat){
		String timeStamp = null;
		try {
			timeStamp = new SimpleDateFormat(desiredDateTimeFormat,Locale.US).format(new Date());
			//System.out.println("Current Timestamp = "+ timeStamp);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return timeStamp;
	}
	
	/**
	 * param getDateTimeDifference - Takes 3 arguments (StartTime, EndTime, DateTimeFormat) Returns the difference between two timestamps in format: 8 Min. 15 Sec.
	 * @param startDateTime
	 * @param endDateTime
	 * @param format_DateTime
	 * @return
	 * @throws ParseException
	 */
	
	public static String getDateTimeDifference(String startDateTime, String endDateTime, String format_DateTime) throws ParseException{

		SimpleDateFormat format = new SimpleDateFormat(format_DateTime);

		Date d1 = null;
		Date d2 = null;

		int min = 0;
		int sec = 0;


		d1 =format.parse(startDateTime);
		d2 =format.parse(endDateTime);


		DateTime  dt1 = new DateTime(d1);
		DateTime  dt2 = new DateTime(d2);

		min= Minutes.minutesBetween(dt1, dt2).getMinutes()%60;
		sec =Seconds.secondsBetween(dt1, dt2).getSeconds()%60;
		//	int hours = Hours.hoursBetween(dt1, dt2).getHours()%24;
		System.out.println("~ The difference between "+startDateTime +" & "+ endDateTime +" = "+ min+" Min."+" "+sec+ "Sec." );
		return min+" Min."+" "+sec+ "Sec.";

	}	

	public static String datetime_PlusHours(int n, String pattern_MMdyyyHHmmss){

		LocalDateTime today = LocalDateTime.now(DateTimeZone.forID("America/Montreal"));
		LocalDateTime resultDateTime = today.plusHours(n);

		DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern_MMdyyyHHmmss);
		String str = fmt.print(resultDateTime);

		System.out.println("datetime_PlusHours :"+str);

		return str;

	}

	public static String datetime_MinusDays(int n, String pattern_MMdyyyHHmmss){

		LocalDateTime today = LocalDateTime.now(DateTimeZone.forID("America/Montreal"));
		LocalDateTime resultDateTime = today.minusDays(n);

		DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern_MMdyyyHHmmss);
		String str = fmt.print(resultDateTime);

		System.out.println("datetime_MinusDays :"+str);

		return str;

	}
	
	
	
	public static String datetime_PlusYears(int n, String pattern_MMdyyyHHmmss){

		LocalDateTime today = LocalDateTime.now(DateTimeZone.forID("America/Montreal"));
		LocalDateTime resultDateTime = today.plusYears(n);

		DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern_MMdyyyHHmmss);
		String str = fmt.print(resultDateTime);

		System.out.println("datetime_PlusYears :"+str);

		return str;

	}
	
	/**
	 * datetime_PlusOrMinus_YearsMonthsWeeksDaysHoursMinutsSeconds - Add or Subtract YearsMonthsWeeksDaysHoursMinutsSecond
	 *  Pass Positive integer for adding the values
	 *  Pass Negative integer for subtracting the values
	 * @param years
	 * @param months
	 * @param weeks
	 * @param days
	 * @param hours
	 * @param minutes
	 * @param seconds
	 * @param DateTimeFormat
	 */
	public static String datetime_PlusOrMinus_YearsMonthsWeeksDaysHoursMinutsSeconds(int years, int months, int weeks, int days , int hours, int minutes, int seconds, String DateTimePattern )
	{
		String str = "";
		try {
			LocalDateTime today = LocalDateTime.now(DateTimeZone.forID("America/Montreal"));
			
			LocalDateTime resultDateTime = today.plusYears(years).plusMonths(months).plusWeeks(weeks).plusDays(days).plusHours(hours).plusMinutes(minutes).plusSeconds(seconds);
			
			DateTimeFormatter fmt = DateTimeFormat.forPattern(DateTimePattern);
			str = fmt.print(resultDateTime);

			System.out.println("datetime_PlusOrMinus_YearsMonthsWeeksDaysHoursMinutsSeconds :\n"
			+ years + "years"+"+"
			+ months + "months"+"+"
			+ weeks + "weeks"+"+"
			+ days + "days"+"+"
			+ hours + "hours"+"+"
			+ minutes + "minutes"+"+"
			+ seconds + "seconds"
					+" = "+str);

		 	
		} catch (Exception e) {
 			e.printStackTrace();
		}
		
		finally{
 		System.out.println("Entered finally block!");
		}
		return str;
	}

	public static void main(String args[]){

		try {
//			datetime_PlusHours(2, "MM/d/yyyy HH.mm.ss");
//			datetime_MinusDays(5, "MM/d/yyy HH.mm.ss");
//			datetime_PlusYears(-2, "MM-d-YYYY HH:mm:ss");
//			datetime_PlusOrMinus_YearsMonthsWeeksDaysHoursMinutsSeconds(1, 2, 3, 4, 2, 15, 10, "MM-dd-yyyy HH:mm:ss");
//			datetime_PlusOrMinus_YearsMonthsWeeksDaysHoursMinutsSeconds(-5, 2, 3, 4, 2, 15, 10, "MM-dd-yyyy HH:mm:ss");
//			getCurrentDate("MM/dd/yyyy");
 			getCurrentTimestamp("MM/dd/yyyy HH:mm:ss");
		//	getDateTimeDifference(datetime_PlusHours(0, "MM/d/yyyy HH.mm.ss"), datetime_PlusHours(2, "MM/d/yyyy HH.mm.ss"), "MM/dd/yyyy HH:mm:ss");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
