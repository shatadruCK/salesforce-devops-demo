@isTest
private class HelloWorldTest {

    @isTest
    static void testGreetingWithName() {

        String result = HelloWorld.getGreeting('Shatadru');

        System.assertEquals(
            'Hello, Shatadru',
            result
        );
    }

    @isTest
    static void testGreetingWithoutName() {

        String result = HelloWorld.getGreeting('');

        System.assertEquals(
            'Hello, Guest',
            result
        );
    }
}