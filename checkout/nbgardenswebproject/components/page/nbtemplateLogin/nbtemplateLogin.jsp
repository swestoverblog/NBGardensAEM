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
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.4/css/jquery.dataTables.css">
    <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>

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
	<script type="text/javascript" src="nbgardenswebproject/components/page/nbtemplate/js/scripts.js"></script>
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
    <style>
#signup .indent label.error {
  margin-left: 0;
}
#signup label.error {
  font-size: 0.8em;
  color: #F00;
  font-weight: bold;
  display: block;
  margin-left: 215px;
}
#signup  input.error, #signup select.error  {

  border: 1px solid red;

}
</style>
    <script>
$(document).ready(function() {

//Get customer data -- called when the submitget button is clicked
//this method populates the data grid with data retrieved from the //Adobe CQ JCR
 $('#button').click( function () {
     var myUser= $('#user').val() ; //window.alert(myUser);
     var myPass= $('#pass').val() ; //window.alert(myPass);

     if(myUser == "") {} else {
         if(myPass == "") {} else {
    //Get the query filter value from drop down control
    var filter=   $('#custQuery').val() ;

    var url = location.pathname.replace(".html", "/_jcr_content.query.json") + "?filter="+ filter;

    $.ajax(url, {
        dataType: "text",
        success: function(rawData, status, xhr) {
            var data;
            try {
                data = $.parseJSON(rawData);


                //Set the fields in the forum
                var myXML = data.xml;

                var loopIndex = 0;
				var x = 0;

                 //Loop through this function for each Customer element
                 //in the returned XML
                 $(myXML).find('User').each(function(){

                    var $field = $(this);
                     var id = $field.find('Id').text();
                     var name = $field.find('Name').text(); //window.alert(name);

                    var type = $field.find('Password').text();
                     var description = $field.find('Group').text();  //window.alert(description);
                     if(name == myUser) {
                         //window.alert("user match");
                         if(type == myPass) {
                             // window.alert("pass match");
                             if(description == "Admin") {
                                 //window.alert("admin group");
                             	//make it so we redirect to a webpage
                                 x=1;
                                  window.location.replace("login-page/admin-main-page.html");
                             }
                             else if(description == "User") {
                                 // window.alert("user group");
                                 x=1;
                                 window.location.replace("login-page/user-main-page.html");
                             }
                         }
                     }

                    });
                if(x==0){
                     myTest();
                }

            } catch(err) {
                failure(err);
            }
        },
        error: function(xhr, status, err) {
            failure(err);
        }
    });
         }}
  } );

}); // end ready
           function myTest() {
                    location.reload(true);
                }
</script>
</head>

    <body>
         <!-- Part 1: Wrap all page content here -->
<div id="wrap" class="container">
   <cq:include script="/libs/wcm/core/components/init/init.jsp"/> 
   <cq:include script="head.jsp" />
   <cq:include script="body.jsp" />
	<form name="custdata" id="custdata">
   		<div>
     		<select id="custQuery" style="visibility: hidden" >
           	 <option>All Users</option>
        	</select>
   		 </div>
           <p align="center"><input type="text" name="login" value="" placeholder="Username" id="user" required></p>
        	<p align="center"><input type="password" name="password" value="" placeholder="Password" id="pass" required></p>
        <div>
            <p align="center"><input type="button" value="Login"  name="submitget" id="button" value="Submit"></p>
   			 </div>
   </form>

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
