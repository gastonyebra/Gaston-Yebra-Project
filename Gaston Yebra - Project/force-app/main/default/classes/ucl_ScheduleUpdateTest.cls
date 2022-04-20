@isTest
private class ucl_ScheduleUpdateTest {
    
    
    public static String CRON_EXP = '0 30 20 ? * *';
    static testmethod void testScheduledJob() {
       
       
        ucl_ScheduleUpdate sch = new ucl_ScheduleUpdate();

        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
        CRON_EXP,
             new ucl_ScheduleUpdate());
        
        
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
        NextFireTime
        FROM CronTrigger WHERE id = :jobId];

        System.assertEquals(CRON_EXP, 
        ct.CronExpression);

        System.assertEquals('2022-04-19 20:30:00', 
         String.valueOf(ct.NextFireTime));

        Test.stopTest();
    }
}

