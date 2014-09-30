public class tstpopup {     

    // This is a test statement
    // This is another comment
    public boolean displayPopup {get; set;}  
    public string firstName { get; set; }
    public string lastName { get; set; }
    
    public void closePopup() {        
        displayPopup = false;    
    }     
    
    public void showPopup() {        
        displayPopup = true;    
    }
    
    @RemoteAction
    public static String createContact(string FirstName, string LastName) {
       Contact c = new Contact(FirstName=FirstName,LastName=LastName);
       insert c;
       return c.Id;       
    }  
}