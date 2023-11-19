@isTest
public class CurrencyExchangeTriggerHandlerTest {
    @TestSetup static void insertingTestData() {
	  Currency_Exchange__c curExch = new Currency_Exchange__c (
            
            Currency__c = 'GBP'
        );
        insert curExch;
}
    
    static testMethod void testHandleCreatedRecords() {
        
        map<id,Currency_Exchange__c > curExcMap = new map<id,Currency_Exchange__c>();
        // Create a Currency_Exchange__c record
        Currency_Exchange__c curExch = new Currency_Exchange__c (
            
            Currency__c = 'GBP'
        );
        insert curExch;
        curExcMap.put(curExch.Id, curExch);
  
        Test.startTest();
          CurrencyExchangeTriggerHandler.handleCreatedRecords(curExcMap);
        Test.stopTest();
      

            
            }
    
    static testMethod void testHandleUpdatedRecords() {
        // Create a Currency_Exchange__c record
        Currency_Exchange__c curExch = new Currency_Exchange__c (
            
            Currency__c = 'EUR'
        );
        insert curExch;
        
        // Update the Currency__c field
        curExch.Currency__c = 'EUR';
        update curExch;
        
        
    }
}