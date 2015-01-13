package com.community.aem;
 
import org.w3c.dom.Document;
import org.w3c.dom.Element;
   
   
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
   



import java.io.StringWriter;
import java.util.Iterator;
import java.util.List;
import java.util.ArrayList;
   



import javax.jcr.Repository; 
import javax.jcr.SimpleCredentials; 
import javax.jcr.Node; 
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import java.util.HashMap; 
import java.util.Map; 
   
import org.apache.jackrabbit.api.security.user.Authorizable;
import org.apache.jackrabbit.api.security.user.Group;
import org.apache.jackrabbit.api.security.user.UserManager;
import org.apache.jackrabbit.commons.JcrUtils;
 
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Service;

import javax.jcr.RepositoryException;

import org.apache.felix.scr.annotations.Reference;
import org.apache.jackrabbit.commons.JcrUtils;

import javax.jcr.Session;
import javax.jcr.Node; 

//Sling Imports
import org.apache.sling.api.resource.ResourceResolverFactory;
import org.apache.sling.api.resource.ResourceResolver; 
import org.apache.sling.api.resource.Resource; 
   
   
//This is a component so it can provide or consume services
@Component
   
@Service
public class SearchUser2Impl implements SearchUsers2 {
       
/** Default log. */
protected final Logger log = LoggerFactory.getLogger(this.getClass());
               
private Session session;
private java.util.Iterator<Authorizable> users = null ;
     
//Inject a Sling ResourceResolverFactory
@Reference
private ResourceResolverFactory resolverFactory;
 
@Override
public int getCQUsers2() {
	Map<String, Object> param = new HashMap<String, Object>();
	param.put(ResourceResolverFactory.SUBSERVICE, "datawrite");
	ResourceResolver resolver = null;

	try {
		 int num = 0;
	    //Invoke the adaptTo method to create a Session used to create a QueryManager
	 resolver = resolverFactory.getServiceResourceResolver(param);
	    session = resolver.adaptTo(Session.class);
             
  //Create a UserManager instance from the session object
  UserManager userManager = resolver.adaptTo(UserManager.class);
     
  /* to get the current user */
  Authorizable auth = userManager.getAuthorizable(session.getUserID());
  String us = auth.getID();
  log.info(us);
  /* to get the groups it is member of */
  Iterator<Group> groups = auth.memberOf();
  while (groups.hasNext()) {
	  Group g = groups.next();
	  String id2 = g.getID();
	  if(id2.equalsIgnoreCase("nbadmin")){
		  log.info("test works");
		  num = 1;	
	  }else if(id2.equalsIgnoreCase("nbuser")){
		  num = 2;	
	  }else {
		  log.info("User group not working fully");
	  }
	  log.info("User belongs to: "+id2);
  }
  
    // Log out
    session.logout();             
    return num ;  
}
catch(Exception e)
{
         log.info("CQ ERROR: "+e.getMessage())  ; 
}
         
return 0;
 }
}
