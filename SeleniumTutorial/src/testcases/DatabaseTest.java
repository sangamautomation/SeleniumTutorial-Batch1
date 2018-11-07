/*package testcases;

import javax.swing.JOptionPane;

import data.Constants;
import data.DatabaseStrings;
import infrastructure.Configuration;
import infrastructure.DatabaseInteractions;
import utils.DatabaseUtils;
import utils.PasswordUtils;
import utils.PropertyUtils;

public class DatabaseTest {

	public static void main(String[] args) throws Exception {
		
		
 		DatabaseStrings ds = new DatabaseStrings();
		String User = new Configuration().getProperty("username");
		String pwd = PasswordUtils.decryptString(new Configuration().getProperty("password"));	
		int k = 1;

		//=================== Single Select =============================
		
 	 	String sqls1 = "select CASEID from curam1.caseheader where casereference ="	; // single select
  	 
	 	String inputs1 ="11062" ; //select
 		String sqls2 = ""	;
		String inputs2 = "";
	 	String sql_Suffix = " ORDER BY LastWritten DESC FETCH FIRST 1 ROW ONLY"; //select
 
		String resultcolname = "CASEID";
		//Single SQL Select
	 	String statusCode_Select_Actual =DatabaseUtils.databaseValidation_SelectSQL(ds.host_curam[k] , ds.db_curam[k] , ds.port_curam[k], sqls1, inputs1, sqls2, inputs2, sql_Suffix, resultcolname);
	 	String statusCode_Select_Expected ="2214524170480386048";
		
	//	DatabaseUtils.Database_Compare(statusCode_Select_Expected, statusCode_Select_Actual, "The select query executed!");

 		
		//=========================== Multiple Select ============================
		
 
 		 String sqls1a = "select * from curam1.caseheader where casereference ="	; //multi select
 
  
	 	String inputs1a ="11062" ; //select
 		String sqls2a = ""	;
		String inputs2a = "";
	 	String sql_Suffixa = " ORDER BY LastWritten DESC FETCH FIRST 1 ROW ONLY"; //select
  
		//Multiple SQL Select
 	 	String[] statusCode_Select_Actuala =DatabaseUtils.databaseValidation_Select(ds.host_curam[k] , ds.db_curam[k] , ds.port_curam[k], sqls1a, inputs1a, sqls2a, inputs2a, sql_Suffixa);
 	 
  		
	//	DatabaseUtils.Database_Compare(statusCode_Select_Expected, statusCode_Select_Actual, "The select query executed!");

	
		
	//============================ UPDATE SQL =========================
		
 
 		
		String sql_Update = "Update CURAM1.EEFVLPRESPONSE set FIRSTNAME ="	; // Update CURAM1.EEFVLPRESPONSE set FIRSTNAME = 'xyza' where responsecode='EEFVLP004
		String setValue = "xyzab";

		String sqls1b = "where responsecode=";
  
 		String inputs1b ="EEFVLP004" ; //update
 		String sqls2b = ""	;
		String inputs2b = "";
 		String sql_Suffixb = ""; //update
 	
		//Update SQL String ip, String dbname, String port, String sql_Update, String setValue, String sql1, String input1, String sql2, String input2
		int statusCode_Update_Actual =DatabaseUtils.databaseValidation_UpdateSQL(ds.host_curam[k] , ds.db_curam[k] , ds.port_curam[k], sql_Update, setValue, sqls1, inputs1, "","");

		System.out.println("status code = " +statusCode_Update_Actual);
 		
	//	DatabaseUtils.Database_Compare(statusCode_Select_Expected, statusCode_Select_Actual, "The select query executed!");

	}
}
*/