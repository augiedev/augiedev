public with sharing class AccountExtension1 {
	
	public List<InnerProduct> innerProds {get; set;}

    public AccountExtension1() {
        innerProds = new List<InnerProduct>();
        for (PriceBookEntry pbe : [SELECT Id, Name, ProductCode, UnitPrice FROM PriceBookEntry WHERE PriceBook2Id = '01sA0000000LGcm']) {
        	InnerProduct ip = new InnerProduct(pbe.Name, pbe.ProductCode, pbe.UnitPrice);
        	innerProds.add(ip);
        }               
    }
    
    public String getStringCtr() {
        String text = 'Testing Controller 9:47pm';
    	return text;
    }
    
    public class InnerProduct {
    	
    	public String prodName {get; set;}
    	public String prodCode {get; set;}
    	public Decimal unitPrice {get; set;}
    	
    	public InnerProduct(String prodName, String prodCode, Decimal unitPrice) {
    		this.prodName = prodName;
    		this.prodCode = prodCode;
    		this.unitPrice = unitPrice;
    	}
    }
}