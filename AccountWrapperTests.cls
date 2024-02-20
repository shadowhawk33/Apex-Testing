@IsTest
private class AccountWrapperTests {
    @TestSetup
    static void loadTestData() {
        // GIVEN
        Account acct = new Account(Name = 'ACME');
        insert acct;
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            opps.add(new Opportunity(Name = 'Opportunity ' + i, AccountId = acct.Id, Amount = 100000.00 * (i + 1), StageName = 'Closed Won', CloseDate = Date.today()));
        }
        insert opps;
    }
    @IsTest
    static void testGetRoundedAvgPriceOfOpps() {
        // WHEN
        Account acct = [SELECT Id FROM Account LIMIT 1];
        AccountWrapper acctWrapper = new AccountWrapper(acct);
        // THEN
        Test.startTest();
        System.assertEquals(300000.00, acctWrapper.getRoundedAvgPriceOfOpps(), 'Expected the rounded average price of opportunities to be 300000.00');
        Test.stopTest();
    }
    @IsTest
    static void testIsHighPriority() {
        // WHEN
        Account acct = [SELECT Id FROM Account LIMIT 1];
        AccountWrapper acctWrapper = new AccountWrapper(acct);
        // THEN
        Test.startTest();
        System.assertEquals(true, acctWrapper.isHighPriority(), 'Expected the account to be high priority');
        Test.stopTest();
    }
    @IsTest
    static void testNoWonOpportunities() {
        // GIVEN
        Account acct = new Account(Name = 'ACME');
        insert acct;
        // WHEN
        AccountWrapper acctWrapper = new AccountWrapper(acct);
        // THEN
        Test.startTest();
        try {
            acctWrapper.getRoundedAvgPriceOfOpps();
            System.assert(false, 'Expected an AWException to be thrown');
        } catch (AccountWrapper.AWException e) {
            System.assertEquals('No won Opportunities', e.getMessage(), 'Expected the exception message to be "No won Opportunities"');
        }
        Test.stopTest();
    }
    @IsTest
    static void testNotHighPriority() {
        // GIVEN
        Account acct = new Account(Name = 'ACME');
        insert acct;
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            opps.add(new Opportunity(Name = 'Opportunity ' + i, AccountId = acct.Id, Amount = 500.00 * (i + 1), StageName = 'Closed Won', CloseDate = Date.today()));
        }
        insert opps;
        // WHEN
        AccountWrapper acctWrapper = new AccountWrapper(acct);
        // THEN
        Test.startTest();
        System.assertEquals(false, acctWrapper.isHighPriority(), 'Expected the account to not be high priority');
        Test.stopTest();
    }
}
