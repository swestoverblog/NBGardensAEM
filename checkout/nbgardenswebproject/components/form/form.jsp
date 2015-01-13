<%@include file="/libs/foundation/global.jsp"%>
<html>

<head>
	<title>Java Code Geeks Snippets - Pass Parameters to other JSP Page</title>
</head>

<body>

	This is the caller JSP page.
	
	<jsp:include page="Callee.jsp">
	    <jsp:param name="param1" value="value1"/>
	    <jsp:param name="param2" value="value2"/>
	</jsp:include>

</body>
</html>