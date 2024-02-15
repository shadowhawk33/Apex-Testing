@isTest
public class ContactSearchTest {
    @isTest static void testSearchForContacts() {
        // Created: Test Contact
        Contact testContact = new Contact(LastName='Test', MailingPostalCode='12345');
        insert testContact;

        // Test: search for contacts with the test contact's last name and mailing postal code
        List<Contact> results = ContactSearch.searchForContacts('Test', '12345');
        System.assertEquals(1, results.size());
        System.assertEquals(testContact.Id, results[0].Id);

        // Test: search for contacts with a different last name
        results = ContactSearch.searchForContacts('Nonexistent', '12345');
        System.assertEquals(0, results.size());

        // Test: search for contacts with a different mailing postal code
        results = ContactSearch.searchForContacts('Test', '00000');
        System.assertEquals(0, results.size());
    }
}