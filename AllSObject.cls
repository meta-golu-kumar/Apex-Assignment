public class AllSObject {
    
    public static List<String> getAllSObjects(){
        List<string> SObjectList = new List<string>();

        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
           String name = objTyp.getDescribe().getName();
      
           SobjectList.add(name);
        }
        return SobjectList;
    }

}