public class ApexAssignment {
    public static Student__c[] getAllStudent(String className){
        
        Class__c[] classWithStudents = [SELECT (SELECT Name FROM Student_Class__r)
                                     FROM Class__c WHERE name =: className];
        
        return classWithStudents[0].Student_class__r;
    }
    
    public static Map<String,List<Id>> getClassStudentPair(){
        
        Class__C[] classList = [SELECT Name,(SELECT Id from Student_class__r) from Class__c];
        
        Map<String,List<Id>> mapping = new Map<String,List<Id>>();
        for(Class__c c: classList){
            Student__c[] studentList = c.Student_Class__r;
            List<Id> studentIdList = new List<Id>();
            for(Student__c s: studentList){
                studentIdList.add(s.Id);
            }
            mapping.put(c.name,studentIdList);
        }
        
        return mapping;
    }
    
    public static Integer calculateWorkingDays(Date startDate, Date endDate)  
    {    
        Integer workingDays = 0;  
         
        for(integer i=1; i < startDate.daysBetween(endDate); i++)  
        {  
            Date dt = startDate + i;  
            DateTime currDate = DateTime.newInstance(dt.year(), dt.month(), dt.day());  
            String todayDay = currDate.format('EEEE');  
            if(todayDay != 'Saturday' && todayDay !='Sunday')  
                {  
                    workingDays = workingDays + 1;  
                }     
               
        }   
        return workingDays;  
        
    }  
}