/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class ContactAndLeadSearchTest {
    @isTest static void testSearchContactsAndLeads() {
        // Create a test contact and a test lead
        Contact testContact = new Contact(LastName='Test');
        insert testContact;
        Lead testLead = new Lead(LastName='Test');
        insert testLead;

        // Test: search for contacts and leads with the test contact's last name
        List<List<sObject>> results = ContactAndLeadSearch.searchContactsAndLeads('Test');
        System.assertEquals(1, results[0].size());
        System.assertEquals(testContact.Id, ((Contact)results[0][0]).Id);
        System.assertEquals(1, results[1].size());
        System.assertEquals(testLead.Id, ((Lead)results[1][0]).Id);

        // Test: search for contacts and leads with a different last name
        results = ContactAndLeadSearch.searchContactsAndLeads('Nonexistent');
        System.assertEquals(0, results[0].size());
        System.assertEquals(0, results[1].size());
    }
}
