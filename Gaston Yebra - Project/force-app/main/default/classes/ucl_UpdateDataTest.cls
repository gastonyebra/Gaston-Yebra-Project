@isTest
private class ucl_UpdateDataTest {
   
   @isTest static void ucl_UpdateDataTest() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Cucumelo');
        mock.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, mock);

        

        ucl_UpdateData.ucl_UpdateData();

        List<Legal_Advisor__c> lt = [select id, Name from Legal_Advisor__c where Name='Cucumelo'];

        System.assertEquals(1, lt.size(), 'record wasn`t uploaded');

    }

    @isTest static void ucl_UpdateDataTest2() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Nada');
        mock.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, mock);

        ucl_UpdateData.ucl_UpdateData();


        

        List<Legal_Advisor__c> lt = [select id, Name, Account_Status__c from Legal_Advisor__c ];

        System.assertEquals(0, lt.size(), 'something was uploaded');

    }
    @isTest static void ucl_UpdateDataTest3() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Cacatua');
        mock.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, mock);

        

        ucl_UpdateData.ucl_UpdateData();

        List<Legal_Advisor__c> lt = [select id, Name from Legal_Advisor__c where Name='Cacatua'];

        System.assertEquals(0, lt.size(), 'record was uploaded');

    }
    @isTest static void ucl_UpdateDataTest4() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Cucumelo');
        mock.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, mock);

        

        ucl_UpdateData.ucl_UpdateData();

        List<Legal_Advisor__c> lt = [select id, Name from Legal_Advisor__c where Name='Cucumelo'];

        System.assertEquals(1, lt.size(), 'record was uploaded');

    }
    @isTest static void ucl_UpdateDataTest5() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Combo');
        mock.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, mock);


        ucl_UpdateData.ucl_UpdateData();


        List<Client__c> cl = [select id, Name from Client__c ];
        

        System.assertEquals(2, cl.size(), 'hay mas de 2');

    }
    @isTest static void ucl_UpdateDataTest6() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Combo');
        mock.setStatusCode(230);
        
        Test.setMock(HttpCalloutMock.class, mock);


        ucl_UpdateData.ucl_UpdateData();


        List<Client__c> cl = [select id, Name from Client__c ];
        

        System.assertEquals(0, cl.size(), 'se insertaron cosas');

    }
    @isTest static void ucl_UpdateDataTest7() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('Cualca');
        mock.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, mock);


        ucl_UpdateData.ucl_UpdateData();


        List<Client__c> cl = [select id, Name from Client__c ];
        

        System.assertEquals(0, cl.size(), 'se insertaron cosas');

    }
}
