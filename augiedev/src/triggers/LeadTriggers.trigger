trigger LeadTriggers on Lead (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
     
     // Before Execution Triggers
     if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            LeadMethods.setTitle(Trigger.new);
            LeadMethods.setCityBefore(Trigger.new);
        }
        else if (Trigger.isUpdate) {
            
        }
        else if (Trigger.isDelete) {
            
        }
        else if (Trigger.isUnDelete) {
            
        }
     }
     // After Execution Triggers
     else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            if (HandlerClass.firstRun) {
                LeadMethods.setCountry(Trigger.new, 'INSERT');
                HandlerClass.setFirstRun();
            }
            else {
                System.debug('\r\n\r\n\r\n\r\n\r\n ALREADY RAN! \r\n\r\n\r\n\r\n\r\n');
            }
        }
        else if (Trigger.isUpdate) {
            if (HandlerClass.firstRun) {
                HandlerClass.setFirstRun();
                LeadMethods.setCity(Trigger.new);
                LeadMethods.setCountry(Trigger.new, 'UPDATE');
            }
            else {
                System.debug('\r\n\r\n\r\n\r\n\r\n ALREADY RAN! \r\n\r\n\r\n\r\n\r\n');
            }
        }
        else if (Trigger.isDelete) {
            
        }
        else if (Trigger.isUnDelete) {
            
        }
     }
}