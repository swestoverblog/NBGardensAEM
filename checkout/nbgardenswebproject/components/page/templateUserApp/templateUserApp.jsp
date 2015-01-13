<%@include file="/libs/foundation/global.jsp" %>
<html>
<head>

</head>
<body>
<h2>This page invokes the getCQUsers method v2</h2>
<%
com.aem.users.SearchUsers user1 = sling.getService(com.aem.users.SearchUsers.class);
com.aem.users.SearchUsers2 user = sling.getService(com.aem.users.SearchUsers2.class);
int x = user.getCQUsers2();
String y = user1.getCQUsers();

%>
 <h3><%= "The return value of the Search Users is: " +y%> -- number is written to the log</h3>  
<h3><%= "The return value of the Search Users is: " +x%> -- number is written to the log</h3>

</body>
</html>