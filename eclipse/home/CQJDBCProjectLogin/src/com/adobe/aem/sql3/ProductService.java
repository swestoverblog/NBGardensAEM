package com.adobe.aem.sql3;
  
public interface ProductService {
      
    //Adds a new customer record in the Customer table
    public int injestProdData(String id,String name, String type, String qty, String desc, String price);

  
}