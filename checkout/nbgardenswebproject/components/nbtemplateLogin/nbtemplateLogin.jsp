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

var test;
   var test2 = null;
       var aDataSet = [
                       ['','','','','',''],
                       ['','','','','','']
                   ];




      $('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
      $('#example').dataTable( {
          "aaData": aDataSet,
           "bDestroy": true,
          "aoColumns": [
              { "sTitle": "ID" },
              { "sTitle": "Name" },
              { "sTitle": "Type" },
              { "sTitle": "Description", "sClass": "center" },
              { "sTitle": "Qty", "sClass": "center" },
              { "sTitle": "Price", "sClass": "center" }
          ]
      } );


    // $('body').hide().fadeIn(5000);

$('#submit').click(function() {
    var failure = function(err) {
      //  $(".main").unmask();
        alert("Unable to retrive data "+err);

    };


    //Get the user-defined values to persist in the database
    var myFirst= $('#first').val() ;
    var myLast= $('#last').val() ;
    var myDescription= $('#description').val() ;
    var myAddress= $('#address').val() ;
     var myId= $('#id').val() ;

    var url = location.pathname.replace(".html", "/_jcr_content.persist.json") + "?first="+ myFirst +"&last="+myLast +"&desc="+myDescription +"&address="+myAddress +"&id="+myId;

    //$(".main").mask("Saving Data...");

    $.ajax(url, {
        dataType: "text",
        success: function(rawData, status, xhr) {
            var data;
            try {
                data = $.parseJSON(rawData);


                //Set the fields in the forum
                $('#custId').val(data.pk);

            } catch(err) {
                failure(err);
            }
        },
        error: function(xhr, status, err) {
            failure(err);
        }
    });
  });


//Get customer data -- called when the submitget button is clicked
//this method populates the data grid with data retrieved from the //Adobe CQ JCR



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

                //Reference the data grid, clear it, and add new records
                //queried from the Adobe CQ JCR


                  var oTable = $('#example').dataTable();
                 oTable.fnClearTable(true);

                 //Loop through this function for each Customer element
                 //in the returned XML
                 $(myXML).find('Product').each(function(){

                    var $field = $(this);
                     var id = $field.find('Id').text();
                    var name = $field.find('Name').text();

                    var type = $field.find('Type').text();
                     var description = $field.find('Description').text(); // window.alert(description);
                     var qty = $field.find('Qty').text();   

                      var price = $field.find('Price').text();   
                     //window.alert(price);
                    //Set the new data
                    oTable.fnAddData( [
                        id,
                       name,
                        type,

                        description,
                         qty,
                    price,]
                    );

                    });

            } catch(err) {
                failure(err);
            }
        },
        error: function(xhr, status, err) {
            failure(err);
        }
    });

 var table = $('#example').DataTable();
 
    $('#example tbody').on( 'click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
                        test = table.row(this).data();
                        test2 = test[0];

                                     //window.alert(test2);
        }
    } );
    $('#button').click( function () {
		if(test2==null)
        {}
        else {
    	if (confirm("Are you sure you want to delted the selected row?") == true) {
			var myID = test2;
       		 //window.alert(test2);
            var url = location.pathname.replace(".html", "/_jcr_content.persist.json") + "?id="+myID;
			$.ajax(url, {
       					 dataType: "text",
       					 success: function(rawData, status, xhr) {
           					 var data;
           					 try {
               				 data = $.parseJSON(rawData);
                			//Set the fields in the forum
               					 $('#custId').val(data.pk);
							} catch(err) {
               				 failure(err);
            				}
        					},
        				error: function(xhr, status, err) {
            				failure(err);
        					}
    		});
               myTest();
    	} else {

        }}


	});
   $('#button2').click( function () {
        table.row('.selected').remove().draw( false );
    } );
}); // end ready
                function myTest() {
                    location.reload(true);
                }

</script>
</head>

<body bgcolor="#e8e8e8">
<div class="wrapper">


    <div id="container">
     <form name="custdata" id="custdata">

   <div>
     <select id="custQuery"  style="visibility: hidden" >
            <option>All Products</option>
        </select>
    </div>
    <div id="dynamic"></div>
    <div class="spacer"></div>

   <div>
      <input type="button" value="Delete Selected"  name="submitget" id="button" value="Submit">
       <input type="button" value="Edit Selected"  name="submitget" id="button2" value="Submit">
    </div>
   </form>

    </div></div>
</body>
</html>
