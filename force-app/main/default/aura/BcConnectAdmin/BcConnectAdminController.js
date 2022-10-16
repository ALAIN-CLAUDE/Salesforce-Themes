({
    doInt : function(component, event, helper) {
        var action = component.get("c.getBcConnectConfigs");
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                var results = response.getReturnValue();
                component.set("v.config",results);
              
                //use the existing selected options to decide values for all available options on admin page.
                let selectedTaskOptions = component.get("v.taskCreationValues");
                if(results.CreateTaskForInboundCall){
                    selectedTaskOptions.push('CreateTaskForInboundCall');
                }
                if(results.CreateTaskForOutboundCall){
                    selectedTaskOptions.push('CreateTaskForOutboundCall');
                }
                if(results.CreateLeadForNewCall){
                    selectedTaskOptions.push('CreateLeadForNewCall');
                }
                component.set("v.taskCreationValues",selectedTaskOptions);
                
                
                //get existing values for click to dial options
                let selectedClickToDialOption = component.get("v.clickToDialValue");
                if(results.OpenDialerAndPrefillOutboundNumber){
                    selectedClickToDialOption='PrefillNumber';
                }else{
                    selectedClickToDialOption='CallDirectly';
                }
                component.set("v.clickToDialValue",selectedClickToDialOption);
                component.set("v.inputValueLink",component.get("v.config.Region"));
                
                let inputValueLink =  component.get("v.inputValueLink");
                let region =  component.get("v.region");  
                inputValueLink=  inputValueLink.split('.');
                if(inputValueLink.length>1){
                    if(inputValueLink.length==3){
                        region = '';
                    }
                    else{
                        region = inputValueLink[1];
                    }
                }
                component.set("v.region",region);  
                component.get("v.env",'v2')
                if( component.get("v.inputValueLink").includes('v1'))
                    component.set("v.env",'v1')
                
                    
            }
            
        });
        
        $A.enqueueAction(action);
        
        
        
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getAllTabInfo().then(function(response) {
            console.log('opened tab size == '+response.length);
            for(let i=0;i<response.length;i++){
                if (response[i].url.indexOf('bableforce__babelConnect_Admin_Setup') > -1) {
                    workspaceAPI.setTabLabel({
                        tabId: response[i].tabId,
                        label: "babelConnect Admin Setup"
                    });
                }
            }
        })
        .catch(function(error) {
            console.log(error);
        });
    },
    handleEnvChange: function(component, event, helper) {
         let inputValueLink =  component.get("v.inputValueLink");
         let env =  component.get("v.env");  
         inputValueLink=  inputValueLink.split('/');
        inputValueLink[inputValueLink.length-1]=env;
         component.set("v.inputValueLink",inputValueLink.join('/'));
        
    },
    handleRegionChange: function(component, event, helper) {
        let inputValueLink =  component.get("v.inputValueLink");
        let region =  component.get("v.region");  
        inputValueLink=  inputValueLink.split('.');
        if(inputValueLink.length>1){
            if(inputValueLink.length==3){
                inputValueLink[0] =inputValueLink[0] +'.'+region;
            }
            else{
                inputValueLink[1] =region;
            }
            inputValueLink = inputValueLink.join('.');
            inputValueLink =  inputValueLink.replace('..','.')
            component.set("v.inputValueLink",inputValueLink);
        }
    },
    
    
    onTabCreated : function(component, event, helper) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.getAllTabInfo().then(function(response) {
            console.log('opened tab size == '+response.length);
            for(let i=0;i<response.length;i++){
                if (response[i].url.indexOf('bableforce__babelConnect_Admin_Setup') > -1) {
                    workspaceAPI.setTabLabel({
                        tabId: response[i].tabId,
                        label: "babelConnect Admin Setup"
                    });
                }
            }
        })
        .catch(function(error) {
            console.log(error);
        });
    },
    
    
    updateConfigs : function(component, event, helper){
        
        var regionval = component.get("v.inputValueLink");
        if(component.get("v.isOverride"))
        {
            regionval = component.get("v.inputValueLink2");
             component.set("v.config.Development_Mode__c",component.get("v.isOverride"));
         }
        
         if(regionval!='' && regionval!=null){
            component.set("v.config.Region",regionval);
         }
        
        
        component.set("v.config.Development_Mode__c",component.get("v.isOverride"));
       
        var configs= component.get('v.config');
        
        var regionInput = component.find('regionInput');
        console.log('configs==>'+regionInput);
        if(regionInput.get('v.value')){
            configs.Region = regionInput.get('v.value');
        }
        
        var leadNameInput = component.find('leadNameInput');
        if(leadNameInput.get('v.value')){
            configs.NewLeadName = leadNameInput.get('v.value');
        }
        
        var taskCreationInput = component.find('taskCreationInput');
        var selectedInputs = taskCreationInput.get('v.value');
        configs.CreateTaskForInboundCall = false;
        configs.CreateTaskForOutboundCall = false;
        configs.CreateLeadForNewCall = false;
        for(let i=0;i<selectedInputs.length;i++){
            if(selectedInputs[i] == 'CreateTaskForInboundCall'){
                configs.CreateTaskForInboundCall = true;
            }else if(selectedInputs[i] == 'CreateTaskForOutboundCall'){
                configs.CreateTaskForOutboundCall = true;
            }else if(selectedInputs[i] == 'CreateLeadForNewCall'){
                configs.CreateLeadForNewCall = true;
            }
        }
        
        var clickToDialInput = component.find('clickToDialInput');
        if(clickToDialInput.get('v.value')){
            if(clickToDialInput.get('v.value') == 'CallDirectly'){
                configs.OpenDialerAndPrefillOutboundNumber = false;
            }else if(clickToDialInput.get('v.value') == 'PrefillNumber'){
                configs.OpenDialerAndPrefillOutboundNumber = true;
            }
        }
        
        console.log(configs);
        
        let action = component.get('c.updateBcConnectConfigs');
        
        action.setParams({
            updatedConfigString : JSON.stringify(configs)
        });
        
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log(response.getReturnValue());
                var toastEvent = $A.get("e.force:showToast");
                if(response.getReturnValue() == 'ConfigsUpdatedSuccessfully'){
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "Configurations has been updated successfully.",
                        "type" : "success"
                    });
                }else{
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": response.getReturnValue(),
                        "type" : "error"
                    });
                }
                toastEvent.fire();
            } 
        });
        
        $A.enqueueAction(action);
    }
})