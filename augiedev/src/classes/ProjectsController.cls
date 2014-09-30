public class ProjectsController {

   public List<Project__c> openProjects {get; set;}
   public Project__c project {get; set;}
   public Id posId {get; set;}
   public boolean showPositionPanel {get; set;}
   
   public ProjectsController() {
   	  if (ApexPages.currentPage().getParameters().get('id') != null) {
   	  	 project = [Select Id, Name, Title__c, Account__r.Name, Account__r.BillingCity, Budget__c, Category__c, Start_Date__c, End_Date__c, Status__c, Description__c, (Select Id, Name, Description__c, Requirements__c, Benefits__c, Start_Date__c, End_Date__c, Hourly_Rate__c, Experience__c, Job_Title__c From Positions__r) From Project__c p WHERE Id = :ApexPages.currentPage().getParameters().get('id') LIMIT 1];
   	  }
   	  else {
   	     openProjects = [SELECT Id, Name, Title__c, Account__r.Name, Budget__c, Category__c, Start_Date__c, End_Date__c, Status__c FROM Project__c WHERE Status__c != 'Completed' AND Status__c != 'Cancelled' AND Status__c != 'In Progress'];
   	  }
   	  showPositionPanel = false;
   }
   
   public ProjectsController(ApexPages.StandardController stdController) {
      openProjects = [SELECT Id, Name, Title__c, Account__r.Name, Budget__c, Category__c, Start_Date__c, End_Date__c, Status__c FROM Project__c WHERE Status__c != 'Completed' AND Status__c != 'Cancelled' AND Status__c != 'In Progress'];
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
   /*
   public Position__c getPosition(Integer pos) {
      return project.Positions__r.get(pos);
   }
   */
   
   public void updatePositionPanel() {
      if (showPositionPanel) {
         showPositionPanel = false;
      }
      else {
      	 showPositionPanel = true;
      }
   }
   
   public List<Position__c> getPositions() {
   	  return project.Positions__r;
   }
   
   public PageReference positionApply() {
   	  PageReference pageRef = new PageReference('/PositionApply?posId=' + posId);
   	  pageRef.setRedirect(true);
   	  return pageRef;
   }
}