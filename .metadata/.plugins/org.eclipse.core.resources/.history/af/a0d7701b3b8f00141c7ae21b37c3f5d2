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
        String test5 = currentStyle.get("topnav", "");
        PageManager p4 = currentPage.getPageManager();
        Page parrent5 = p4.getPage(test5);
		Page navRootPage2 = currentPage.getAbsoluteParent(2);

if(parrent5 == null) {
// check to make sure the page exists 
if (navRootPage2 == null && currentPage != null) {   
    navRootPage2 = currentPage; 
}

if (navRootPage2 != null) {
   Iterator<Page> children7 = navRootPage2.listChildren(new PageFilter(request));
%> <ul>  <%
   while (children7.hasNext()) {
         Page child7 = children7.next();
%>
         <li>
            <a href="<%= child7.getPath() %>.html"> 
            <%= StringEscapeUtils.escapeXml(child7.getTitle())%> </a> 
        </li>
<%
    }
%> </ul>  <%
} }
else {
   Iterator<Page> children20 =parrent5.listChildren(new PageFilter(request));
    %> <ul>  <%
   while (children20.hasNext()) {
	   // get next child page
         Page child20 = children20.next();

	   //display the link in an <A HREF...
%>
         <li>
            <a href="<%= child20.getPath() %>.html"> 
            <%= StringEscapeUtils.escapeXml(child20.getTitle())%> </a> 
        </li>
<%
    }
%> </ul>  <%
}
%>
