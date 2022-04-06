public class FutureMethodClass {
    @future
    public static void addContactIds(Id contactId){
        
        Contact contact = [select Account.id,Account.contactIds__c from contact where id = :contactId];
        if(contact.Account.contactIds__c == null){
            
            Account acct = [Select (Select id from contacts) 
                                     from Account where id =: contact.Account.Id];
            String contactIdList = '';
            Contact[] conList = acct.contacts;
            for(Contact c: conList){
                contactIdList = contactIdList + c.Id +',';
            }
            
            contact.Account.ContactIds__c = contactIdList;
            System.debug(contactIdList);
            update contact.Account;
            System.debug('ContactIds is updated!');
        }else{
            String contactIdList = contact.Account.contactIds__c;
            if(contactIdList.contains(contact.Id)){
                System.debug('Contact id is already exist!');
            }else{
                contactIdList = contactIdList + contact.Id + ',';
                contact.Account.ContactIDs__c = contactIdList;
                update contact.Account;
                System.debug('Contact is inserted!');
            }
        }
    }
    
    public static void updateOpportunity(List<Opportunity> oppts){
        for(Opportunity oppt: oppts){
            if(oppt.BillToContact__r != null && oppt.Manager__r == null){
                Contact con = [select Account.Id from Contact where id =: oppt.BillToContact__r.Id];
                Account acct = con.Account;
                oppt.Manager__r = acct;
                update oppt;
                System.debug('Update successful');
            }else{
                System.debug('Something error!');
            }
        }
    }
}