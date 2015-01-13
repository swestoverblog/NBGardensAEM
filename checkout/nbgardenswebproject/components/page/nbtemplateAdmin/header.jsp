<%@include file="/libs/foundation/global.jsp" %>
<head>
    <link href="/apps/nbgardenswebproject/components/page/nbtemplate/css/mystyle.css" rel="stylesheet">
</head>
<div class="header" align="center">
    <div class="container_16">
        <!-- Header content for site goes here -->

			<nav class="navbar navbar-default" role="navigation">
				<div class="navbar-header">
					 <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> 

                        <cq:include path="logo" resourceType="nbgardenswebproject/components/content/logo" />

				</div>

				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">

						<li>
							<a href="/content/nb-gardens-web-project/login-page/admin-main-page.html">Home</a>
						</li>
                        <li>
							<a href="/content/nb-gardens-web-project/login-page/admin-main-page/product-list.html">Products</a>
						</li>
                         <li>
							<a href="/content/nb-gardens-web-project/login-page/admin-main-page/custom-product-list.html">Custom Products</a>
						</li>
                          <li>
							<a href="/content/nb-gardens-web-project/login-page/admin-main-page/add-product.html">Add Product</a>
						</li>
                        <!--
						<li class="dropdown">
							 <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown<strong class="caret"></strong></a>
							<ul class="dropdown-menu">
								<li>
									<a href="#">Action</a>
								</li>
								<li>
									<a href="#">Another action</a>
								</li>
								<li>
									<a href="#">Something else here</a>
								</li>
								<li class="divider">
								</li>
								<li>
									<a href="#">Logout</a>
								</li>
								<li class="divider">
								</li>
								<li>
									<a href="#">Logout</a>
								</li>
							</ul>
						</li> -->
					</ul>

					<ul class="nav navbar-nav navbar-right">

		<!--			<form class="navbar-form navbar-left" role="search">
						<div class="form-group">
							<input type="text" class="form-control">
						</div> <button type="submit" class="btn btn-default">Submit</button>
					</form> -->

                        <li>
                            <a href="/content/nb-gardens-web-project/login-page/search.html">Search</a>
						</li>

						<li class="dropdown">
							 <a href="#" class="dropdown-toggle" data-toggle="dropdown">Account<strong class="caret"></strong></a>
							<ul class="dropdown-menu">
							
								<li>
									<a href="#">Settings</a>
								</li>
                                <li>
                                    <a href="/content/nb-gardens-web-project/login-page/help.html">Help</a>
								</li>
								<li class="divider">
								</li>
								<li>
									<a href="/content/nb-gardens-web-project/login-page.html">Logout</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
				
			</nav>
          
		</div>
	</div>
