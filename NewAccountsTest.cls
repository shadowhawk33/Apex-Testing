@isTest
public class NewAccountsTest {
    @isTest static void testSObjectsInsert() {
        // Test: insert 5 accounts
        Test.startTest();
        NewAccounts.sObjectsInsert(5);
        Test.stopTest();

        // Verify that 5 accounts were inserted
        List<Account> accounts = [SELECT Id, Name, AccountNumber FROM Account];
        System.assertEquals(5, accounts.size(), 'Expected 5 accounts to be inserted');

        // Verify the names and account numbers of the inserted accounts
        for (Integer i = 0; i < 5; i++) {
            System.assertEquals('The Tea Factory ' + (i + 1), accounts[i].Name, 'Expected the account name to match');
            System.assertEquals('35629' + (i + 1), accounts[i].AccountNumber, 'Expected the account number to match');
        }
    }
}
