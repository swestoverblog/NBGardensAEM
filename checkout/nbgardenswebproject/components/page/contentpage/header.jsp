<%@include file="/libs/foundation/global.jsp" %>
<div class="header">
    <div class="container_16">
        <div class="grid_8">
            <cq:include path="logo" resourceType="nbgardenswebproject/components/content/logo" />
        </div>
        <div class="grid_8">
            <div class="search_area">  
                <cq:include path="userinfo" resourceType="foundation/components/userinfo" />           
                <cq:include path="toptoolbar" resourceType="foundation/components/toolbar" />
                <div> search </div>
                <div class="clear"></div>
            </div>
        </div>
        <cq:include path="topnav" resourceType="nbgardenswebproject/components/topnav" /> 
     </div>
</div>
