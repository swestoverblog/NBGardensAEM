package com.adobe.aem.sql;
 
//This bean holds customer information
public class Customer {
      
    //Define private class members
    private String custId ;
    private String first;
    private String last;
    private String address;
    private String description;
      
      
    public void setCustId(String id)
    {
        this.custId = id;
    }
      
    public String getCustId()
    {
        return this.custId;
    }
      
    public void setCustFirst(String first)
    {
        this.first = first;
    }
      
    public String getCustFirst()
    {
        return this.first;
    }
      
    public void setCustLast(String last)
    {
        this.last = last;
    }
      
    public String getCustLast()
    {
        return this.last;
    }
      
    public void setCustAddress(String address)
    {
        this.address = address;
    }
      
    public String getCustAddress()
    {
        return this.address;
    }
      
    public void setCustDescription(String description)
    {
        this.description = description;
    }
      
    public String getCustDescription()
    {
        return this.description;
    }
  
}