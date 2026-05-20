public with sharing class HelloWorld {

    public static String getGreeting(String name) {

        if(String.isBlank(name)) {
            return 'Hello, Guest4';
        }

        return 'Hello, ' + name;
    }
}