public with sharing class CurrencyExchangeTriggerHandler {
    public static void handleCreatedRecords(Map<Id, Currency_Exchange__c> newRecords) {
        Set<Id> recordIds = new Set<Id>();
        for (Currency_Exchange__c record : newRecords.values()){
            recordIds.add(record.Id);
        }
        
        if(!recordIds.isEmpty() && !System.isFuture()){
            ExchangeRateController2.doGetExchange(recordIds);
            System.debug('recordIds '+recordIds);
        }
    }
    
     public static void handleUpdatedRecords(Map<Id, Currency_Exchange__c> newRecords, Map<Id, Currency_Exchange__c> oldRecordsMap) {
        Set<Id> recordIds = new Set<Id>();
        for (Currency_Exchange__c record : newRecords.values()){
            
            Currency_Exchange__c oldCurExchRec = oldRecordsMap.get(record.id);
            if( record.currency__c != oldCurExchRec.currency__c || record.baseCurrency__c != oldCurExchRec.baseCurrency__c){
                 recordIds.add(record.Id);
            }
           
        }
          
        if(!recordIds.isEmpty() && !System.isFuture()){
            ExchangeRateController2.doGetExchange(recordIds);
            System.debug('recordIds '+recordIds);
        }
    }
    
}