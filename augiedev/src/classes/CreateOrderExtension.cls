public class CreateOrderExtension {
	
	public Account acc {get; set;}
	public Contact con {get; set;}
	public String referenceNumber {get; set;}
	public String deliveryDate {get; set;} 
	
	// holds the Order Line Items
	public List<Order_Line__c> oppLineItems = new List<Order_Line__c>();
	
	// Inner Class - Order Lines
	public List<InnerOrderLines> olInnerList {get; set;}
	public Integer count = 1;
		
	public CreateOrderExtension () {
		User u = [SELECT Id, ContactId FROM User WHERE Id = :UserInfo.getUserId()];
		con = [SELECT Id, FirstName, LastName, AccountId FROM Contact WHERE Id = :u.ContactId];
		acc = [SELECT Id, Name, BillingStreet, BillingCity, BillingPostalCode, BillingCountry FROM Account WHERE Id = :con.AccountId LIMIT 1];
        olInnerList = new List<InnerOrderLines>();
        addNewOrderLine();
	}

    public void add() {
    	count++;
    	addNewOrderLine();
    }
    
    public void addNewOrderLine() {
    	// call to the Inner Class Order Lines constructor
    	//InnerOrderLines objIOL = new InnerOrderLines(count);
    	//olInnerList.add(objIOL);    	
    	
    	// create a new record and add the record to the Inner Class Order Lines List
    	olInnerList.add(new InnerOrderLines(count));
    	
    	for (InnerOrderLines c : olInnerList) {
    	   System.debug('c Model: ' + c.model);
    	   System.debug('c Quantity: ' + c.quantity);
    	}
    	
    }
    
    // Start of Inner Class Order Lines
    public class InnerOrderLines {
    	
    	public String recCount {get; set;}
    	public String model {get; set;}
    	public String description {get; set;}
    	public Integer quantity {get; set;}
    	public Decimal totalPrice {get; set;}
    	
    	// Constructor
    	public InnerOrderLines (Integer intCount) {
    		recCount = String.valueOf(intCount);
    	}
    }
    // End of Inner Class Order Lines
}