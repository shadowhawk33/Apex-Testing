@isTest
public class CalculatorTests {
    @isTest static void testDivideByZero() {
        Integer numerator = 10;
        Integer denominator = 0;
        Exception expectedException;
        try {
            Test.startTest();
            Decimal result = Calculator.divide(numerator, denominator);
            Test.stopTest();
            Assert.fail('An exception should have been thrown');
        } catch (Calculator.CalculatorException e) {
            expectedException = e;
        }
        System.assertNotEquals(null, expectedException, 'Expected CalculatorException but got none');
        System.assertEquals('You still can\'t divide by zero', expectedException.getMessage(), 'Exception message mismatch');
    }
}