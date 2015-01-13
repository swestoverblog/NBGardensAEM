<%--
  Copyright 1997-2009 Day Management AG
  Barfuesserplatz 6, 4001 Basel, Switzerland
  All Rights Reserved.

  This software is the confidential and proprietary information of
  Day Management AG, ("Confidential Information"). You shall not
  disclose such Confidential Information and shall use it only in
  accordance with the terms of the license agreement you entered into
  with Day.

  ==============================================================================

  Login component

--%><%
%><%@ page import="com.day.cq.i18n.I18n,
                   com.day.cq.personalization.UserPropertiesUtil,
                   com.day.cq.wcm.api.WCMMode,
                   com.day.cq.wcm.foundation.forms.FormsHelper,
                   com.day.text.Text, org.apache.sling.auth.core.AuthUtil" %>
<%@ page import="org.apache.commons.lang.StringUtils" %>
<%@ page import="com.adobe.granite.security.user.util.AuthorizableUtil" %>
<%@ page import="com.day.cq.security.profile.Profile" %> 
<%@ page import="com.day.cq.security.UserManager" %>
<%@ page import="com.day.cq.security.UserManagerFactory" %>
<%@ page import="com.day.cq.security.User" %>
<%@ page import="com.day.cq.security.Authorizable" %>
<%
%><%@include file="/libs/foundation/global.jsp"%><%
%><%@taglib prefix="personalization" uri="http://www.day.com/taglibs/cq/personalization/1.0" %><%
    String id = Text.getName(resource.getPath());
    I18n i18n = new I18n(slingRequest);

    String action = currentPage.getPath() + "/j_security_check";

    String validationFunctionName = "cq5forms_validate_" + id;
    String alreadySignedInFunctionName = "cq5forms_already_signed_in_" + id;

    String sectionLabel = properties.get("./sectionLabel", String.class);
    if (sectionLabel != null) {
        sectionLabel = i18n.getVar(sectionLabel);
    }
    String usernameLabel = properties.get("./usernameLabel", String.class);
    if (usernameLabel == null) {
        usernameLabel = i18n.get("Username");
    } else {
        usernameLabel = i18n.getVar(usernameLabel);
    }
    String passwordLabel = properties.get("./passwordLabel", String.class);
    if (passwordLabel == null) {
        passwordLabel = i18n.get("Password");
    } else {
        passwordLabel = i18n.getVar(passwordLabel);
    }
    String loginLabel = properties.get("./loginLabel", String.class);
    if (loginLabel == null) {
        loginLabel = i18n.get("Sign In");
    } else {
        loginLabel = i18n.getVar(loginLabel);
    }
    String continueLabel = properties.get("./continueLabel", String.class);
    if (continueLabel == null) {
        continueLabel = i18n.get("Continue");
    } else {
        continueLabel = i18n.getVar(continueLabel);
    }

    String defaultRedirect = FormsHelper.getReferrer(request);
    if (defaultRedirect == null) {
        defaultRedirect = slingRequest.getResourceResolver().map(request, currentPage.getPath());
    }

    // managed URIs should respect sling mapping
    String redirectTo = properties.get("./redirectTo", "");
    if (!StringUtils.isBlank(redirectTo)) {
        redirectTo = slingRequest.getResourceResolver().map(request, redirectTo);
    } else {
        redirectTo = defaultRedirect;
    }

    if( !redirectTo.endsWith(".html")) {
        redirectTo += ".html";
    }

	// alt redirect, this is used for admin
	// managed URIs should respect sling mapping
    String redirectTo2 = properties.get("./redirectTo2", "");
    if (!StringUtils.isBlank(redirectTo2)) {
        redirectTo2 = slingRequest.getResourceResolver().map(request, redirectTo2);
    } else {
        redirectTo2 = defaultRedirect;
    }

    if( !redirectTo2.endsWith(".html")) {
        redirectTo2 += ".html";
    }


    boolean isDisabled = WCMMode.fromRequest(request).equals(WCMMode.DISABLED);

    final boolean isAnonymous = UserPropertiesUtil.isAnonymous(slingRequest);



%><script type="text/javascript">
    function <%=validationFunctionName%>() {
        if (CQ_Analytics) {
            var u = document.forms['<%=id%>']['j_username'].value;
            if (CQ_Analytics.Sitecatalyst) {
                CQ_Analytics.record({
                    event: "loginAttempt",
                    values: {
                        username:u,
                        loginPage:"${currentPage.path}.html",
                        destinationPage:"<%= xssAPI.encodeForJSString(redirectTo) %>",
                        destinationPage2:"<%= xssAPI.encodeForJSString(redirectTo2) %>" //added for an alternative destination
                    },
                    componentPath: '<%=resource.getResourceType()%>'
                });
                if (CQ_Analytics.ClickstreamcloudUI && CQ_Analytics.ClickstreamcloudUI.isVisible()) {
                    return false;
                }
            }
        <% if ( !isDisabled ) { %>
            if (CQ_Analytics.ProfileDataMgr) {
                if (u) {
                    <%-- If we're on an Author instance and the ProfileDataMgr is available then simply have
                         the ProfileData impersonate the new user.  Don't actually change the logged in user
                         on the server.    AdobePatentID="B1393"
                    --%>
                    var loaded = CQ_Analytics.ProfileDataMgr.loadProfile(u);
                    if (loaded) {
                        var url = CQ.shared.HTTP.noCaching("<%= xssAPI.encodeForJSString(redirectTo2) %>");

                        Session session = resourceResolver.adaptTo(Session.class);
                        UserManager userManager = resourceResolver.adaptTo(UserManager.class);
                        /* to get the current user */
                        Authorizable auth = userManager.getAuthorizable(u);
                        /* to get the groups it is member of */
                        Iterator<Group> groups = auth.memberOf();
                        List<Group> users = new ArrayList<Group>();
   						Group tmpUser;
                          while(groups.hasNext())
                        {
							tmpUser = groups.next();
                            users.add(tmpUser);
                        }
                        log.info("checking users 1");
                         //search through list of groups
                        for(int i=0; i < users.size(); i++)
    					{
							Group aUser = users.get(i);
                             //log message
            				log.info("group [{}] found.", aUser.getID());
                            if(aUser.getID() == "nb-user")
                            {
                                url = CQ.shared.HTTP.noCaching("<%= xssAPI.encodeForJSString(redirectTo2) %>");
                            }
                            else if(aUser.getID() == "nb-admin")
                            {
								url = CQ.shared.HTTP.noCaching("<%= xssAPI.encodeForJSString(redirectTo2) %>");
                            }
                         }


                        CQ.shared.Util.load(url);
                    } else {
                        alert("<%=i18n.get("The user could not be found.")%>");
                    }
                    return false;
                }
            }
            return true;    <%-- No client-side solution available; go back to the server. --%>
        <% } else { %>
            if (CQ_Analytics.ProfileDataMgr) {
                CQ_Analytics.ProfileDataMgr.clear();
            }
            return true;    <%-- Always go back to the server ona Publish instance. --%>
        <% } %>
        }
    }
</script>
<%
        if (null != sectionLabel) {
            %><div class="text section"><%= xssAPI.encodeForHTML(sectionLabel) %></div>
<%      }

        String jReason = request.getParameter("j_reason");
        if (null != jReason) {
            %><div class="loginerror"><%=xssAPI.encodeForHTML(i18n.getVar(jReason))%></div>
<%      }

%><form id="<%= xssAPI.encodeForHTMLAttr(id) %>" name="<%= xssAPI.encodeForHTMLAttr(id) %>"
        method="POST" action="<%= xssAPI.getValidHref(action) %>" enctype="multipart/form-data"
        onsubmit="return <%=validationFunctionName%>();">
    <input type="hidden" name="resource" value="<%= xssAPI.encodeForHTMLAttr(redirectTo) %>">
     <input type="hidden" name="resource2" value="<%= xssAPI.encodeForHTMLAttr(redirectTo2) %>">
    <input type="hidden" name="_charset_" value="UTF-8"/>
    <table class="login-form">
        <tr>
            <td class="label"><label for="<%= xssAPI.encodeForHTMLAttr(id + "_username")%>"><%= xssAPI.encodeForHTML(usernameLabel) %></label></td>
            <td><input id="<%= xssAPI.encodeForHTMLAttr(id + "_username")%>"
                       class="<%= FormsHelper.getCss(properties, "form_field form_field_text form_" + id + "_username") %>"
                       name="j_username"/></td>
        </tr>
        <tr>
            <td class="label"><label for="<%= xssAPI.encodeForHTMLAttr(id + "_password")%>"><%= xssAPI.encodeForHTML(passwordLabel) %></label></td>
            <td><input id="<%= xssAPI.encodeForHTMLAttr(id + "_password")%>"
                       class="<%= FormsHelper.getCss(properties, "form_field form_field_text form_" + id + "_password") %>"
                       type="password" autocomplete="off" name="j_password"/></td>
        </tr>
        <tr>
            <td></td>
            <td><input class="form_button_submit" type="submit" value="<%= xssAPI.encodeForHTMLAttr(loginLabel) %>"></td>
        </tr>
    </table>
</form>
<%

%>