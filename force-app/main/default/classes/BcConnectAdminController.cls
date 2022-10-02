public with sharing class BcConnectAdminController {
	@auraEnabled
    Public Static bcConnectconfig getBcConnectConfigs(){
        bcConnectconfig configs=new bcConnectconfig();
        
        //We use the protected custom setting to store the config values in salesforce
        bcConnectConfig__c mc = bcConnectConfig__c.getValues('bcConnectConfigs');
        
        if(mc != null){
            configs.Region = mc.Region__c;
            configs.CreateTaskForInboundCall = mc.CreateTaskForInboundCall__c;
            configs.CreateTaskForOutboundCall = mc.CreateTaskForOutboundCall__c;
            configs.OpenDialerAndPrefillOutboundNumber = mc.OpenDialerAndPrefillOutboundNumber__c;
            configs.CreateLeadForNewCall = mc.bableforce__Create_Lead_Upon_Call__c;
            configs.NewLeadName = mc.bableforce__New_Lead_Name__c;
        }else{
            configs.Region = '';
            configs.CreateTaskForInboundCall = false;
            configs.CreateTaskForOutboundCall = false;
            configs.OpenDialerAndPrefillOutboundNumber = false;
            configs.CreateLeadForNewCall = false;
            configs.NewLeadName = '';
        }
        
        return configs;
    }
    
    @auraEnabled
    Public Static string updateBcConnectConfigs(string updatedConfigString){
        if(string.isNotBlank(updatedConfigString)){
            bcConnectconfig configs=(bcConnectconfig)JSON.deserialize(updatedConfigString, bcConnectconfig.class);
            
            //We use the protected custom setting to store the config values in salesforce
        	bcConnectConfig__c mc = bcConnectConfig__c.getValues('bcConnectConfigs');
              configs.isSandbox= [SELECT IsSandbox, Id FROM Organization].IsSandbox;
            if(mc==null){
                mc = new bcConnectConfig__c();
            }
            
            mc.Name='bcConnectConfigs';
            mc.Region__c=configs.Region;
            mc.CreateTaskForInboundCall__c=configs.CreateTaskForInboundCall;
            mc.CreateTaskForOutboundCall__c=configs.CreateTaskForOutboundCall;
            mc.OpenDialerAndPrefillOutboundNumber__c=configs.OpenDialerAndPrefillOutboundNumber;
            mc.bableforce__Create_Lead_Upon_Call__c = configs.CreateLeadForNewCall;
            mc.bableforce__New_Lead_Name__c = configs.NewLeadName;
            
            try{
                if(String.isNotBlank(mc.Id) && bcConnectConfig__c.sObjectType.getDescribe().isUpdateable() && Schema.sObjectType.bcConnectConfig__c.fields.Name.isUpdateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.Region__c.isUpdateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.CreateTaskForInboundCall__c.isUpdateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.CreateTaskForOutboundCall__c.isUpdateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.OpenDialerAndPrefillOutboundNumber__c.isUpdateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.bableforce__Create_Lead_Upon_Call__c.isUpdateable() ){
                 update mc;
                }
                else if(bcConnectConfig__c.sObjectType.getDescribe().isCreateable() && Schema.sObjectType.bcConnectConfig__c.fields.Name.isCreateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.Region__c.isCreateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.CreateTaskForInboundCall__c.isCreateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.CreateTaskForOutboundCall__c.isCreateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.OpenDialerAndPrefillOutboundNumber__c.isCreateable() &&
                Schema.sObjectType.bcConnectConfig__c.fields.bableforce__Create_Lead_Upon_Call__c.isCreateable() ){
                insert mc;
                }
                return 'ConfigsUpdatedSuccessfully';
            }catch(exception e){
                return e.getMessage();
            }
        }
        return 'No Data passed back to Controller.';
    }
    
    public class bcConnectconfig{
        @auraEnabled public string Region;
        
        // if set to true, a new lead will be created for any inbound or outbound call.
        @auraEnabled public boolean CreateLeadForNewCall; 
        
        // Will decide the name of the new lead that we need to create.
        @auraEnabled public String NewLeadName; 
        
        // if set to true, a new task will be created for all inbound calls.
        @auraEnabled public boolean CreateTaskForInboundCall; 
        
        // if set to true, a new task will be created for all outbound calls.
        @auraEnabled public boolean CreateTaskForOutboundCall; 
        
        // if set to true, click to dial will only fill the number and not dial it directly.
        @auraEnabled public boolean OpenDialerAndPrefillOutboundNumber; 
          // if set to true, if this is developer org
         @auraEnabled public boolean isSandbox;
    }
}