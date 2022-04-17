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
             
        }
        //return response;
        return results;  //PREGUNTAR ESTO
    }


}
