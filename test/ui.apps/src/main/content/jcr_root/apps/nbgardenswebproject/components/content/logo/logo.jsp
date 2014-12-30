<%@include file="/libs/foundation/global.jsp"%><%
%><%@ page import="com.day.text.Text,
                   com.day.cq.wcm.foundation.Image,
                   com.day.cq.commons.Doctype" %><%

    String home = Text.getAbsoluteParent(currentPage.getPath(), 2);
    Resource res = currentStyle.getDefiningResource("fileReference");
    if (res == null) {
        res = currentStyle.getDefiningResource("file");
    }
    %><a href="<%= home %>.html"><%
    log.error("path is:" + currentStyle.getPath());
    if (res == null) {
        %>Home Page Placeholder<%
    } else {
        Image img = new Image(res);
        img.setItemName(Image.NN_FILE, "image");
        img.setItemName(Image.PN_REFERENCE, "imageReference");
        img.setSelector("img");
        img.setDoctype(Doctype.fromRequest(request));
        img.setAlt("Home Page Placeholder");
        img.draw(out);
    }
    %></a>
