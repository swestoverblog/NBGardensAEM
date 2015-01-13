<%@include file="/libs/foundation/global.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>NB Gardens Template</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

	<!--link rel="stylesheet/less" href="less/bootstrap.less" type="text/css" /-->
	<!--link rel="stylesheet/less" href="less/responsive.less" type="text/css" /-->
	<!--script src="js/less-1.3.3.min.js"></script-->
	<!--append ‘#!watch’ to the browser URL, then refresh the page. -->

    <link href="/apps/nbgardenswebproject/components/page/nbtemplate/css/bootstrap.min.css" rel="stylesheet">
	<link href="/apps/nbgardenswebproject/components/page/nbtemplate/css/style.css" rel="stylesheet">

  <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
  <![endif]-->

  <!-- Fav and touch icons -->
  <link rel="apple-touch-icon-precomposed" sizes="144x144" href="img/apple-touch-icon-144-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="114x114" href="img/apple-touch-icon-114-precomposed.png">
  <link rel="apple-touch-icon-precomposed" sizes="72x72" href="img/apple-touch-icon-72-precomposed.png">
  <link rel="apple-touch-icon-precomposed" href="img/apple-touch-icon-57-precomposed.png">
  <link rel="shortcut icon" href="img/favicon.png">

    <script type="text/javascript" src="/apps/nbgardenswebproject/components/page/nbtemplate/js/jquery.min.js"></script>
	<script type="text/javascript" src="/apps/nbgardenswebproject/components/page/nbtemplate/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/apps/nbgardenswebproject/components/page/nbtemplate/js/scripts.js"></script>
    <style type="text/css">

      /* Sticky footer styles
      -------------------------------------------------- */

      html,
      body {
        height: 100%;
        /* The html and body elements cannot have any padding or margin. */
      }

      /* Wrapper for page content to push down footer */
      #wrap {
        min-height: 100%;
        height: auto !important;
        height: 100%;
        /* Negative indent footer by it's height */
        margin: 0 auto -60px;
            background-color: #FAFAFA;

      }

      /* Set the fixed height of the footer here */
      #push,
      #footer {
        height: 60px;
      }

        #footer {
         border-style: solid;
   		 border-color: #8e44ad;
            border-radius: 5px;
       	 background-color: #e8e8e8;
        }
        #container {
			background-color: #e8e8e8;
        }


      /* Lastly, apply responsive CSS fixes as necessary */
      @media (max-width: 767px) {
        #footer {
          margin-left: -20px;
          margin-right: -20px;
          padding-left: 20px;
          padding-right: 20px;
        }
      }


    </style>
</head>

<body>
         <!-- Part 1: Wrap all page content here -->
<div id="wrap" class="container">
   <!--   <cq:include script="/libs/wcm/core/components/init/init.jsp"/> -->
        			<cq:include script="header.jsp"/>
       				 <cq:include script="content.jsp"/>

		<div class="row">
  <div class="col-md-6">
            <cq:include path="par" resourceType="foundation/components/parsys"/> </div>
  <div class="col-md-6">
      <cq:include path="rightpar" resourceType="foundation/components/parsys" /></div>
</div>

		<div id="push"></div>


</div>
    <div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div id="footer">
   					 <cq:include script="footer.jsp" />
				</div>
            </div>
        </div>
    </div>
</body>
</html>
