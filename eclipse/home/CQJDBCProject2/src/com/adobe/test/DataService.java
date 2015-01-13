package com.adobe.test;
import java.sql.*;
 
public class DataService {
  
public String getUser(){
    Connection c = null;
    String firstName =""; 
    try {
    
          // Create a Connection object
          c =  ConnectionHelper.getConnection();
     
           Statement s = c.createStatement();
           ResultSet rs = s.executeQuery("Select * from Customer");
           rs.next(); 
           firstName = rs.getString("custFirst");
        
    }
    catch (Exception e) {
      e.printStackTrace();
     }
    finally {
      ConnectionHelper.close(c);
    }
    return firstName;
  }
}