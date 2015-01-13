<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,org.w3c.dom.*" %><%
String filter = request.getParameter("filter");

com.adobe.aem.sql3.UserServiceImp ps = new com.adobe.aem.sql3.UserServiceImp();

String XML = ps.getUserData(filter); 
    
//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();
writer.key("xml");
writer.value(XML);
    
writer.endObject();
%>