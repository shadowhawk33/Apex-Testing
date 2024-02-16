@IsTest
private class MyDataGenerationTests {
    @TestSetup
    static void loadTestDataFromStaticResource () {
        //Given
        List<sObject> accounts = Test.loadData(Account.SObjectType, 'OtherAccountData');
    }
    @IsTest
    static void testLoadAccountsFromStaticResource () {
        //When
        List<Account> accts = [SELECT ID FROM Account];
        //Then
        System.assertEquals(15, accts.size(), 'Expected 15 accounts');
    }
}
