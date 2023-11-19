trigger CurrencyExchangeTrigger on Currency_Exchange__c (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            CurrencyExchangeTriggerHandler.handleCreatedRecords(Trigger.newMap);
        }else if(Trigger.isUpdate){
            CurrencyExchangeTriggerHandler.handleUpdatedRecords(Trigger.newMap, Trigger.oldMap);
        }
    }
}