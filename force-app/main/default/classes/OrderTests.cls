@isTest(SeeAllData=false)
public class OrderTests {
    
    @testSetup static void SetupTestData(){
        TestDataFactory.InsertTestData(1);
    }
    
    @isTest 
    	static void OrderUpdate_UnitTest(){
        Test.startTest();
        Order ord = [SELECT Id, Status FROM Order LIMIT 1];
        Product2 prod = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 LIMIT 1];
        
        ord.status = constants.ACTIVATED_ORDER_STATUS;
        Update ord;
        Product2 updatedp = [SELECT Id, Family, Name, Quantity_Ordered__c, Quantity_Remaining__c FROM Product2 LIMIT 1];
        
        
        TestDataFactory.VerifyQuantityOrdered(prod, updatedp, constants.DEFAULT_ROWS);
        Test.stopTest();
    }
	
    @isTest 
    static void OrderExtension_UnitTest() {
    PageReference pageRef = Page.OrderEdit;
    Test.setCurrentPage(pageRef);
    Order ord = [SELECT Id, Status FROM Order LIMIT 1];
    ApexPages.StandardController stdcontroller = new ApexPages.StandardController(ord);
    OrderExtension ext = new OrderExtension(stdcontroller);
    System.assertEquals(1, ext.orderItemList.size());
    ext.OnFieldChange();
    ext.SelectFamily();
    ext.Save();
    ext.First();
    ext.Next();
    ext.Previous();
    ext.Last();
    ext.GetHasPrevious();
    ext.GetHasNext();
    ext.GetTotalPages();
    ext.GetPageNumber();
    List<SelectOption> options = ext.GetFamilyOptions();
  }
    
    
    
    
    
    
    
    
    
}