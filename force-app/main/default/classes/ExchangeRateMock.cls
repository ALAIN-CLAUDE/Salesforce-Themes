@isTest
global class ExchangeRateMock implements HttpCalloutMock {
    public String receiveValueType;
    private final String EXCHANGE_RATE = '1.25';
    
    public ExchangeRateMock(string testType) {
        this.receiveValueType = testType;
    }
    
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response for the API callout
        
        if(this.receiveValueType == 'Negative'){
            HttpResponse res = new HttpResponse();     
            res.setBody('{"success":false,"error":{"code":101,"info":"Your API key is invalid or incorrect. [Technical Support: support@apilayer.com]"}}');
            res.setStatusCode(200);
            return res;
        }else{
            HttpResponse res = new HttpResponse();      
            res.setBody('{"success":true,"timestamp":1623546547,"base":"USD","rates":{"USD":' + EXCHANGE_RATE + '}}');
            res.setStatusCode(200);
            return res;
        }
        
        
        
        
    }
}