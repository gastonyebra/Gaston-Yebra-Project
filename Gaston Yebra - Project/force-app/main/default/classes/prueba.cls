public with sharing class prueba {
    public prueba() {

        List<Legal_Advisor__c> advisors = new List<Legal_Advisor__c>();
        List<Client__c> clients = new List<Client__c>();

        for(/* para todos los elementos que importe del JSON */){
            Legal_Advisor__c adv = new Legal_Advisor__c();
            ad.Account_Name__c = 'aca iria el advisor_importado.Account_Name o como se escriba, despues veo';
            ad.Account_Number__c = 'same';
            .
            .
            .
            advisors.add(adv);

            //aca tengo que resolver como aggarro los clientes
        }
        
        //despues tiro un insert (creo)
        
        
        
        for(Legal_Advisor__c ad : advisors){  
            ad.Account_Name__c = 'aca iria el advisor_importado.Account_Name o como se escriba, despues veo';
            ad.Account_Number__c = 'same';
            .
            .
            .
            for(Client__c cli : clients){
                cli.First_Name = 'aca pones el fist name de los clients de cada legal advisor';
                .
                .
                .
            }
        }



        -> Deserializo el JSON 
        -> En que formato me queda????
            ->si hago un Map<String,Object> o algo asi, y lo llamo con JSON.deserialize(nombreDelObjeto, Legal_Advisor__c.class) (parseandolo a Legal_Advisor__c) ESTO ME RESUELVE EL PROBLEMA?


            -> Pasando al tema de como acceder a los clientes dentro de cada Legal_Advisor__c, se accede como si la lista fuera un campo más dentro del advisor???
            -> No debería, tendria que buscar dentro del string que me trae el JSON para encontrar los campos de los clientes???



        -> Creo una lista de objetos Legal_Advisor__c
        -> Creo una lista de objetos Client__c
        -> While(haya elementos en la deserealizacion del JSON ?????){
            new Legal_Advisor__c
            meto los datos del advisor deserializado en el new
            accedo a sus clientes ???
            while(tenga clientes ????){
                new Client__c
                meto los datos del cliente deserializado en el new
                add a la lista de Client__c
            }
            add a la lista de Legal_Advisor__c
        }
        


    }


    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
    request.setMethod('GET');
    HttpResponse response = http.send(request);
    // If the request is successful, parse the JSON response.
    if(response.getStatusCode() == 200) {
        // Deserialize the JSON string into collections of primitive data types.
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        // Cast the values in the 'animals' key as a list
        List<Object> advisors = (List<Object>) results.get('LegalAccounts');
        System.debug('Received the following accounts:');
        for(Object account: advisors) {
            System.debug(account);
        }
    }
}

/* ----ESTO ANDA (PONELE)---- */


public static List<Object> makeGetCallout(){

    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://altimetrik-bootcamp.herokuapp.com/LegalAccounts');
    request.setMethod('GET');
    HttpResponse response = http.send(request);
    // If the request is successful, parse the JSON response.
    if(response.getStatusCode() == 200) {
        // Deserialize the JSON string into collections of primitive data types.
        List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());  
        System.debug('sexo');  
    }
    //return response;
    return results;  //PREGUNTAR ESTO
}


/* -------------------------- */


List<Object> lista = LegalAccountsCallouts.makeGetCallout();
List<Legal_Advisor__c> listaAdvisors = new List<Legal_Advisor__c>();
List<Client__c> clientes = new List<Client__c>();

for(Object i : lista){
    Map<String, Object> AdvMap = (Map<String, Object>) i;
    Legal_Advisor__c adv = new Legal_Advisor__c();
    adv.Account_Number__c = (String) advMap.get('AccountNumber');
    adv.Account_Name__c = (String) advMap.get('AccountName');
    adv.Account_Status__c = (String) advMap.get('AccountStatus');
    adv.As_of_Date_c = (Date) advMap.get('AsOfDate');
    List<Object> clientei = advMap.get('Clients'); 
    for(Object c : clientei){
        Map<String, Object> cliMap = (Map<String, Object>) c;
        Client__c cli = new Client__c();
        cli.First_Name__c = (String) cliMap.get('FirstName');
        cli.Last_Name__c = (String) cliMap.get('LastName');
        cli.Email__c = (String) cliMap.get('Email');
        cli.Phone__c = (String) cliMap.get('Phone');
        cli.Address__c = (String) cliMap.get('Address');
        cli.Client_Number__c = (String) cliMap.get('ClientNumber');
        cli.Advisor_Number__c = (String) advMap.get('AccountNumber');  //ACA TENGO QUE CREAR ESTE CAMPO

        clientes.add(cli);
         
    }
    listaAdvisors.add(adv);
}

upsert listaAdvisors;

for (Legal_Advisor__c leg : listaAdvisors){
    for(Client__c cl : clientes){
        if(leg.Account_Number__c == cl.Advisor_Number__c){
            cl.Legal_Advisor__c = leg.id;
        }
    }
}

//ACA PODEMOS HACER UN UPSERT DE LOS Legal_Advisor__c Y AHÍ LOS QUERYAMOS PARA OPTENER SUS IDS Y ASIGNARSELOS A LOS CLIENTES






PREGUNTAR:


vscode retrieve de los objetospara github o algo de eso


si un objeto no viene mas ewn el JSON hay que borrarlo a no ser que lo hayan ingresado manualmente un admin en salesforce
entonces habria que chequear todos los records de legal advisor y client que hay en la org antes de borrar nada


/*-------POR HACER--------*/

-YA TENGO EL HTTP REQUEST Y EL ESQUEMA BASICO DE COMO VOY A IMPORTAR LOS DATOS
-TENGO AHORA QUE AVERIGUAR COMO CONSEGUIR EL ID DE LOS Legal_Advisor__c PARA ASOCIARSELO A CADA Client__c
-UNA VEZ QUE TENGA ESO VA A ESTAR TODO PRONTO EL TEMA DE IMPORTAR LOS DATOS DEL JSON Y GUARDARLOS EN MEMORIA DINAMICA
-DESPUES DE ESO TENGO QUE HACER LAS QUERIES PARA VER DE QUE MANERA SE SOBREESCRIBE LA DATA:
    (CASOS:
        -SI TENGO EN SALESFORCE UN Client__c GUARDADO PERO EN EL SIGUENTE GET DE HEROKU ESE Client__c NO VIENE LO TENGO QUE BORRAR (A NO SER QUE FUERA UN REGISTRO CREADO A MANO POR UN ADMIN
                                                                                                                                    EN CUYO CASO DEBERÍA IDENTIFICARLO COMO TAL Y DEJARLO
                                                                                                                                    QUIETO)
        -SOLO GUARDO EN SALESFORCE LOS Legal_Advisor__c QUE TENGAN EL VALOR DE ESTATUS EN 'ENABLED', Y GUARDO LOS 'DISABLED' SOLO SI EL REGISTRO YA EXIXTÍA EN SALESFORCE CON ESTADO 'ENABLED'
        (LO ACTUALIZO)
    )
-VER DE QUE CUANDO UN Legal_Advisor__c SEA BORRADO A MANO POR UN ADMIN SE BORREN TAMBIEN SUS CLIENTES //ESTO SE CUMPLE SOLO POR SER UNA MASTER-DETAIL RELATIONSHIP

-TENGO QUE VER TAMBIEN COMO HAGO PARA TENER UN RECUENTO DE CUANDOS Legal_Advisor__c Y CUANTOS Client__c HAY GUARDADOS EN SALESFORCE AL FINAL DE CADA ACTUALIZACION

/*------------------------*/


antes del upsert:

List<Map<id, string>> leg = [select id, Account_Number__c from Legal_Advisor__c]
for(Map<id, string> l : leg){
    for(Legal_Advisor__c a  : listaAdvisors){
        if(a.Account_Number__c == l.Account_Number__c){
            a.id = l.id;
        }
    }
}

List<Client__c> clais = [select id, Advisor_Number__c, Client_Number__c from Client__c];
for(Client__c c : clais){
    integer count = 0;
    for(Client__c b  : clientes){
        if((b.Advisor_Number__c == c.Advisor_Number__c) && (b.Client_Number__c == c.Client_Number__c) ){
            b.id = c.id;
            count++;
        }
    }
    if(count == 0){
        delete c;
    }
}

List<Legal_Advisor__c> legs = [select id, Account_Number__c from Legal_Advisor__c];
for(Legal_Advisor__c a : listaAdvisors){
    boolean match = false;
    for(Legal_Advisor__c l  : legs){
        if(a.Account_Number__c == l.Account_Number__c){
            
            match = true;
            break;
        }
    }
    if(!match && l.Account_Status__c == 'Disabled'){
        legs.remove(listaAdvisors.indexOf(l));

    }
}