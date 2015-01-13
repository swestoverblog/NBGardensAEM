package com.adobe.aem.sql3;

import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class UserServiceImp implements UserService{

	@Override
	public String getUserData(String filter) {
		Connection c = null;
		 int rowCount= 0; 
	        User user = null; 
	        String query = "";
	        List<User> userList = new ArrayList<User>();
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
	               if (filter.equals("All Users"))
	                   query = "Select userId,userName,userPassword,userGroup FROM User";
	                 
	               pstmt = c.prepareStatement(query); 
	               rs = pstmt.executeQuery();
	                  
	               while (rs.next()) 
	               {
	                   //for each pass - create a useruce object
	                   user = new User(); 
	                     
	                   //Populate User members with data from MySQL
	                   int userId = rs.getInt(1);
	                   String id = Integer.toString(userId);
	                   user.setUserID(rs.getString(1)); 
	                     
	                   user.setName(rs.getString(2));
	                   user.setPassword(rs.getString(3));
	                  
	                   user.setGroup(rs.getString(4));
	                     
	                 //Push Customer to the list
	                 userList.add(user);
	                      
	               }             
	               //return xml that contains all customer taken from MySQL
	               return convertToString(toXml(userList));               
	                 
	        }
	    catch(Exception e)
	        {
	         e.printStackTrace();
	        }
	        return null;
	}

	  //Convert Customer data retrieved from the AEM JCR
   //into an XML schema to pass back to client
   private Document toXml(List<User> userList) {
   try
   {
       DocumentBuilderFactory factory =     DocumentBuilderFactory.newInstance();
       DocumentBuilder builder = factory.newDocumentBuilder();
       Document doc = builder.newDocument();
                      
       //Start building the XML to pass back to the AEM client
       Element root = doc.createElement( "Users" );
       doc.appendChild( root );
                   
       //Get the elements from the collection
       int userCount = userList.size();
         
       //Iterate through the collection to build up the DOM           
        for ( int index=0; index < userCount; index++) {
      
            //Get the Customer object from the collection
            User myuser = (User)userList.get(index);
                           
            Element User = doc.createElement( "User" );
            root.appendChild( User );
                            
            //Set qty
            Element id = doc.createElement( "Id" );
            id.appendChild( doc.createTextNode(myuser.getUserID() ) );
            User.appendChild( id );
            
            //Add rest of data as child elements to customer
            //Set  Name
            Element name = doc.createElement( "Name" );
            name.appendChild( doc.createTextNode(myuser.getName()) );
            User.appendChild( name );
                                                               
            //Set type
            Element password = doc.createElement( "Password" );
            password.appendChild( doc.createTextNode(myuser.getPassword() ) );
            User.appendChild( password );                       
                        
            //Set desc
            Element group = doc.createElement( "Group" );
            group.appendChild( doc.createTextNode(myuser.getGroup()) );
            User.appendChild( group );
            
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


