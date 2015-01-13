<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.adobe.cq.*" %><%

String id = request.getParameter("id");
com.adobe.aem.sql2.ProductServiceImp ps = new com.adobe.aem.sql2.ProductServiceImp();

ps.deleteProductData(id); 
//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();

writer.endObject();

%>