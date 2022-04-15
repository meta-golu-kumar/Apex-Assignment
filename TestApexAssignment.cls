@isTest(seeAllData=true)
public class TestApexAssignment {

    @isTest static void positiveTestGetAllStudentsOfClass(){
        
        List<String> testResult = ApexAssignment.getAllStudent('a055j000004Qbe3AAC');
        List<String> expectedResult = new List<String>
        {
            'Golu Kumar','Samrat Kumar','Nikhil Barnwal'
        };
        System.assertEquals(expectedResult, testResult);     
    }
    
    @isTest static void negitiveTestGetAllStudentsOfClass(){
        
        List<String> testResult = ApexAssignment.getAllStudent('a055j000004Qbe3BAC');
        List<String> expectedResult = new List<String>();
        System.assertEquals(expectedResult, testResult);
    }
    @isTest static void testgetClassStudentPair(){
        
        Map<String,List<Id>> testResult = ApexAssignment.getClassStudentPair();
        Set<String> actualClassName = testResult.keySet();
        Set<String> expectedClassName = new Set<String>();
        List<Class__c> listOfClass = [SELECT Name From Class__c];
        Test.startTest();
        for(Class__c c: listOfClass){
            expectedClassName.add(c.name);
        }
        System.assertEquals(expectedClassName, actualClassName);
        
        Test.stopTest();
    }
    
    @isTest static void testCalculateWorkingDaysNormal(){
        Integer testResult = ApexAssignment.calculateWorkingDays(Date.today(), Date.today().addDays(10));
        System.assertEquals(7, testResult);
    }
    
    @isTest static void testCalculateWorkingDaysEndDateGreater(){
        Integer testResult = ApexAssignment.calculateWorkingDays(Date.today().addDays(10),Date.today());
        System.assertEquals(0, testResult);
    }
    
    @isTest static void testCalculateWorkingDaysBothEqualDates(){
        Integer testResult = ApexAssignment.calculateWorkingDays(Date.today(),Date.today());
        System.assertEquals(0, testResult);
    }
}