trigger UpdateContactHomePhone on Contact (after insert) {
    // GET Accounts IDs related to the inserted Contacts
    Set<Id> accIds = new Set<Id>();
    for (Contact con : Trigger.new) 
    {
        if (con.Email != null && con.Phone != null && con.AccountId != null) 
        {
            accIds.add(con.AccountId);
        }
    }

    // NO Accounts found, exit trigger
    if (accIds.isEmpty()) 
    {
        return;
    }

    // GET Accounts with non-blank Type
    Map<Id, Account> accounts = new Map<Id, Account>([SELECT Id, Type FROM Account WHERE Id IN :accIds AND Type != null]);

    // UPDATE HomePhone field on Contacts
    List<Contact> contactsToUpdate = new List<Contact>();
    for (Contact con : Trigger.new) 
    {
        if (con.Email != null && con.Phone != null && accounts.containsKey(con.AccountId)) 
        {
            contactsToUpdate.add(new Contact(Id = con.Id, HomePhone = con.Phone));
        }
    }
    update contactsToUpdate;
}