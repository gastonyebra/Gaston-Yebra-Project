public with sharing class ucl_LegalAccountsCallouts {
   
    
    /*
    public static HttpResponse makeGetCallout(){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());    
        }
        return response;
    }*/


    public static List<Object> makeGetCallout(){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Object> results = new List<Object>();
        // If the request is successful, parse the JSON response.
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
            results = (List<Object>) JSON.deserializeUntyped(response.getBody());  
             
        } else {
            System_Error__c error = new System_Error__c();
            error.Name = 'System Error';
            error.Date__c = date.today();
            error.Message__c = 'An error has occurred while processing your data, please contact to your sevice provider.';
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'gastonyebra@gmail.com'};
       
            mail.setToAddresses(toAddresses);

            mail.setToAddresses(toAddresses);
            mail.setSubject('Update Error');
            mail.setPlainTextBody(error.Message__c + '\n Error date: ' + error.Date__c);
        }
        //return response;
        return results;  //PREGUNTAR ESTO
    }


}
