public with sharing class LeadConvertPageController {

    Lead leadToConvert;
    
    public LeadConvertPageController(ApexPages.StandardController stdController) {
        leadToConvert = [SELECT Id, Country FROM Lead WHERE Id = :stdController.getRecord().Id];
    }
    
    public boolean getPrepareLeadToBeConverted() {
        return false;
    }
}