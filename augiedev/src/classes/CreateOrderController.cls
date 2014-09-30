public class CreateOrderController {

	public Account acc {get; set;}
	public Contact con {get; set;}
	public String referenceNumber {get; set;}
	public String deliveryDate {get; set;}
	public String orderNumber {get; set;}
	
	// holds the Order Line Items
	public List<Order_Line__c> oppLineItems = new List<Order_Line__c>();
	
	// Inner Class - Products
	public List<InnerProducts> innerProds {get; set;}
	public List<InnerProducts> innerProdLines;
	public String productLine {get; set;}
		
	public CreateOrderController() {
		con = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE Id IN (SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId())];
		acc = [SELECT Id, Name, BillingStreet, BillingCity, BillingPostalCode, BillingCountry FROM Account WHERE Id = :con.AccountId LIMIT 1];
		innerProds = new List<InnerProducts>();
		innerProdLines = new List<InnerProducts>(); 
        for (PriceBookEntry pbe : [SELECT Id, Name, ProductCode, Product2.Collection_Location__c, Product2.Family, UnitPrice FROM PriceBookEntry WHERE PriceBook2Id = '01sA0000000LGcm']) {
            InnerProducts ip = new InnerProducts(pbe.Product2.Id, pbe.ProductCode, pbe.Name, pbe.Product2.Collection_Location__c, pbe.Product2.Family, pbe.UnitPrice);
            innerProds.add(ip);
        }
	}
	
	public void updateInnerProdLines() {
		if (!innerProdLines.isEmpty()) {
			innerProdLines.clear();
		}		
		for (InnerProducts ip : innerProds) {
	//		if (ip.family == productLine) {
		    if (ip.family == 'FLUID ROWER') {
				innerProdLines.add(ip);
			}
		}
		System.debug('innerProdLines Size: ' + innerProdLines.size());
		//return null;
	}
	
	public List<InnerProducts> getInnerProdLines() {
		System.debug('Product Line: ' + productLine);
		return innerProdLines;
	}
	
	public List<InnerProducts> getFluidRower() {
		List<InnerProducts> fluidRower = new List<InnerProducts>();
		for (InnerProducts ip : innerProds) {
		    if (ip.family == 'FLUID ROWER') {
				fluidRower.add(ip);
			}
		}
	    return fluidRower;
	}
	
	public List<InnerProducts> getFluidRowerOrdered() {
		List<InnerProducts> fluidRower = new List<InnerProducts>();
		for (InnerProducts ip : innerProds) {
		    if (ip.family == 'FLUID ROWER' && ip.Quantity != null && ip.Quantity != '' && ip.Quantity != '0') {
				fluidRower.add(ip);
			}
		}
	    return fluidRower;
	}	
	
	public List<InnerProducts> getSignatureSPL() {
		List<InnerProducts> signatureSPL = new List<InnerProducts>();
		for (InnerProducts ip : innerProds) {
		    if (ip.family == 'Signature Series Plate Loaded') {
				signatureSPL.add(ip);
			}
		}
	    return signatureSPL;
	}

	public List<InnerProducts> getSignatureSPLOrdered() {
		List<InnerProducts> signatureSPL = new List<InnerProducts>();
		for (InnerProducts ip : innerProds) {
		    if (ip.family == 'Signature Series Plate Loaded' && ip.Quantity != null && ip.Quantity != '' && ip.Quantity != '0') {
				signatureSPL.add(ip);
			}
		}
	    return signatureSPL;
	}	
	
	/*
	public List<InnerProducts> getProdsByLine(String prodLine) {
	//public List<InnerProducts> getProdsByProdLine() {
		List<InnerProducts> ipFamily = new List<InnerProducts>();
		prodLine = 'FLUID ROWER';
		for (InnerProducts ip : innerProds) {
			if (ip.family == prodLine) {
				ipFamily.add(ip);
			}
		}
		return ipFamily;
	}	
    */
    
    // Start of Inner Class InnerProducts
    public class InnerProducts {
    	public Id productId {get; set;}
    	public String model {get; set;}
    	public String description {get; set;}
    	public String collectionLocation {get; set;}
    	public String family {get; set;}
    	/*
    	public Integer quantity {get; set;}
    		 {
    		                             if (quantity == 0) {
    		                             	quantity = null;
    		                             } else {
    		                             	quantity = value;
    		                             }
    	                              } 
        }
        */
        public String quantity {get; set;}
    	public Decimal unitPrice {get; set;}
    	public Decimal totalPrice {get; set;}
    	
    	// Constructor
    	public InnerProducts (Id productId, String model, String description, String collectionLocation, String family, Decimal unitPrice) {
    		this.productId = productId;
    		this.model = model;
    		this.description = description;
    		this.collectionLocation = collectionLocation; 
    		this.unitPrice = unitPrice;
    		this.family = family;
    		this.quantity = '';
    		this.totalPrice = 0;
    	}  	
    	
    	public PageReference updateTotalPrice() {
    		if (quantity != null && quantity != '0') {
    			totalPrice = unitPrice * Integer.valueOf(quantity);
    		}
    		else {
    			quantity = '';
    			totalPrice = 0.0;
    		}
    		return null;
    	}    	
    	
    }
    // End of Inner Class Order InnerProducts    
    
    // Page References for the Wizard navigation
    public PageReference createOrder1() {   	
   	   return Page.Create_Order1;
    }
   
    public PageReference createOrder2() {   	
       return Page.Create_Order2;
    }
    
    public PageReference createOrder3() {   	
       return Page.Create_Order3;
    }    
    
    public PageReference createOrder4() {  
       Order__c o = new Order__c();
       o.Account__c = acc.Id;
       o.Contact__c = con.Id;
       o.Reference_Number__c = referenceNumber;
       Integer year = Integer.valueOf(deliveryDate.subString(6, 10));
       Integer month = Integer.valueOf(deliveryDate.subString(3, 5));
       Integer day = Integer.valueOf(deliveryDate.subString(0, 2));
       o.Delivery_Date__c = date.newInstance(year, month, day);
       insert(o);
       List<Order_Line__c> ols = new List<Order_Line__c>();
       for (InnerProducts ip : innerProds) {
       	  if (ip.Quantity != null && ip.Quantity != '' && ip.Quantity != '0') {
       	     Order_Line__c ol = new Order_Line__c();
       	     ol.Order__c = o.Id;
       	     ol.Product__c = ip.productId;
       	     ol.Quantity__c = Decimal.valueOf(ip.Quantity);
       	     ol.Total_Price__c = ip.TotalPrice;
       	     ols.add(ol);
       	  }
       }
       if (!ols.isEmpty()) {
       	  insert(ols);
       }
       return Page.Create_Order4;
    }     
}