public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        List<Account> accountsToUpdate = new List<Account>();
        
        // Query for the number of Contacts associated with each Account
        for (Id accId : accountIds) {
            Integer numOfContacts = [SELECT COUNT() FROM Contact WHERE AccountId = :accId];
            accountsToUpdate.add(new Account(Id = accId, Number_Of_Contacts__c = numOfContacts));
        }
        
        // Update the Account records
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}