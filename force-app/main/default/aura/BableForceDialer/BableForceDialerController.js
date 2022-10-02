({
    
    doInit: function(component, event, helper) {
        var action = component.get("c.getBcConnectConfigs");
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                var results = response.getReturnValue();
                component.set("v.config",results);
                component.set("v.ifameUrlWithRegion",results.Region);
            } 
        });
        $A.enqueueAction(action);
        
        sforce.opencti.onNavigationChange({
            listener: function(payload) {
				//console.log('Navigation change occurred.');
                //console.log(JSON.parse(JSON.stringify(payload)));
                let data=JSON.parse(JSON.stringify(payload));
                component.set('v.lasturl',data.url);
                //console.log(data.url);
                var vfWindow = component.find("vfFrame").getElement().contentWindow;
                vfWindow.postMessage({
                    type: 'connect',
                    module: 'context',
                    name: 'set',
                    args: {
                        mostRecentUrl: data.url
                    }
                }, '*');
            }
		}); 
        
    },
    
    demomethod : function(component, event, helper) {
        console.log(component.get('v.lasturl'));
    },
    
    handleEVent : function(component, event, helper) {
        console.log('handleEVent==>'+ event.getParam("callInformation"));
        component.set('v.mostrecenturl',event.getParam("callInformation"));
        console.log('handleEVent '+ component.get('v.mostrecenturl'));
    }
})