<%@ page import="javax.jcr.Node,
    org.apache.sling.api.resource.SyntheticResource" %><%
%><%@include file="/libs/foundation/global.jsp"%><%
    // could be synthetic include
    if (resource instanceof SyntheticResource) {
        SyntheticResource synthetic = (SyntheticResource) resource;
        resource = slingRequest.getResourceResolver().getResource(synthetic.getPath());
        currentNode = resource.adaptTo(Node.class);
        properties = resource.adaptTo(ValueMap.class);
    }
    String title = "";
    boolean hasImage = false;
    title = properties.get("jcr:title", "");
    hasImage = currentNode.hasNode("image") || properties.get("imageReference", "").length() > 0;
    if (title.equals("")) {
        title = resourcePage.getName();
    }
    %><a href="<%= xssAPI.getValidHref(resourcePage.getPath()+".html") %>"><%
    if (hasImage) {
        %><img class="teaser" src="<%= xssAPI.getValidHref(resourcePage.getPath()+".thumbnail.jpg") %>" alt=""><%
    }
    %><b><%= xssAPI.encodeForHTML(title) %></b></a><%
		if ((!properties.get("date", "").equals("")) || (!properties.get("jcr:description", "").equals(""))) {
			%><span><%= properties.get("date", "") %></span><br>
		    <%= xssAPI.encodeForHTML(properties.get("jcr:description", "")) %><br>
		    <%
		}
%>
