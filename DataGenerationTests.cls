@IsTest
private class DataGenerationTests {
@IsTest
static void testBruteForceAccountCreation() {
// GIVEN
List<Account> accts;
// WHEN
Test.startTest();
accts = [SELECT Id FROM Account];
Test.stopTest();
// THEN
Assert.isTrue(accts.size() > 0, 'Was expecting to find at least one account');
}
}