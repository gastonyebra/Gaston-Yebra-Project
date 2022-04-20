@isTest
        public class ucl_LegalAccountsCalloutsTest {

            @isTest static void testGetCallout() {
                StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
                mock.setStaticResource('Vinte');
                mock.setStatusCode(200);

                Test.setMock(HttpCalloutMock.class, mock);

                List<Object> lista = ucl_LegalAccountsCallouts.makeGetCallout();


                    Map<String, Object> AdvMap = (Map<String, Object>) lista[0];
                    System.assertEquals('5a1e51e9-8894-4e82-86f5-4a73df44d474',(String) advMap.get('AccountNumber'), 'The account Number is not 5a1e51e9-8894-4e82-86f5-4a73df44d474.');
                    System.assertEquals('Vinte',(String) advMap.get('AccountName'), 'The account Name is not Vinte.');
                    System.assertEquals('Enabled',(String) advMap.get('AccountStatus'), 'The account Status is not Enabled.');
                    System.assertEquals('6/30/2019',(String)advMap.get('AsOfDate'), 'The account Date is not 6/30/2019.');
                    
                    List<Object> clientei =(List<Object>) advMap.get('Clients');
                    Map<String, Object> cliMap = (Map<String, Object>) clientei[0];
                        
                        System.assertEquals('Genevieve',(String) cliMap.get('FirstName'), 'The client First Name is not Genevieve.');
                        System.assertEquals('Vila',(String) cliMap.get('LastName'), 'The client Last Name is not Vila.');
                        System.assertEquals('gvila0@shop-pro.jp',(String) cliMap.get('Email'), 'The client Email is not gvila0@shop-pro.jp.');
                        System.assertEquals('177-508-9836',(String) cliMap.get('Phone'), 'The client Phone is not 177-508-9836.');
                        System.assertEquals('0870 Tennessee Circle',(String) cliMap.get('Address'), 'The client Address is not 0870 Tennessee Circle.');
                        System.assertEquals('213c98aa-7a91-4c1c-9748-26dca234e898',(String) cliMap.get('ClientNumber'), 'The client Number is not 213c98aa-7a91-4c1c-9748-26dca234e898.');
                        
            }
            @isTest static void testGetCalloutError() {
                StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
                mock.setStaticResource('Cucumelo');
                mock.setStatusCode(300);

                Test.setMock(HttpCalloutMock.class, mock);

                List<Object> lista = ucl_LegalAccountsCallouts.makeGetCallout();
				
                System.assert(lista.size() == 0, 'lista is not empty');

                    
            }

        }