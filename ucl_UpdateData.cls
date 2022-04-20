public with sharing class ucl_UpdateData {


    public static void ucl_UpdateData() {

        List<Object> lista = ucl_LegalAccountsCallouts.makeGetCallout();
        List<Legal_Advisor__c> listaAdvisors = new List<Legal_Advisor__c>();
        List<Client__c> clientes = new List<Client__c>();

        /*CREO LOS CLIENTES PRIMERO Y DESPUES CHECKEO SI PERTENECEN AL LEGAL ADVISOR PARRA ASIGNARLES EL ID*/
/*
        for(Object i : lista){
            Map<String, Object> AdvMap = (Map<String, Object>) i;
            Legal_Advisor__c adv = new Legal_Advisor__c();
            adv.Name = (String) advMap.get('AccountName');
            adv.Account_Number__c = (String) advMap.get('AccountNumber');
            adv.Account_Name__c = (String) advMap.get('AccountName');
            adv.Account_Status__c = (String) advMap.get('AccountStatus');
            adv.As_of_Date__c = Date.parse((String)advMap.get('AsOfDate'));
            List<Object> clientei =(List<Object>) advMap.get('Clients'); 
            for(Object c : clientei){
                Map<String, Object> cliMap = (Map<String, Object>) c;
                Client__c cli = new Client__c();
                cli.Name = (String) cliMap.get('FirstName') + ' ' + (String) cliMap.get('LastName');
                cli.First_Name__c = (String) cliMap.get('FirstName');
                cli.Last_Name__c = (String) cliMap.get('LastName');
                cli.Email__c = (String) cliMap.get('Email');
                cli.Phone__c = (String) cliMap.get('Phone');
                cli.Address__c = (String) cliMap.get('Address');
                cli.Client_Number__c = (String) cliMap.get('ClientNumber');
                cli.Advisor_Number__c = (String) advMap.get('AccountNumber'); 
                

                clientes.add(cli);
            }

            listaAdvisors.add(adv);
        }*/

        /* PRUEBITA RANCIA */

        for(Object i : lista){
            Map<String, Object> AdvMap = (Map<String, Object>) i;
            Legal_Advisor__c adv = new Legal_Advisor__c();
            adv.Name = (String) advMap.get('AccountName');
            adv.Account_Number__c = (String) advMap.get('AccountNumber');
            adv.Account_Name__c = (String) advMap.get('AccountName');
            adv.Account_Status__c = (String) advMap.get('AccountStatus');
            adv.As_of_Date__c = Date.parse((String)advMap.get('AsOfDate'));
            if(adv.Account_Status__c == 'Enabled'){
                List<Object> clientei =(List<Object>) advMap.get('Clients'); 
                for(Object c : clientei){
                    Map<String, Object> cliMap = (Map<String, Object>) c;
                    Client__c cli = new Client__c();
                    cli.Name = (String) cliMap.get('FirstName') + ' ' + (String) cliMap.get('LastName');
                    cli.First_Name__c = (String) cliMap.get('FirstName');
                    cli.Last_Name__c = (String) cliMap.get('LastName');
                    cli.Email__c = (String) cliMap.get('Email');
                    cli.Phone__c = (String) cliMap.get('Phone');
                    cli.Address__c = (String) cliMap.get('Address');
                    cli.Client_Number__c = (String) cliMap.get('ClientNumber');
                    cli.Advisor_Number__c = (String) advMap.get('AccountNumber');
                    cli.Imported__c = true; 
                    

                    clientes.add(cli);
                }
            }
            

            listaAdvisors.add(adv);
        }

        /* -------------------------------------------------------- */

        List<Legal_Advisor__c> legs = [select id, Account_Number__c, Account_Status__c from Legal_Advisor__c];


        
        //--------------------------------------------------



        List<Legal_Advisor__c> listaAdvisors2 = new List<Legal_Advisor__c>();

        for(Legal_Advisor__c a : listaAdvisors){
            
            if(System.equals(a.Account_Status__c, 'Enabled')){
                listaAdvisors2.add(a);
            } else {
                for(Legal_Advisor__c l  : legs){
                    if((a.Account_Number__c == l.Account_Number__c) && System.equals(l.Account_Status__c, 'Enabled')){
                        listaAdvisors2.add(a);
                    }
                }
            }
        }
       
        
        //------------------------------------------------------------------------

        for(Legal_Advisor__c l : legs){
            for(Legal_Advisor__c ad  : listaAdvisors2){
                if(ad.Account_Number__c == l.Account_Number__c){
                    ad.id = l.id;
                }
            }
        }
        /*
        List<Legal_Advisor__c> legs = [select id, Account_Number__c from Legal_Advisor__c];
        for(Legal_Advisor__c a : listaAdvisors){
            boolean match = false;
            for(Legal_Advisor__c l  : legs){
                if(a.Account_Number__c == l.Account_Number__c){
                    a.id = l.id;
                    match = true;
                    break;
                }
            }
            if(!match && a.Account_Status__c == 'Disabled'){
                legs.remove(listaAdvisors.indexOf(a));

            }
        }
*/
        


        upsert listaAdvisors2;

        for (Legal_Advisor__c leg : listaAdvisors2){
            for(Client__c cl : clientes){
                if(leg.Account_Number__c == cl.Advisor_Number__c){
                    cl.Legal_Advisor__c = leg.id;
                }
            }
        }
/*
        List<Client__c> clais = [select id, Advisor_Number__c, Client_Number__c from Client__c];
        for(Client__c c : clais){
            for(Client__c b  : clientes){
                if((b.Advisor_Number__c == c.Advisor_Number__c) && (b.Client_Number__c == c.Client_Number__c) ){
                    b.id = c.id;
                }
            }
        }
*/

//PRUEBA

        List<Client__c> clais = [select id, Advisor_Number__c, Client_Number__c, Imported__c from Client__c];
        for(Client__c ci : clais){
            integer count = 0;
            for(Client__c b  : clientes){
                if((b.Advisor_Number__c == ci.Advisor_Number__c) && (b.Client_Number__c == ci.Client_Number__c) ){
                    b.id = ci.id;
                    count++;
                }
            }
            if(count == 0 && ci.Imported__c){ //TENGO QUE VER COMO HACER PARA QUE AL CREAR EL ADMIN UN NUEVO CLIENTE NO PUEDE CHECKEAR EL CAMPO IMPORTED
                delete ci;
            }
        }
        upsert clientes;

        /*--------------------------------------------------------------------------------------------------------------------*/

        /*CREO LOS CLIENTES A MEDIDA QUE VOY CHECHEANDO EL ID DE CADA LEGAL ADVISOR ------ no me sale :/ */

       /* List<Object> clientei = new List<Object>();

        for(Object i : lista){
            Map<String, Object> AdvMap = (Map<String, Object>) i;
            Legal_Advisor__c adv = new Legal_Advisor__c();
            adv.Account_Number__c = (String) advMap.get('AccountNumber');
            adv.Account_Name__c = (String) advMap.get('AccountName');
            adv.Account_Status__c = (String) advMap.get('AccountStatus');
            adv.As_of_Date_c = (Date) advMap.get('AsOfDate');
            clientei.add(advMap.get('Clients'));
            

            listaAdvisors.add(adv);
        }





        upsert listaAdvisors;

        for (Legal_Advisor__c leg : listaAdvisors){
            for(Object c : clientei){
                Map<String, Object> cliMap = (Map<String, Object>) c;
                Client__c cli = new Client__c();
                cli.First_Name__c = (String) cliMap.get('FirstName');
                cli.Last_Name__c = (String) cliMap.get('LastName');
                cli.Email__c = (String) cliMap.get('Email');
                cli.Phone__c = (String) cliMap.get('Phone');
                cli.Address__c = (String) cliMap.get('Address');
                cli.Client_Number__c = (String) cliMap.get('ClientNumber');
                cli.Legal_Advisor__c = leg.id;

                clientes.add(cli);
            }
        }*/
        /*-----------------------------------------------------------------------------------------------------------------------------*/
    }
}


