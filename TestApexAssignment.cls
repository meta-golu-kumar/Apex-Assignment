@isTest(seeAllData=false)
public class TestApexAssignment {

    @testSetup static void setup(){
        // create a class
        Class__c mathClass = new Class__c(Name__c='Math Class',MaxSize__c=30,MyCount__c=0);
        insert mathClass;
        
        // Creating a 3 students
        List<Student__c> testStudents = new List<Student__c>();
        for(Integer i = 0;i<3;i++){
            testStudents.add(new Student__c(name='Test '+i,lastName__c='kumar',sex__c='Male',class__c=mathClass.Id));
        }
        
        insert testStudents;
    }
    @isTest static void  testGetAllStudent_withActualStudentNames_ExpectedThreeStudents(){
        
        Class__c mathClass = [SELECT Id FROM Class__c WHERE Name__c ='Math Class'];
        List<String> testResult = ApexAssignment.getAllStudent(mathClass.Id);
        List<String> expectedResult = new List<String>
        {
            'Test 0','Test 1','Test 2'
        };
        System.assertEquals(expectedResult, testResult,'Expected Three Students');     
    }
    
    @isTest static void testGetAllStudent_WithNoActualStudentNames_ExpectedZeroStudents(){
        
        List<String> testResult = ApexAssignment.getAllStudent('a055j000004Qbe3BAC');
        List<String> expectedResult = new List<String>();
        System.assertEquals(expectedResult, testResult,'Expecting no Students as class id is not available.');
    }
    @isTest static void testgetClassStudentPair_WithClass_ExpectingListOfClassWithTheirStudents(){
        
        Map<String,List<Id>> testResult = ApexAssignment.getClassStudentPair();
        Set<String> actualClassName = testResult.keySet();
        System.debug(actualClassName);
        
        Test.startTest();
        Set<String> expectedClassName = new Set<String>{
            'Math Class'
        };
        
        System.assertEquals(expectedClassName, actualClassName,'Expecting class name "Math class"');
        
        Test.stopTest();
    }
    
    @isTest static void testCalculateWorkingDays_WithTwoDates_ExpectedWorkingDays(){
        Integer testResult = ApexAssignment.calculateWorkingDays(Date.today(), Date.today().addDays(10));
        System.assertEquals(7, testResult,'Expected 7 as working days');
    }
    
    @isTest static void testCalculateWorkingDays_WithEndDateGreater_ExpectedZeroWorkingDays(){
        Integer testResult = ApexAssignment.calculateWorkingDays(Date.today().addDays(10),Date.today());
        System.assertEquals(0, testResult,'Expected Zero working days');
    }
    
    @isTest static void testCalculateWorkingDays_withBothEqualDates_ExpectingZeroWorkingDays(){
        Integer testResult = ApexAssignment.calculateWorkingDays(Date.today(),Date.today());
        System.assertEquals(0, testResult,'Expected Zero working days');
    }
}
