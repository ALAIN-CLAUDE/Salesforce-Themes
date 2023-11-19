public class ExchangeRateController2 {
   
    public class WrapperData {
        public boolean success;
        public Integer timestamp;
        public String base;
        public rates rates;
    }
   
    public class rates {
        public Double GBP;
        public Double CAD;
        public Double CHF;
        public Double AUD;
       
    }
   
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
   */
    @future(callout=true)
    public static void doGetExchange(Set<Id> recordIds){
       
       
        Map<id, Currency_Exchange__c> curExchMap = new Map<id, Currency_Exchange__c>([select id,baseCurrency__c,Exchange_rate__c ,currency__c FROM Currency_Exchange__c where id in :recordIds ]);
        String key = '6BKRU5uR3DBgLOF3HpzXjOayGwnsUPbH';
        string BaseCurrency ;
        for(Id recId:curExchMap.keySet()){
            Currency_Exchange__c curRec = curExchMap.get(recId);
           
            string  requestCurrency = curRec.currency__c;
            BaseCurrency = curRec.baseCurrency__c;

            List <Currency_Exchange__c>  recordToUpdateRate = new List <Currency_Exchange__c>();
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint('https://api.apilayer.com/exchangerates_data/latest?symbols='+requestCurrency+'&base='+BaseCurrency+'&apikey='+key);
            httpRequest.setMethod('GET');
           
            try{
                Http http = new Http();
                HttpResponse httpResponse = http.send(httpRequest);
                if(httpResponse.getStatusCode() == 200){
                    Object rateValueMap;
                   
                    WrapperData bodyDetails = (WrapperData) System.JSON.deserialize(httpResponse.getBody(), WrapperData.class);
                     system.debug('bodyDetails====> '+bodyDetails);

                   // String jsonInput = JSON.serializePretty(bodyDetails.rates);
                   String jsonInput =JSON.serialize(bodyDetails.rates);
                    
                    system.debug('Json string====> '+jsonInput);
                   
                    Map<String, Object> rateMap =   (Map<String, Object>) JSON.deserializeUntyped(jsonInput);
                               system.debug(' rateMap ====> '+ rateMap);
                    if(rateMap.get(requestCurrency) != null && requestCurrency != null){
                        rateValueMap = rateMap.get(requestCurrency);
                          system.debug(' rateValueMap ====> '+rateValueMap);
                      
                       recordToUpdateRate.add(new Currency_Exchange__c (id = curRec.id, Exchange_rate__c = double.valueOf(rateValueMap) ));
                    }
                    if(!recordToUpdateRate.isEmpty()){
                        update  recordToUpdateRate;
                    }                
                } else {
                    throw new CalloutException(httpResponse.getBody());
                }
               
            } catch(Exception ex){
                throw ex;
            }
        }
    }
}