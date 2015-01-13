<%@include file="/libs/foundation/global.jsp"%>
<%@ page import="org.apache.sling.commons.json.io.*,com.adobe.cq.*" %><%
    String name = request.getParameter("name");
String type = request.getParameter("type");
String desc = request.getParameter("desc");
String qty = request.getParameter("qty");
String price = request.getParameter("price");
String id = request.getParameter("id");
%>