trigger OpportunityTrigger on Opportunity (after update) {
    List<Asset> assetsToInsert = new List<Asset>();

    for (Opportunity opp : Trigger.new) {
        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

        //Opportunity is closed won and Create_Asset__c is 'Yes'
        if (opp.StageName == 'Closed Won' && opp.Create_Asset__c == 'Yes' && (oldOpp.StageName != 'Closed Won' || oldOpp.Create_Asset__c != 'Yes')) {
            List<OpportunityLineItem> olis = [SELECT Quantity FROM OpportunityLineItem WHERE OpportunityId = :opp.Id];

            for (OpportunityLineItem oli : olis) {
                //New Asset for each quantity
                for (Integer i = 0; i < oli.Quantity; i++) {
                    Asset asset = new Asset();
                    asset.AccountId = opp.AccountId;
                    asset.Product2Id = oli.Product2Id;
                    asset.Status = 'Pending';
                    assetsToInsert.add(asset);
                }
            }
        }
    }
    if (!assetsToInsert.isEmpty()) {
        insert assetsToInsert;
    }
}