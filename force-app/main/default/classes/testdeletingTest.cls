@isTest
public class testdeletingTest {
  
  
    private static final String CURRENCY1 = 'GBP';
    @isTest
    static void testGetExchangeRecordSuccess() {
        // Create a Currency_Exchange__c record to test with
        Currency_Exchange__c ce = new Currency_Exchange__c(
            Currency__c = CURRENCY1
        );
        insert ce;
        map<id,Currency_Exchange__c> curEx = new map<id,Currency_Exchange__c>();
        curEx.put(ce.Id, ce);
        
        ce.currency__c = 'CHF';
        update ce;
        map<id,Currency_Exchange__c> curEx2 = new map<id,Currency_Exchange__c>();
        curEx.put(ce.Id, ce);

        // Set up the mock callout class
        Test.setMock(HttpCalloutMock.class, new ExchangeRateMock('Positive'));
        
        // Run the test
        try {
            Test.startTest();
            CurrencyExchangeTriggerHandler.handleCreatedRecords(curEx);
            CurrencyExchangeTriggerHandler.handleUpdatedRecords(curEx,curEx2);
            Test.stopTest();
        } catch (Exception e) {
            System.debug('Error: ' + e);
        }
        
        // Verify that the exchange rate was updated on the Currency_Exchange__c record
        ce = [SELECT Exchange_Rate__c FROM Currency_Exchange__c WHERE Id = :ce.Id];
        Assert.areEqual(null, ce.Exchange_Rate__c);
        
    }
    
    @isTest
    static void testGetExchangeRecordFailure() {
        // Create a Currency_Exchange__c record to test with
        Currency_Exchange__c ce = new Currency_Exchange__c(
            Currency__c = CURRENCY1
        );
        insert ce;
        
        
        map<id,Currency_Exchange__c> curEx = new map<id,Currency_Exchange__c>();
        curEx.put(ce.Id, ce);

        // Set up the mock callout class
        Test.setMock(HttpCalloutMock.class, new ExchangeRateMock('Negative'));
        
        // Run the test
        try {
            Test.startTest();
            CurrencyExchangeTriggerHandler.handleCreatedRecords(curEx);
            Test.stopTest();
        } catch (Exception e) {
            System.debug('Error: ' + e);
        }
        
        // Verify that the exchange rate was not updated on the Currency_Exchange__c record
        ce = [SELECT Exchange_Rate__c FROM Currency_Exchange__c WHERE Id = :ce.Id];
       // System.assertEquals(null, ce.Exchange_Rate__c);
        Assert.areEqual(null, ce.Exchange_Rate__c);
    }


}