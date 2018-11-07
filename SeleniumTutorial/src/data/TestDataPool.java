package data;

import java.util.HashMap;

import utils.ExcelUtils;

public class TestDataPool {
	
	public  static HashMap<String,String> rowData = new HashMap<String,String>();

	public TestDataPool(){
	 		
			try {
				rowData = ExcelUtils.getTestDataXls(Constants.dataPool_Xls, "Automation", 1, 2)	;
			} catch (Exception e) {
 				e.printStackTrace();
			}

	 
	}
	
	public TestDataPool(int tcNum){
 		
		try {
			rowData = ExcelUtils.getTestDataXls(Constants.dataPool_Xls, "Automation", 2, tcNum)	;
		} catch (Exception e) {
				e.printStackTrace();
		}

 
}
	
	public TestDataPool(String tcName){/*
 		
		try {
			rowData = ExcelUtils.getTestDataXlsx(Constants.dataPool_Xlsx, "Automation", 2, tcName)	;
		} catch (Exception e) {
				e.printStackTrace();
		}

 
*/}
}
