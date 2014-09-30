public class GoogleMapsExtensions {
	
	public Account headAccount {get; set;}
	public List<Account> zoneAccs {get; set;}
	
	public GoogleMapsExtensions() {
		headAccount = [SELECT Id, OwnerId, Name, Zone__c, BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry FROM Account WHERE Id = :Apexpages.currentPage().getParameters().get('id')];
		zoneAccs = [SELECT Id, Name, Zone__c, BillingStreet, BillingCity, BillingPostalCode, BillingState, BillingCountry FROM Account WHERE Zone__c = :headAccount.Zone__c AND OwnerId = :headAccount.OwnerId AND Id != :headAccount.Id];
		headAccount.BillingStreet = headAccount.BillingStreet.replace('\r\n', ', ');
		for (Account a : zoneAccs) {
			a.BillingStreet = a.BillingStreet.replace('\r\n', ', ');
		}
	}
}