public with sharing class AccWithContactsController {
    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}

    private final Account account;
    public Account newAccount{get; set;}
    private Contact newContact;
    private final String accountId;
    private Boolean show = false;
 
    /*public AccWithContactsController() {
        accountId = ApexPages.currentPage().getParameters().get('id');
        account = [SELECT Id, Name, OwnerId, Type, AccountSource, AnnualRevenue, Rating, CreatedById, Industry, NumberOfEmployees, Fax FROM Account 
                   WHERE Id = : accountId];
        newAccount = new Account();    
        newContact = new Contact();       
    }*/

    public AccWithContactsController(ApexPages.StandardController controller) {
        //ID contactId = [Select contactid from User where id =: Userinfo.getUserid()].contactId;

        //ID accountId  = [Select AccountID from Contact where id =: contactid].AccountId;
        account = [SELECT Id, Name, OwnerId, Type, AccountSource, AnnualRevenue, Rating, CreatedById, Industry, NumberOfEmployees, Fax FROM Account 
                   WHERE Id = '0012w00000KHLkQAAX'];
        newAccount = new Account();    
        newContact = new Contact();       
    
    }
  
    public Account getAccount() {
        return account;
    }

    public Contact getNewContact() {
        return newContact;
    }

    public Account getNewAccount() {
        return newAccount;
    }

    public Boolean getShowNewContact()
    {
        return this.show;
    }

    public void setShowNewContact()
    {
        if(newAccount.Name != '') {
            this.show = true;
        } else {
            this.show = false;
        }
        
    }

    public ApexPages.StandardSetController setCon {
        get{
            if(setCon == null){
                size = 10;
                string queryString = 'Select Name, Email, Phone, Fax, Department from Contact where AccountId =: accountId order by Name';
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(queryString));
                setCon.setPageSize(size);
                noOfRecords = setCon.getResultSize();
            }
            return setCon;
        }set;
    }
     
    Public List<Contact> getContacts(){
        List<Contact> contList = new List<Contact>();
        for(Contact c : (List<Contact>)setCon.getRecords())
            contList.add(c);
        return contList;
    }
     
    public pageReference refresh() {
        setCon = null;
        getContacts();
        setCon.setPageNumber(1);
        return null;
    }

    public void saveNewAccount() {
        insert newAccount;
    }

    public void clearNewAccount() {
        this.newAccount = new Account();
    }

    public void saveNewContact() {
        if(this.newAccount.Id == null) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 'Account is not specified!'));
        } else {
            this.newContact.AccountId = this.newAccount.Id;
            insert this.newContact;
        }
    }
    public void clearNewContact() {
        this.newContact = new Contact();
    }
    
}
