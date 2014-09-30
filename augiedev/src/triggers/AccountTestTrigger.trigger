trigger AccountTestTrigger on Account (before insert, before update) {

    for (Account acc : Trigger.new) {
        acc.Zone__c = '1';
    }

}