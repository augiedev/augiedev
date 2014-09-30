public class ViewProjectController {

   public Project__c project {get; set;}
   
   public ViewProjectController() {
   	  project = [Select Id, Name, Title__c, Account__r.Name, Account__r.BillingCity, Budget__c, Category__c, Start_Date__c, End_Date__c, Status__c, Description__c, (Select Id, Name, Description__c, Requirements__c, Benefits__c, Start_Date__c, End_Date__c, Hourly_Rate__c, Experience__c, Job_Title__c From Positions__r) From Project__c p WHERE Id = :ApexPages.currentPage().getParameters().get('id') LIMIT 1];
   }

   public Position__c getPosition() {   	
   	  Id id = System.currentPageReference().getParameters().get('posId');
   	  for (Position__c pos : project.Positions__r) {
   	  	 if (pos.Id == id) {
   	  	 	return pos;
   	  	 }
   	  }
   	  return null;
   }
   
   public List<Position__c> getPositions() {
   	  return project.Positions__r;
   }   

}