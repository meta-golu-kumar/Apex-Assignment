public class ApexAssignment {
    public static List<String> getAllStudent(Id classId){
        
        Student__c[] stds= [Select name from student__c where class__c =: classId];
        
        List<String> studentNameList = new List<String>();
       
        for(Student__c std: stds){
            studentNameList.add(std.name);
        }
        return studentNameList;
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
        
        // 10 - 20 = 10
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
