<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,org.w3c.dom.*" %><%
String filter = request.getParameter("filter");

com.adobe.aem.sql2.ProductServiceImp ps = new com.adobe.aem.sql2.ProductServiceImp();

String XML = ps.getProductData(filter); 
    
//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();
writer.key("xml");
writer.value(XML);
    
writer.endObject();
%>