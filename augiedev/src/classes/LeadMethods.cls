public with sharing class LeadMethods {

	public static void setTitle(List<Lead> leadsToUpdate) {
		Integer i = 0;
		for (Lead currentLead : leadsToUpdate) {
			currentLead.Title = 'Updated from BEFORE Trigger' + i;
			i++;
		}
	}

	public static void setCityBefore(List<Lead> leadsToUpdate) {
		Integer i = 0;
		for (Lead currentLead : leadsToUpdate) {
			currentLead.City = 'Set from BEFORE INSERT Trigger' + i;
			i++;
		}
	}	

	public static void setCity(List<Lead> leadsToUpdate) {
		Integer i = 0;
		List<Lead> updatedLeads = new List<Lead>();
		for (Lead currentLead : [SELECT Id, City FROM Lead WHERE Id IN :leadsToUpdate]) {
			currentLead.City = 'Set from AFTER UPDATE Trigger' + i;
			i++;
			updatedLeads.add(currentLead);
		}
		update(updatedLeads);
	}

	public static void setCountry(List<Lead> leadsToUpdate, String executionType) {
		Integer i = 0;
		List<Lead> updatedLeads = new List<Lead>();
		User u = [SELECT Id FROM User WHERE LastName != 'Schembri' AND isActive = TRUE LIMIT 1];

		for (Lead currentLead : [SELECT Id, Country FROM Lead WHERE Id IN :leadsToUpdate]) {
			currentLead.Country = 'Set from AFTER ' +  executionType + ' Trigger' + i;
			i++;
			updatedLeads.add(currentLead);
		}
		update(updatedLeads);
	}
}