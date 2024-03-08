global class LeadProcessor implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // Collect all Lead records
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope) {
        // Update Lead records with LeadSource = 'Dreamforce'
        for (Lead lead : scope) {
            lead.LeadSource = 'Dreamforce';
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc) {
        // Optional: Perform any cleanup or post-processing
    }
}