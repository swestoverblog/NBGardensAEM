<%@include file="/libs/foundation/global.jsp"%>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.4/css/jquery.dataTables.css">
    <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
<meta charset="UTF-8">
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
  background: #FFA9B8;
  border: 1px solid red;

}
</style>
<script>
$(document).ready(function() {

//Get customer data -- called when the submitget button is clicked
//this method populates the data grid with data retrieved from the //Adobe CQ JCR
 $('#button').click( function () {
     var myUser= $('#user').val() ; window.alert(myUser);
     var myPass= $('#pass').val() ; window.alert(myPass);

    var failure = function(err) {
          alert("Unable to retrive data "+err);
      };

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
                                  window.location.replace("nb-gardens-web-project/login-page/admin-main-page.html");
                             }
                             else if(description == "User") {
                                 // window.alert("user group");
                                 window.location.replace("nb-gardens-web-project/login-page/user-main-page.html");
                             }
                             else
                             {
                                 window.alert("incorrect username or password");
                                 //refresh webpage
                             }
                         }
                     }

                    });

            } catch(err) {
                failure(err);
            }
        },
        error: function(xhr, status, err) {
            failure(err);
        }
    });

  } );

}); // end ready
</script>

</head>

<body bgcolor="#e8e8e8">
<div class="wrapper">


    <div id="container">
     <form name="custdata" id="custdata">

   <div>
     <select id="custQuery" style="visibility: hidden" >
            <option>All Users</option>
        </select>
    </div>
    <div id="dynamic"></div>
    <div class="spacer"></div>

   <div>

    </div>
          <div>
<input type="button" value="Delete Selected"  name="submitget" id="button" value="Submit">
    </div>
           <p><input type="text" name="login" value="" placeholder="Username" id="user"></p>
        <p><input type="password" name="password" value="" placeholder="Password" id="pass"></p>
   </form>

    </div></div>
</body>
</html> 