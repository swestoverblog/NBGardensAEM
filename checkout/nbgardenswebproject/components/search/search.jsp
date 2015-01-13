<%@ page import="com.day.cq.wcm.foundation.Search" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="java.util.*" %>
<%@include file="/libs/foundation/global.jsp" %><%

    /* initialize CQ5 WCM Search */
    Search search = new Search(slingRequest);

    /* search form */
%>
<center>
    <form action="<%= currentPage.getPath() %>.html">
        <input size="41" maxlength="2048" name="q" value="<%= StringEscapeUtils.escapeXml(search.getQuery()) %>"/>
        <input value="<%= properties.get("searchButtonText", "search") %>" type="submit" />
    </form>
</center>
<br/><%

    /* process search results */
    Search.Result result = search.getResult();
    
    /* handle no results */
    if (result == null || result.getHits() == null) {
%>
<%= properties.get("noResultsText", "no results")%><%

    /* handle result list */
    } else {
        List<Search.Hit> hits = result.getHits();
        for (Search.Hit hit : hits) {
        	%>
        	<br/><%= hit.getIcon() %><a href="<%= hit.getURL() %>"><%= hit.getTitle() %></a><%        	
        }
%>
<br/><br/><%

        /* pagination */
        List<Search.Page> resultPages = result.getResultPages();
        if (!resultPages.isEmpty()) {
            if (result.getPreviousPage() != null) {
%>
<a href="<%= result.getPreviousPage().getURL() %>"><%= properties.get("previousText", "back")%></a><%

            }
            for (Search.Page resultPage : resultPages) {
                if (resultPage.isCurrentPage()) {
%>
<%= resultPage.getIndex() + 1 %>
<%
                } else {
%>
<a href="<%= resultPage.getURL() %>"><%= resultPage.getIndex() + 1 %></a>
<%
                }
            }
            if (result.getNextPage() != null) {
%>
<a href="<%= result.getNextPage().getURL() %>"><%= properties.get("nextText", "next")%></a>
<%
            }
        }
    }
%>