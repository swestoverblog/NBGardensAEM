<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.adobe.cq.*" %><%
String name = request.getParameter("name");
String type = request.getParameter("type");
String desc = request.getParameter("desc");
String qty = request.getParameter("qty");
String price = request.getParameter("price");
String id = request.getParameter("id");
String id2 = request.getParameter("id2");
com.adobe.aem.sql2.ProductServiceImp ps = new com.adobe.aem.sql2.ProductServiceImp();

ps.updateProductData(id,id2,name,type,qty,desc,price); 
//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();

writer.endObject();

%>