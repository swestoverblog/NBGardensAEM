package com.adobe.aem.sql;
  
  
import com.adobe.aem.sql.ConnectionHelper;
import com.adobe.aem.sql.Customer ; 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
  
import java.util.List;
import java.util.ArrayList;
  
import org.w3c.dom.Document;
import org.w3c.dom.Element;
   
import java.io.StringWriter;
import java.util.Iterator;
  
  
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
  
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
   
 
public class CustomerServiceImp implements CustomerService {
  
    //Adds a new customer record in the Customer table
    @Override
    public int injestCustData(String firstName, String lastName, String address, String desc) {
        Connection c = null;
          
        int rowCount= 0; 
        try {
                                     
              // Create a Connection object
              c =  ConnectionHelper.getConnection();
            
               ResultSet rs = null;
               Statement s = c.createStatement();
               Statement scount = c.createStatement();
                  
               //Use prepared statements to protected against SQL injection attacks
               PreparedStatement pstmt = null;
               PreparedStatement ps = null; 
                            
               //Set the query and use a preparedStatement
               String query = "Select * FROM Customer";
               pstmt = c.prepareStatement(query); 
               rs = pstmt.executeQuery();
                  
               while (rs.next()) 
                       rowCount++;
                               
               //Set the PK value
               int pkVal = rowCount + 2; 
                  
               String insert = "INSERT INTO Customer(custId,custFirst,custLast,custAddress,custDesc) VALUES(?, ?, ?, ?, ?);";
               ps = c.prepareStatement(insert);
               ps.setInt(1, pkVal);
               ps.setString(2, firstName);
               ps.setString(3, lastName);
               ps.setString(4, address);
               ps.setString(5, desc);
               ps.execute();
               return pkVal;
        }
        catch (Exception e) {
          e.printStackTrace();
         }
        finally {
          ConnectionHelper.close(c);
    }
        return 0; 
 }
  
    /*
     * Retrieves customer data from the Customer table and returns all customer
     *The filter argument specifies one of the following values:
     *    
     *Customer - retrieves all customer data
     *Active Customer- retrieves current customers
     *Past Customer - retrieves old customers no longer current customers
     */
    @Override
    public String getCustomerData(String filter) {
        Connection c = null;
        int rowCount= 0; 
        Customer cust = null; 
        String query = "";
        List<Customer> custList = new ArrayList<Customer>();
        try {
                                     
              // Create a Connection object
              c =  ConnectionHelper.getConnection();
            
               ResultSet rs = null;
               Statement s = c.createStatement();
               Statement scount = c.createStatement();
                  
               //Use prepared statements to protected against SQL injection attacks
               PreparedStatement pstmt = null;
               PreparedStatement ps = null; 
                            
               //Set the query and use a preparedStatement
               if (filter.equals("All Customers"))
                   query = "Select custId,custFirst,custLast,custAddress,custDesc FROM Customer";
               else if(filter.equals("Past Customer"))
                   query = "Select custId,custFirst,custLast,custAddress,custDesc FROM Customer where custDesc = 'Past Customer'; ";
               else if(filter.equals("Active Customer"))
                   query = "Select custId,custFirst,custLast,custAddress,custDesc FROM Customer where custDesc = 'Active Customer'; ";
                 
               pstmt = c.prepareStatement(query); 
               rs = pstmt.executeQuery();
                  
               while (rs.next()) 
               {
                   //for each pass - create a Customer object
                   cust = new Customer(); 
                     
                   //Populate customer members with data from MySQL
                   int custId = rs.getInt(1);
                   String id = Integer.toString(custId);
                   cust.setCustId(id); 
                     
                   cust.setCustFirst(rs.getString(2));
                   cust.setCustLast(rs.getString(3));
                   cust.setCustAddress(rs.getString(4));
                   cust.setCustDescription(rs.getString(5));
                     
                 //Push Customer to the list
                 custList.add(cust);
                      
               }             
               //return xml that contains all customer taken from MySQL
               return convertToString(toXml(custList));               
                 
        }
    catch(Exception e)
        {
         e.printStackTrace();
        }
        return null;
    }
           
           
    //Convert Customer data retrieved from the AEM JCR
    //into an XML schema to pass back to client
    private Document toXml(List<Customer> custList) {
    try
    {
        DocumentBuilderFactory factory =     DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.newDocument();
                       
        //Start building the XML to pass back to the AEM client
        Element root = doc.createElement( "Customers" );
        doc.appendChild( root );
                    
        //Get the elements from the collection
        int custCount = custList.size();
          
        //Iterate through the collection to build up the DOM           
         for ( int index=0; index < custCount; index++) {
       
             //Get the Customer object from the collection
             Customer myCust = (Customer)custList.get(index);
                            
             Element Customer = doc.createElement( "Customer" );
             root.appendChild( Customer );
                             
             //Add rest of data as child elements to customer
             //Set First Name
             Element first = doc.createElement( "First" );
             first.appendChild( doc.createTextNode(myCust.getCustFirst() ) );
             Customer.appendChild( first );
                                                                
             //Set Last Name
             Element last = doc.createElement( "Last" );
             last.appendChild( doc.createTextNode(myCust.getCustLast() ) );
             Customer.appendChild( last );
                          
             //Set Description
             Element desc = doc.createElement( "Description" );
             desc.appendChild( doc.createTextNode(myCust.getCustDescription() ) );
             Customer.appendChild( desc );
                         
             //Set Address
             Element address = doc.createElement( "Address" );
             address.appendChild( doc.createTextNode(myCust.getCustAddress()) );
             Customer.appendChild( address );
          }
                  
    return doc;
    }
    catch(Exception e)
    {
        e.printStackTrace();
        }
    return null;
    }
       
       
    private String convertToString(Document xml)
    {
    try {
       Transformer transformer = TransformerFactory.newInstance().newTransformer();
      StreamResult result = new StreamResult(new StringWriter());
      DOMSource source = new DOMSource(xml);
      transformer.transform(source, result);
      return result.getWriter().toString();
    } catch(Exception ex) {
          ex.printStackTrace();
    }
      return null;
     }
     }