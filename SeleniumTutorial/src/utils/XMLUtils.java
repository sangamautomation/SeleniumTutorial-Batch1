package utils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import data.Constants;

/**
 * XMLUtils - Reading Request Payload, Posting XML Payload, Fetching Response Payload
 */
public class XMLUtils {
	
	
	private static HashMap<String,String> xmlData = new HashMap()	;
	
	public  HashMap<String,String>  getHashMapFromXML(String filePath){
		
		
		BufferedReader br = null;
		
		
		try {
			
		String lineContent;
		
		br = new BufferedReader(new FileReader(filePath)); //D:\\Selenium_Logs\\WebServices\\requests\\SampleWebService.xml
			
			//Gets all XML elements into HashMap
			getElementsIntoHashMap(new InputSource(br));
 			// Print all XML Key+Value pairs to Console & Property file
			printHashMap();
		} catch (Exception e) {
			e.printStackTrace();
 		}
		
		finally{
			try{
				if(br != null)
					br.close();
			}
			catch(IOException ex){
				ex.printStackTrace();
			}
		}
		
		
		return xmlData;
		
		
	}
	
	
	
	/**
	 * 
	 * getElementsIntoHashMap - Read the xml File and add all the elements into xmlData  HashMap 
	 * @param xmlFile
	 * @return
	 * @throws ParserConfigurationException 
	 * @throws IOException 
	 * @throws SAXException 
	 */
	public HashMap<String,String> getElementsIntoHashMap (InputSource xmlFile	) throws Exception{
		
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		org.w3c.dom.Document doc = dBuilder.parse(xmlFile);
		doc.getDocumentElement().normalize();
		try {
			
			if(doc.hasChildNodes())
				printNote(doc.getChildNodes());
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
 		}
		
		return xmlData;
		
		
	}
	
	
	private static void printNote(NodeList nodeList){
		
		for (int count = 0; count < nodeList.getLength(); count++) {
			
			Node tempNode = nodeList.item(count);
			
					if(tempNode.getNodeType() == Node.ELEMENT_NODE){
						
						String strKey = tempNode.getNodeName().substring(tempNode.getNodeName().lastIndexOf(":")+1);
						
						xmlData.put(strKey, tempNode.getTextContent()); // Write all Key, Value pairs to HashMap
						
						if(tempNode.hasChildNodes())
							printNote(tempNode.getChildNodes());
						
					}
					
		}
	}
	
	
	private void printHashMap(){
		System.out.println("printHashMap......");
		for (Map.Entry<String,String> entry : xmlData.entrySet()) {
			
			System.out.println(entry.getKey() + " : "+ entry.getValue());
			PropertyUtils.propertyFile_Write(Constants.path_PropertyFile_webservices, entry.getKey(), entry.getValue());
			
		}
	}
	
	
	
	

}
