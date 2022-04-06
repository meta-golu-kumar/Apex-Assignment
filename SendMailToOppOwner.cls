public class SendMailToOppOwner implements Schedulable{
    public void execute(SchedulableContext sc){
        List<Opportunity> oppts = [Select Id,Owner.Email from Opportunity 
                                  where LastModifiedDate <> LAST_N_DAYS:30];
        
        String[] emailAddList = new String[oppts.size()];
        Integer i = 0;
        for(Opportunity oppt: oppts){
            String email = oppt.Owner.Email;
            System.debug(email);
            emailAddList[i++] = email;
        }
        
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        msg.toaddresses = emailAddList;
        msg.subject = 'To Modify the Opportunity';
        msg.plaintextbody = 'You have not modify the Opportunity since last month';
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {msg};
		Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) 
        {
            System.debug('The email was sent successfully.');
        } else 
        {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
    }
}