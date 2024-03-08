@isTest
private class DailyLeadProcessorTest {
    @isTest
    static void testDailyLeadProcessor() {
        // Create a test Lead with valid Email
        Lead testLead = new Lead(Company = 'Test Company', LastName = 'Test Last Name', Email = 'test@example.com');
        insert testLead;

        // Schedule the DailyLeadProcessor job
        Test.startTest();
        System.schedule('DailyLeadProcessor Job', '0 0 0 * * ?', new DailyLeadProcessor());
        Test.stopTest();

        // Verify that a Contact was inserted for each Account with BillingState "CA"
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE Id = :testLead.Id];
        System.assertEquals('Dreamforce', updatedLeads[0].LeadSource);
    }
}