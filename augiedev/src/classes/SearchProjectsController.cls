public class SearchProjectsController {
	
	public List<Project__c> projects {get; set;}
	public String keyword {get; set;}
	public String budget {get; set;}
	public String category {get; set;}
	public String status {get; set;}
	public String industry {get; set;}
	public List<SelectOption> budgetOptions {get; set;}
	public List<SelectOption> categoryOptions {get; set;}
	public List<SelectOption> statusOptions {get; set;}
	public List<SelectOption> industryOptions {get; set;}
	
	public SearchProjectsController() {
		budgetOptions = getPicklistValues('Project__c', 'Budget__c');
		categoryOptions = getPicklistValues('Project__c', 'Category__c');
		statusOptions = getPicklistValues('Project__c', 'Status__c');
		industryOptions = getPicklistValues('Account', 'industry');
	}
	
	public List<SelectOption> getPicklistValues (String objectName, String fieldName) {
		List<selectOption> options = new List<selectOption>();

		Schema.SObjectType sobject_type  = Schema.getGlobalDescribe().get(objectName); //grab the sobject that was passed
		Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject

		Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
		List<Schema.PicklistEntry> pick_list_values = field_map.get(fieldName).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
		options.add(new selectOption('--', '--'));
		for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
			options.add(new selectOption(a.getLabel(), a.getValue())); //add the value and label to our final list
		}
		return options;
	}
	
	public Integer getProjectSize() {
		if (projects == null) {
			return 0;
		}
		else {
			return projects.size();
		}
	}
	
	public PageReference searchProjects() {
		/*
		String sqlQuery = 'SELECT Id, Name, Title__c, Account__r.Name, Budget__c, Category__c, Start_Date__c, End_Date__c, Status__c FROM Project__c';
		String sqlWhere = 'WHERE';

		if (!budget.equals('--')) {
			sqlWhere += ' budget__c = \'' + budget +'\' AND';
		}
		if (!category.equals('--')) {
			sqlWhere += ' category__c = \'' + category +'\' AND';
		}
		if (!status.equals('--')) {
			sqlWhere += ' Status__c = \'' + status +'\' AND';
		}
		if(!sqlWhere.equals('WHERE')) {
			sqlQuery += ' ' + sqlWhere.substring(0, sqlWhere.length()-4);
		}

		try {
      		projects = Database.query(sqlQuery);
    	} catch (Exception e) {
      		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid SQL Query!'));
    	}		
		return null;
		*/
		try {
			//keyword = keyword + '*';
			System.debug('Budget equals: ' + budget);
			//keyword = '\'' + budget + '\' OR \'' + status + '\'';
			keyword = '\'' + budget + '\'';
			System.debug('in try statement. Keyword: ' + keyword);
      		List<List<SObject>> searchList = [FIND :keyword IN ALL FIELDS RETURNING Project__c (Id, Name, Title__c, Account__r.Name, Budget__c, Category__c, Start_Date__c, End_Date__c, Status__c)];
      		projects = ((List<Project__c>)searchList[0]);
      		System.debug('\r\n\r\n\r\n\rLIST RETURNED: ' + projects.size());
      		System.debug('\r\n\r\n\r\n\rSEARCHLIST RETURNED: ' + searchList.size());
      		Integer i = 0;
      		for (List<Sobject> so : searchList) {
      			System.debug('SObject: ' + so);
      			for (Sobject s : so) {
      				System.debug('S' + i + ': ' + s);
      				i++;
      			}
      		}
      			
    	} catch (Exception e) {
      		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid SQL Query!'));
    	}	
    	return null;
	}
}