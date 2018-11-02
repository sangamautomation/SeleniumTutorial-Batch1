package utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFFormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/**
 * Excel Utility Functions - Read from XLS, XLSX
 */
public class ExcelUtils {

	public static HashMap<String,String> getTestDataXls(String filePath, String sheetName, int headerRowNum, int tcRowNum) throws Exception
	{
	
 
		HashMap<String,String> rowData = new HashMap<>();
		
		HSSFSheet sheet = null;
		HSSFWorkbook workbook = null;
		HSSFRow  headerRow,tcRow;
		
		FileInputStream file = null;
		
 		try {
			file = new FileInputStream(new File(filePath));//D:\Selenium_Logs\TestData\Datapool.xls 
		workbook = new HSSFWorkbook(file);
	 	
		} catch (Exception e) {
 			e.printStackTrace();
		} 
		
		
		sheet = workbook.getSheet(sheetName);
		headerRow = sheet.getRow(headerRowNum);
		tcRow = sheet.getRow(tcRowNum);
		
		Iterator<org.apache.poi.ss.usermodel.Cell> cellIterator = headerRow.cellIterator();
		
		int i = 0;
		while(cellIterator.hasNext()){
			
			org.apache.poi.ss.usermodel.Cell cell = cellIterator.next();
			
			rowData.put(cellValueStr(workbook,headerRow,i), cellValueStr(workbook,tcRow,i));
			
		i++;
			
		}
				
		workbook.close();
		file.close();
 	
		return rowData;
 	
	
}
	
	
/*	public static HashMap<String,String> getTestDataXlsx(String filePath, String sheetName, int headerRowNum, String tcName) throws Exception
	{
 	 	
		HashMap<String,String> rowData = new HashMap<>();
		
		XSSFSheet sheet = null;
		XSSFWorkbook workbook = null;
		XSSFRow  headerRow,tcRow;
		
		FileInputStream file = null;
		
 		try {
			file = new FileInputStream(new File(filePath));//D:\Selenium_Logs\TestData\Datapool.xls 
		workbook = new XSSFWorkbook(file);
	 	
		} catch (Exception e) {
 			e.printStackTrace();
		} 
		
		
		sheet = workbook.getSheet(sheetName);
		headerRow = sheet.getRow(headerRowNum);
		tcRow = sheet.getRow(findRow(sheet,tcName));
		
		Iterator<org.apache.poi.ss.usermodel.Cell> cellIterator = headerRow.cellIterator();
		
		int i = 0;
		while(cellIterator.hasNext()){
			
			org.apache.poi.ss.usermodel.Cell cell = cellIterator.next();
			
			rowData.put(cellValueStrX(workbook,headerRow,i), cellValueStrX(workbook,tcRow,i));
			
		i++;
			
		}
				
		workbook.close();
		file.close();
		
		
		return rowData;
		
		
	
}*/
	
	public static String cellValueStr (HSSFWorkbook workbook, HSSFRow row, int cellNum){
		DataFormatter format = new DataFormatter();
		FormulaEvaluator eval = new HSSFFormulaEvaluator(workbook);
		
		HSSFCell cellValue = row.getCell(cellNum);
		
		eval.evaluate(cellValue);
		
		String cellValueStr = format.formatCellValue(cellValue,eval);
		
		
		return cellValueStr;
	 	
		
	}
	
	public static String cellValueStrX (XSSFWorkbook workbook, XSSFRow row, int cellNum){
		DataFormatter format = new DataFormatter();
		FormulaEvaluator eval = new XSSFFormulaEvaluator((XSSFWorkbook) workbook);
		
		XSSFCell cellValue = row.getCell(cellNum);
		
		eval.evaluate(cellValue);
		
		String cellValueStr = format.formatCellValue(cellValue,eval);
		
		
		return cellValueStr;
	 	
		
	}
	
	
/*	@SuppressWarnings("deprecation")
	public static int findRow(XSSFSheet sheet, String cellContent){
		for(org.apache.poi.ss.usermodel.Row row: sheet){
			for(org.apache.poi.ss.usermodel.Cell cell: row){
				if(cell.getCellType() == org.apache.poi.ss.usermodel.Cell.CELL_TYPE_STRING){
					if(cell.getRichStringCellValue().getString().trim().equals(cellContent)){
						return row.getRowNum();

					}
				}
			}
 
			
		}
		return 0;
	}*/
	
}
