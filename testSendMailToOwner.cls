@isTest(seeAllData = true)
public class testSendMailToOwner {
	
   @isTest static void testSendMailToOwnerMethod(){
        
        String CRON_EXP = '0 0 12 14 4 ? 2022';
                
        Test.startTest();
       	String jobId = System.schedule('SendMail', CRON_EXP, new SendMailToOppOwner());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE ID =: JobId];
        
        // verify Jobid of Scheduler 
        System.assertEquals(jobId, ct.Id);
        
        // verify cron expression
        System.assertEquals(CRON_EXP, ct.CronExpression);
       	System.debug(ct.CronExpression);
        
        // verify the job has never run
        System.assertEquals(0, ct.TimesTriggered);
       	Test.stopTest();
    }
}