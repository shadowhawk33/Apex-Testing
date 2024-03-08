trigger CreateAssetsTrigger on Opportunity (after update) {
    If (Trigger.isAfter && Trigger.isUpdate){
        
        List<Asset> ListassetsToInsert = new List<Asset>();
        Set<Id> opportunityIds = new Set<Id>();
        
        Map<String,String> MapOppIdToAccId = new Map<String,String>();
        
        
        for (Opportunity opp : Trigger.new) {
            if (opp.StageName == 'Closed Won' && opp.Create_asset__c == 'Yes' && 
                Trigger.oldMap.get(opp.Id).StageName != 'Closed Won') {
                    opportunityIds.add(opp.Id);
                    MapOppIdToAccId.put(opp.Id, opp.AccountId);
                }
        }
        
        Map<Id, List<OpportunityLineItem>> opportunityLineItemMap = new Map<Id, List<OpportunityLineItem>>();
        for (OpportunityLineItem oli : [SELECT OpportunityId, Quantity FROM OpportunityLineItem WHERE OpportunityId IN :opportunityIds]) {
            if (!opportunityLineItemMap.containsKey(oli.OpportunityId)) {
                opportunityLineItemMap.put(oli.OpportunityId, new List<OpportunityLineItem>{oli});
            }
            else {
                List<OpportunityLineItem> tempOliList = opportunityLineItemMap.get(oli.OpportunityId);
                opportunityLineItemMap.put(oli.OpportunityId,(List<OpportunityLineItem>)tempOliList.add(oli));
            }
        }
        System.debug('opportunityLineItemMap>>>>>>>'+opportunityLineItemMap);
        
        Map<Id, Account> mapAccIdToAcc = new Map<Id, Account>( [ SELECT Id, ( SELECT Id FROM Contacts) FROM Account WHERE Id IN : MapOppIdToAccId.values()]);
        
        for (Id oppId : opportunityIds) {
            List<Contact> conList = new List<Contact>();
            Account acc = mapAccIdToAcc.get(MapOppIdToAccId.get(oppId));
            if (acc != null && acc.Contacts != null) {
                conList = acc.Contacts;
            }
            List<OpportunityLineItem> oliList = opportunityLineItemMap.get(oppId);
            if (oliList != null) {
                for (OpportunityLineItem oli : oliList) {
                    for (Integer i = 0; i < oli.Quantity; i++) {
                        Asset asset = new Asset();
                        asset.Opportunity__c = oppId;
                        asset.Status = 'Pending';
                        asset.Name = 'Ass'+ i;
                        asset.AccountId = MapOppIdToAccId.get(oli.OpportunityId);
                        asset.ContactId = conList[i].Id;
                        ListassetsToInsert.add(asset);
                    }
                }
            }
        }
        System.debug('ListassetsToInsert>>>>>>>'+ListassetsToInsert);
        
        if (!ListassetsToInsert.isEmpty()) {
            insert ListassetsToInsert;
        }
    }
}