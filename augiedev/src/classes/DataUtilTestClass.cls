@isTest 
private class DataUtilTestClass {

	static testmethod void testLoadData() {

		// Load the test accounts from the static resource
		List<sObject> accountsList = Test.loadData(Account.sObjectType, 'AccountsTest');
		List<sObject> contactsList = Test.loadData(Contact.sObjectType, 'ContactsTest');
		List<Contact> contactsToUpdate = new List<Contact>();
		// Verify that all 3 test accounts were created
		System.assert(accountsList.size() == 3);

		// Get first test account
		Account a1 = (Account) accountsList[0];
		String acctName = a1.Name;
		System.debug(acctName);

		for (Integer i = 0; i < contactsList.size(); i++) {
			Contact currentContact = (Contact) contactsList[i];
			currentContact.AccountId = (Id) accountsList[i].Id;
			contactsToUpdate.add(currentContact);
		}
		update(contactsToUpdate);

		// Perform some testing using the test records
		for (Account acc : [SELECT Id, Zone__c FROM Account WHERE Id IN :accountsList]) {
			System.debug('\R\N\R\N\R\N\RZONE EQUALS:' + acc.Zone__c + '\R\N\R\N\R\N\R');
			System.assertEquals('1', acc.Zone__c);
		}

		// Check that the Contact is listed to the right Account
		Integer i = 0;
		for (Contact con : [SELECT Id, AccountId FROM Contact WHERE Id IN :contactsToUpdate]) {
			System.debug('\R\N\R\N\R\N\R CONTACT ACCOUNT ID:' + con.AccountId + '\R\N\R\N\R\N\R');
			System.assertEquals(accountsList[i].Id, con.AccountId);
			i++;
		}
	}
}