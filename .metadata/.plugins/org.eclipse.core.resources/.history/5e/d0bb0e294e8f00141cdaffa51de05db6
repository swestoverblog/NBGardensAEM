<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.adobe.cq.*" %><%
String name = request.getParameter("name");
String type = request.getParameter("type");
String desc = request.getParameter("desc");
String qty = request.getParameter("qty");
String price = request.getParameter("price");
    
com.adobe.aem.sql.ProductServiceImp ps = new com.adobe.aem.sql.ProductServiceImp();

int myPK = ps.injestProdData(name, type, desc, qty, price) ; 

//Send the data back to the client
JSONWriter writer = new JSONWriter(response.getWriter());
writer.object();
writer.key("pk");
writer.value(myPK);
    
writer.endObject();
%>