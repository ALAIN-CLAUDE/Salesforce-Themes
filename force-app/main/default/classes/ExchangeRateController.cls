public class ExchangeRateController {
    
    /*
    //get created rec id
    @InvocableMethod
    public static void getExchangeRecord(List <Currency_Exchange__c> CurrencyExchangeList){
        System.debug('CurrencyExchangeList   ' + CurrencyExchangeList);
        Set<Id> recordIds = new Set<Id>();
        
        for(Currency_Exchange__c current : CurrencyExchangeList){
            recordIds.add(current.Id);
        }
        
        
        if(recordIds.size()>0  && !System.isFuture()){
            doGetExchange(recordIds);
            System.debug('recordIds '+recordIds);
        }

        
    } 
    
    @future(callout=true) 
    public static void doGetExchange(Set<Id> recordIds){
         String key = '6BKRU5uR3DBgLOF3HpzXjOayGwnsUPbH';
         String strResponse = null;
        List <Currency_Exchange__c>  recordToUpdateRate = new List <Currency_Exchange__c>();
        Map<String, Object> exchangeJsonData = new Map<String, Object>();
        
 
        for(Currency_Exchange__c cuEx :[select id,Exchange_rate__c ,currency__c FROM Currency_Exchange__c where id in :recordIds ]){
            
            string  requestCurrency = cuEx.currency__c;
            string endPoint = 'https://api.apilayer.com/exchangerates_data/latest?symbols='+requestCurrency+'&base=USD&apikey='+Key ;
             system.debug('requestCurrency=================>  '+requestCurrency);
             system.debug('endPoint =================>  '+endPoint);
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint(endPoint);
            httpRequest.setMethod('GET');
            
            try{
                Http http = new Http();
                HttpResponse httpResponse = http.send(httpRequest);
                if(httpResponse.getStatusCode() == 200){
                    Object rateValueMap;
                    exchangeJsonData = (Map<String, Object>)JSON.deserializeUntyped(httpResponse.getBody());
                    
                    Map<String, Object> rateMap = (Map<String, Object>)exchangeJsonData.get('rates');
                    system.debug(rateMap.keySet());
                    if(rateMap.get(requestCurrency) != null && requestCurrency != null){
                        rateValueMap = rateMap.get(requestCurrency);
       
                        recordToUpdateRate.add(new Currency_Exchange__c (id =cuEx.Id, Exchange_rate__c = double.valueOf(rateValueMap) ));
                    }
                    
                    
                } else {
                    throw new CalloutException(httpResponse.getBody());
                }
                
            } catch(Exception ex){
                throw ex;
            }
 
        }
        if(!recordToUpdateRate.isEmpty() ){
            update  recordToUpdateRate;
        }   
    }
    
    */
    
}