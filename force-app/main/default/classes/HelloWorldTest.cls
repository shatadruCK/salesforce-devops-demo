@isTest
private class HelloWorldTest {

    @isTest
    static void testGreetingWithName() {

        String result = HelloWorld.getGreeting('Shatadru');

        System.assertEquals(
            'Hello, Shatadru',
            result,
            'Greeting should match the provided name'
        );
    }

    @isTest
    static void testGreetingWithoutName() {

        String result = HelloWorld.getGreeting('');

        System.assertEquals(
            'Hello, Guestt',
            result,
            'Blank name should return Guest greeting'
        );
    }
}