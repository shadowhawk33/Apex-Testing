public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext context) {
        List<Lead> leadsToUpdate = [SELECT Id FROM Lead WHERE LeadSource = null LIMIT 200];
        
        for (Lead lead : leadsToUpdate) {
            lead.LeadSource = 'Dreamforce';
        }
        
        update leadsToUpdate;
    }
}