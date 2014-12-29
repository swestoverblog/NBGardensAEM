<%--
Draws the top navigation

--%>
<%@include file="/libs/foundation/global.jsp"%><%
%><%@ page import="java.util.Iterator,
        com.day.text.Text,
        com.day.cq.wcm.api.PageFilter,
        com.day.cq.wcm.api.Page,
        com.day.cq.commons.Doctype,
        org.apache.commons.lang.StringEscapeUtils" %><%



// get navigation root page Page 
Page navRootPage = currentPage.getAbsoluteParent(3);

// check to make sure the page exists 
if (navRootPage == null && currentPage != null) {   
    navRootPage = currentPage; 
}

if (navRootPage != null) {
   Iterator<Page> children = navRootPage.listChildren(new PageFilter(request));
%> <ul>  <%
   while (children.hasNext()) {
         Page child = children.next();
%>
         <li>
            <a href="<%= child.getPath() %>.html"> 
            <%= StringEscapeUtils.escapeXml(child.getTitle())%> </a> 
        </li>
<%
    }
%> </ul>  <%
}
%>
